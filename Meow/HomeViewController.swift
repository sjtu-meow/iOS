//
//  HomeViewController.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit
import RxSwift

class HomeViewController: UITableViewController {
    let disposeBag = DisposeBag()
    
    var banners: [Banner]?
    
    var items: [ItemProtocol]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
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
            })
            .addDisposableTo(disposeBag)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 /* banners */ + (items?.count ?? 0) /* items */
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 /* banners: one cell */ {
            return 1
        }
        /* items: content + comments */
        return 1 // TODO: add comment cells
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0 {
            return tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.bannerCell.identifier)!
        }
        let item = self.items![indexPath.section - 1]
        
        // FIXME: check whether it is a comment cell
        switch(item.type!) {
        case .moment:
            return tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.momentCell.identifier)!
        case .answer:
            return tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.answerCell.identifier)!
        case .artical:
            return tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.articleCell.identifier)!
        case .question:
            return tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.questionCell.identifier)!
        }
    }
}
