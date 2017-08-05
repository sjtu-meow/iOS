//
//  SearchResultViewController.swift
//  Meow
//
//  Created by 林武威 on 2017/7/11.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit
import RxSwift

class SearchResultViewController: UIViewController {
    var keyword: String!
    var tableView: UITableView!
    var items: [ItemProtocol]?
    
    let disposeBag = DisposeBag()
    
    func configure(keyword: String) {
        self.keyword = keyword
    }
    
    override func viewDidLoad() {
        self.tableView = SearchResultTableView.addTo(superview: self.view)
        tableView.tableFooterView = UIView(frame: CGRect.zero)

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.dataSource = self
        tableView.register(R.nib.questionRecordTableViewCell)
        tableView.register(R.nib.answerRecordTableViewCell)
        tableView.register(R.nib.momentRecordTableViewCell)
        tableView.register(R.nib.articleRecordTableViewCell)
        
        
        loadData()
    }
    
    func loadData() {
        MeowAPIProvider.shared.request(.search(keyword: self.keyword))
            .mapToItems()
            .subscribe(onNext: {
            [weak self]
            items in
            self?.items = items
            self?.tableView.reloadData()
        }).addDisposableTo(disposeBag)
    }
}

extension SearchResultViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.items != nil) ? 1 : 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.items?.count ?? 0
        return count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.items![indexPath.row]
        switch item.type! {
        case .moment:
            let view = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.momentRecordTableViewCell)!
            view.configure(model: item as! Moment)
            return view
        
        case .answer:
            let view = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.answerRecordTableViewCell)!
            view.configure(model: item as! AnswerSummary)
            return view
            
        case .article:
            let view = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.articleRecordTableViewCell)!
            view.configure(model: item as! ArticleSummary)
            return view
            
        case .question:
            let view = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.questionRecordTableViewCell)!
            view.configure(model: item as! QuestionSummary)
            return view 
        }
    }
}
