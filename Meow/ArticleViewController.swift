//
//  ArticleViewController.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit
import SwiftyJSON
import RxSwift

class ArticleViewController: UITableViewController {
    
    var articles: [Article]?
    
    let disposeBag = DisposeBag()
    
    private func loadArticles(){
        MeowAPIProvider.shared.request(.articles).mapTo(arrayOf: Article.self)
            .subscribe(onNext:{
                [weak self]
                (articles) in
                self?.articles = articles
            })
        .addDisposableTo(disposeBag)
    }
}

