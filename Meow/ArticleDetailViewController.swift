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
import SwiftyJSON
import PKHUD

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
    
    // FIXME
    var isLiked = false, isFavorite = false
    
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
        initBottomBarStyle()
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
    
    func showMoreMenu() {
        var alert: UIAlertController!
        alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
        let reportAction = UIAlertAction(title: "举报", style: UIAlertActionStyle.default) {
            _ in
            self.report()
        }
        let shareAction = UIAlertAction(title: "分享", style: UIAlertActionStyle.default) {
            _ in
            self.share()
        }

        alert.addAction(cancelAction)
        alert.addAction(reportAction)
        alert.addAction(shareAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    func report() {
        let alert = UIAlertController(title: "举报", message: "请输入举报内容", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "好", style: .default) { (action) in
            self.sendReport(message: alert.textFields![0].text!)
        }
        alert.addTextField(configurationHandler: nil)
        ok.isEnabled = true
        
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    func sendReport(message: String) {
        MeowAPIProvider.shared
            .request(.postReport(id: articleId!, type: .article, reason: message))
            .subscribe(onNext: { [weak self] _ in
                 HUD.flash(.labeledSuccess(title: "举报成功", subtitle: nil))
            }).addDisposableTo(disposeBag)
    
    }
    
    func share() {
        didTapShareButton()
    }
    
    func initBottomBarStyle() {
        bottomBar.tintColor = UIColor.gray
        MeowAPIProvider.shared
            .request(.isFavoriteArticle(id: articleId!))
            .subscribe(onNext: {
            [weak self]
            json in
                self?.isFavorite = (json as! JSON)["favourite"].bool!
                self?.updateFavoriteLabel()
            })
            .addDisposableTo(disposeBag)
        
        MeowAPIProvider.shared
            .request(.isLikedArticle(id: articleId!))
            .subscribe(onNext: {
                [weak self]
                json in
                self?.isLiked = (json as! JSON)["liked"].bool!
                self?.updateLikeLabel()
            
            })
            .addDisposableTo(disposeBag)
        
    }
    
    func updateLikeLabel() {
        bottomBar.items![0].title = isLiked ? "已赞" : "赞"
    }
    
    func updateFavoriteLabel() {
        bottomBar.items![2].title = isFavorite ? "已收藏" : "收藏"
    }
    
}

extension ArticleDetailViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch tabBar.items!.index(of: item)! {
        case 1:
            self.showCommentView()
        case 0:
            if !isLiked {
                MeowAPIProvider.shared.request(.likeArticle(id: articleId!))
                .subscribe(onNext: { [weak self] _ in self?.isLiked = true}).addDisposableTo(disposeBag)
            } else {
                MeowAPIProvider.shared.request(.unlikeArticle(id: articleId!))
                .subscribe(onNext: { [weak self] _ in self?.isLiked = false}).addDisposableTo(disposeBag)
            }
            
            updateLikeLabel()
        case 2:
            if !isFavorite {
                MeowAPIProvider.shared.request(.addFavoriteArticle(id: articleId!)).subscribe(onNext: {[weak self] _ in self?.isFavorite = true}).addDisposableTo(disposeBag)
            } else {
                MeowAPIProvider.shared.request(.removeFavoriteArticle(id: articleId!)).subscribe(onNext: {[weak self] _ in self?.isFavorite = false}).addDisposableTo(disposeBag)
            }
            updateFavoriteLabel()
        case 3:
            showMoreMenu()
        default: break
        }
        
    }
    
    func didTapShareButton() {
        
        guard let article = self.article else { return }
        let empty = ""
        let dict = NSMutableDictionary()
        let title = "来自喵喵喵的文章：\(article.title!)"
        dict.ssdkSetupShareParams(
            byText: title,
            images: "",
            url: URL(string: "baidu.com"),
            title: title,
            type: SSDKContentType.text)
        
        ShareSDK.showShareActionSheet(nil, items: nil, shareParams: dict) { (state, _, _, _, _, _) in
            print(state)
        }

    }
}

