//
//  ArticleViewController.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit
import SwiftyJSON
import RxSwift
import Rswift

class ArticleViewController: UITableViewController {
    
    var articles: [ArticleSummary]?
    
    let disposeBag = DisposeBag()
    
    private func loadArticles(){
        MeowAPIProvider.shared.request(.articles).mapTo(arrayOf: ArticleSummary.self)
            .subscribe(onNext:{
                [weak self]
                (articles) in
        
                self?.articles = articles
                self?.tableView.reloadData()
            })
        .addDisposableTo(disposeBag)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadArticles()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let view = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.articlePageTableViewCell.identifier)!
        if let article = self.articles?[indexPath.row]{
            (view as! ArticlePageTableViewCell).configure(model: article)
        }
        return view
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let path = tableView.indexPathForSelectedRow!,
        article = articles![path.row]
        /*
        if segue.identifier == R.segue.articleViewController.articleToArticleDetailSegue.identifier {
            let navController = segue.destination as! UINavigationController,
            target = navController.topViewController as! ArticleDetailViewController
            target.configure(article: article)
            
        }
 */
        
    }
}

