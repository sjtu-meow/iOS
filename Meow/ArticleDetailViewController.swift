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
    
    @IBOutlet weak var scrollView: UIScrollView!
    //@IBOutlet weak var webviewCell: UITableViewCell!
    /* user profile info */
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    @IBOutlet weak var webViewContainer: UIView!
    var webview:ArticleWebView!
    
    var articleId: Int?
    var article: Article?
    var bottomBar: UITabBar!
    
    override func viewDidLoad() {
        
        webview = ArticleWebView(fromSuperView: webViewContainer)
        
        //automaticallyAdjustsScrollViewInsets = false
        
        
        webview.heightChangingHandler = {
            [weak self] height in
            self?.scrollView.contentSize.height = height
        }
        
        
        bottomBar = R.nib.itemDetailButtomBar.firstView(owner: self) as! UITabBar
        view.addSubview(bottomBar)
        
        bottomBar.translatesAutoresizingMaskIntoConstraints = false
        bottomBar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        bottomBar.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        bottomBar.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive=true
        bottomBar.topAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive=true
        
        bottomBar.delegate = self
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
        webview.presentHTMLString(article.content!)
        //webview.load(URLRequest(url:(URL(string:"https://tongqu.me"))!))
    }
    
    func showCommentView() {
        let vc =  R.storyboard.main.commentViewController()! 
        guard let article = self.article else { return }
        vc.configure(model: article)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ArticleDetailViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch tabBar.items!.index(of: item)! {
        case 1:
            self.showCommentView()
        default:
            return
        }
        
    }
}

