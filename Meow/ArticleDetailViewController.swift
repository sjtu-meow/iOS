//
//  ArticleDetailViewController.swift
//  Meow
//
//  Created by 林树子 on 2017/7/5.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import RxSwift

class ArticleDetailViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    /* user profile info */
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    @IBOutlet weak var webViewContainer: UIView!
    var webview:ArticleWebView!
    
    var articleId: Int?
    var article: Article?
    
    override func viewDidLoad() {
        webview = ArticleWebView(fromSuperView: webViewContainer)
        loadData()
    }
    
    var content: String?
    var htmlString: String?
    

    
    func configure(article: ArticleSummary) {
        articleId  = article.id
    }
    
    func loadData() {
        guard let id = articleId else { return }
        MeowAPIProvider.shared.request(.article(id: id))
            .mapTo(type: Article.self)
            .subscribe(onNext:{
                [weak self]
                article in
                self?.article = article 
                self?.updateView()
            })
            .addDisposableTo(disposeBag)
        
    }
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func updateView() {
        guard let article = self.article else { return }
        if let content = article.content {
            webview.presentHTMLString(content)
        }
        let profile = article.profile!
        nicknameLabel.text = profile.nickname
        bioLabel.text = profile.bio
        if let avatar = profile.avatar {
            avatarImageView.af_setImage(withURL: avatar)
        }
        
    }
}

