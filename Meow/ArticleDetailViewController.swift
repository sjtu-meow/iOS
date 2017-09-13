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
    class func show(_ item: ItemProtocol, from viewController: UIViewController) {
        let vc = R.storyboard.articlePage.articleDetailViewController()!
        
        vc.itemId = item.id
        vc.itemType = item.type
        
        viewController.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    let disposeBag = DisposeBag()

    @IBOutlet weak var scrollView: UIScrollView!
    //@IBOutlet weak var webviewCell: UITableViewCell!
    /* user profile info */
    @IBOutlet weak var avatarImageView: AvatarImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!

    @IBOutlet weak var webViewContainer: UIView!
    var webview: ArticleWebView!

    var itemId: Int?
    var itemType: ItemType?
    var item: ItemProtocol?
    var bottomBar: UITabBar!

    // FIXME
    var isLiked = false, isFavorite = false

    override func viewDidLoad() {
        webview = ArticleWebView(fromSuperView: webViewContainer)

        webview.heightChangingHandler = {
            [weak self] height in
            self?.scrollView.contentSize.height = height + 50
        }


        bottomBar = R.nib.itemDetailButtomBar.firstView(owner: self) as! UITabBar
        view.addSubview(bottomBar)

        bottomBar.translatesAutoresizingMaskIntoConstraints = false
        bottomBar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        bottomBar.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        bottomBar.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        bottomBar.topAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true

        bottomBar.delegate = self
        
        avatarImageView.delegate = self
        
        initBottomBarStyle()
        loadData()

    }

    var content: String?
    var htmlString: String?


    func configure(id: Int, type: ItemType) {
        self.itemId = id
        self.itemType = type
    }

    func loadData() {
        guard let id = itemId else {
            return
        }

        let observer = {
            [weak self]
            (item:ItemProtocol) -> Void in
            self?.item = item
            self?.updateView()
        }
        
        if (self.itemType == .article) {
            MeowAPIProvider.shared.request(.article(id: id))
                .mapTo(type: Article.self)
                .subscribe(onNext: observer)
                .addDisposableTo(disposeBag)
        } else { // answer
            MeowAPIProvider.shared.request(.answer(id: id))
            .mapTo(type: Answer.self)
                .subscribe(onNext: observer)
                .addDisposableTo(disposeBag)

        }
    }

    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    func updateView() {
        var content: String!
        if itemType! == .article {
            let article = item as! Article
            content = article.content!
            self.navigationItem.title = article.title
        } else if itemType! == .answer {
            let answer  = item as! Answer
            content = answer.content!
        }
        webview.presentHTMLString(content)
        
        let profile = item!.profile!
        nicknameLabel.text = profile.nickname
        bioLabel.text = profile.bio
        avatarImageView.configure(model: profile)
    }

    func showCommentView() {
        let vc = R.storyboard.main.commentViewController()!
        guard let article = self.item else {
            return
        }
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
                .request(.postReport(id: itemId!, type: .article, reason: message))
                .subscribe(onNext: {  _ in
                    HUD.flash(.labeledSuccess(title: "举报成功", subtitle: nil))
                }).addDisposableTo(disposeBag)

    }

    func share() {
        didTapShareButton()
    }

    func initBottomBarStyle() {
        bottomBar.tintColor = UIColor.gray
        MeowAPIProvider.shared
                .request(.isFavoriteArticle(id: itemId!))
                .subscribe(onNext: {
                    [weak self]
                    json in
                    self?.isFavorite = (json as! JSON)["favourite"].bool!
                    self?.updateFavoriteLabel()
                })
                .addDisposableTo(disposeBag)

        MeowAPIProvider.shared
                .request(.isLikedArticle(id: itemId!))
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
            toggleLike()
            updateLikeLabel()
        case 2:
            toggleFavorite()
            updateFavoriteLabel()
        case 3:
            showMoreMenu()
        default: break
        }

    }

    func toggleFavorite() {
        let isFavorite = self.isFavorite
        let request = isFavorite ? MeowAPI.removeFavoriteArticle(id: itemId!) :MeowAPI.addFavoriteArticle(id: itemId!)
        MeowAPIProvider.shared.request(request)
                .subscribe(onNext: {
                    [weak self]
                    _ in
                    self?.isFavorite = !isFavorite
                    self?.updateFavoriteLabel()
                })
                .addDisposableTo(disposeBag)
    }

    func toggleLike() {
        let isLiked = self.isLiked
        let request = isLiked ? MeowAPI.unlikeArticle(id: itemId!) : MeowAPI.likeArticle(id: itemId!)
        MeowAPIProvider.shared.request(request)
                .subscribe(onNext: {
                    [weak self]
                    _ in
                    self?.isLiked = !isLiked
                    self?.updateLikeLabel()
                })
                .addDisposableTo(disposeBag)
    }

    func didTapShareButton() {
        
        guard let item = self.item else { return }
        let dict = NSMutableDictionary()
        if item.type! == .article {
            let article = item as! Article
            let title = "来自喵喵喵的文章：\(article.title!)"
            var images: [URL] = []
            if let cover = article.cover {
                images.append(cover)
            }
            dict.ssdkSetupShareParams(
                byText: title,
                images: images,
                url: URL(string: "http://106.14.156.19"),
                title: title,
                type: SSDKContentType.text
            )
        } else { // .answer 
            let answer = item as! Answer
            
            dict.ssdkSetupShareParams(
                byText: title,
                images: [],
                url: URL(string: "http://106.14.156.19"),
                title: title,
                type: SSDKContentType.text
            )
        }
        
        
        ShareSDK.showShareActionSheet(nil, items: nil, shareParams: dict) { (state, _, _, _, _, _) in
            print(state)
        }
    }
}

extension ArticleDetailViewController: AvatarCellDelegate {
    func didTapAvatar(profile: Profile) {
        if let userId = UserManager.shared.currentUser?.userId, userId == profile.userId {
            MeViewController.show(from: navigationController!)
        } else {
            UserProfileViewController.show(profile, from: self)
        }
    }
}
