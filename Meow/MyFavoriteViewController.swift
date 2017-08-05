//
//  MyFavoriteViewController.swift
//  Meow
//
//  Created by 林武威 on 2017/7/20.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit
import RxSwift

class MyFavoriteViewController: UITableViewController {
    let disposeBag = DisposeBag()
    var items = [ItemProtocol]()
    
    override func viewDidLoad() {
        tableView.tableFooterView = UIView(frame: CGRect.zero)

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.register(R.nib.articleUserPageTableViewCell)
        tableView.register(R.nib.answerTableViewCell)
        
        loadData()
    }
    
    func loadData() {
        MeowAPIProvider.shared 
            .request(.myFavorite)
            .mapToItems()
            .subscribe(onNext: {
                [weak self]
                items in
                self?.items.append(contentsOf: items)
                self?.tableView.reloadData()
            })
            .addDisposableTo(disposeBag)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count 
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.items[indexPath.row]
        if item is ArticleSummary {
            let view = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.articleUserPageTableViewCell)!
            view.configure(model: item as! ArticleSummary)
            return view
        } else if item is AnswerSummary {
            let view = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.answerTableViewCell)!
            view.configure(model: item as! AnswerSummary)
            return view
            
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.items[indexPath.row]
        ArticleDetailViewController.show(item, from: self)
    }
}
