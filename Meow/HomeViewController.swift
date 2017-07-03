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
    let disposeBag = DisposeBag()
    
    var banners: [Banner]?
    
    var items: [ItemProtocol]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        loadData()
        
        // let vc = R.storyboard.loginSignupPage.loginViewController()
        
        // present(vc!, animated: true, completion: nil)
        //logger.log("hello world")
        
        tableView.register(BannerViewCell.self, forCellReuseIdentifier: "bannerViewCell")
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
        
        MeowAPIProvider.shared.request(.moments) // FIXME: need to support other item types
            .mapTo(arrayOf: Moment.self)
            .subscribe(onNext: {
                [weak self] (items) in
                self?.items = items
                self?.tableView.reloadData()
            })
            .addDisposableTo(disposeBag)
        
        

        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 /* banners */ + ((items != nil) ? 1 : 0) /* items */
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 /* banners: one cell */ {
            return 1
        }
        /* item sections: one cell for each item */
        return self.items?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /* banners */
        if indexPath.section == 0 {
            let view = tableView.dequeueReusableCell(withIdentifier: "bannerViewCell")!
            //(view as! BannerViewCell).configure(banners: self.banners)
            return view
        }
        
        /* items */
        let item = self.items![indexPath.row]
        
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
}
