//
//  HomeViewController.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit
import RxSwift
import Rswift

class HomeViewController: UITableViewController {
    let bannerViewIdentifier = "bannerViewCell"
    
    let disposeBag = DisposeBag()
    
    var banners = [Banner]()
    
    var currentPage = 0
    
    var items = [ItemProtocol]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        loadData()
        
    let vc = R.storyboard.articlePage.articleDetailViewController()

        // let vc = R.storyboard.loginSignupPage.loginViewController()
        
         present(vc!, animated: true, completion: nil)
        //logger.log("hello world")
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
    
        tableView.register(R.nib.bannerViewCell)
        tableView.register(R.nib.momentHomePageTableViewCell)
        tableView.register(R.nib.answerHomePageTableViewCell)
        tableView.register(R.nib.questionHomePageTableViewCell)
        tableView.register(R.nib.articleHomePageTableViewCell)
    }
       
    

    func loadData() {
       MeowAPIProvider.shared.request(.banners)
            .mapTo(arrayOf: Banner.self)
            .subscribe(onNext: {
                [weak self] (banners) in
                self?.banners = banners
            })
            .addDisposableTo(disposeBag)
        

      loadMore()
        MeowAPIProvider.shared.request(.moments)    // FIXME: need to support other item types
            .mapTo(arrayOf: Moment.self)
            .subscribe(onNext: {
                [weak self] (items) in
                self?.items = items
                self?.tableView.reloadData()
            })
            .addDisposableTo(disposeBag)        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 /* banners */ + 1 /* items */
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 /* banners: one cell */ {
            return 1
        }
        /* item sections: one cell for each item */
        return self.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /* banners */
        if indexPath.section == 0 {
            let view = tableView.dequeueReusableCell(withIdentifier: R.nib.bannerViewCell.identifier)!
            (view as! BannerViewCell).configure(banners: self.banners)
            return view
        }
        
        /* items */
        let item = self.items[indexPath.row]
        
        // FIXME: check whether it is a comment cell
        switch(item.type!) {
        case .moment:
            let view = tableView.dequeueReusableCell(withIdentifier: R.nib.momentHomePageTableViewCell.identifier)!
            (view as! MomentHomePageTableViewCell).configure(model: item as! Moment)
            return view
        case .answer:
            let view = tableView.dequeueReusableCell(withIdentifier: R.nib.answerHomePageTableViewCell.identifier)!
            (view as! AnswerHomePageTableViewCell).configure(model: item as! Answer)
            return view
        case .article:
            let view = tableView.dequeueReusableCell(withIdentifier: R.nib.articleHomePageTableViewCell.identifier)!
            (view as! ArticleHomePageTableViewCell).configure(model: item as! Article)
            return view
        case .question:
            let view = tableView.dequeueReusableCell(withIdentifier: R.nib.questionHomePageTableViewCell.identifier)!
            (view as! QuestionHomePageTableViewCell).configure(model: item as! Question)
            return view
        }
    }
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        guard section == 1 else { return }
        loadMore()
    }
    
    func loadMore() {
        MeowAPIProvider.shared.request(.moments) // FIXME: need to support other item types
            .mapTo(arrayOf: Moment.self)
            .subscribe(onNext: {
                [weak self] (items) in
                self?.items = items // FIXME
                self?.tableView.reloadData()
                self?.currentPage += 1
            })
            .addDisposableTo(disposeBag)
    }
}
