//
//  MyArticleViewController.swift
//  Meow
//
//  Created by 林武威 on 2017/7/18.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit
import RxSwift

class MyArticleViewController: UITableViewController {
    var items = [ArticleSummary]()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        tableView.register(R.nib.articleProfilePageTableViewCell)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        loadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = items[indexPath.row]
        let view = tableView.dequeueReusableCell(withIdentifier: R.nib.articleProfilePageTableViewCell.identifier)! as!ArticleProfilePageTableViewCell
        view.configure(model: article)

        return view
    }

    func loadData() {
        MeowAPIProvider.shared
            .request(.myArticles)
            .mapTo(arrayOf: ArticleSummary.self)
            .subscribe(onNext:{
                [weak self]
                items in
                self?.items.append(contentsOf: items)
                self?.tableView.reloadData()
            })
            .addDisposableTo(disposeBag)
    }
}
