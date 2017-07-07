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

class ArticleDetailViewController: UITableViewController {
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
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        webview = ArticleWebView(fromSuperView: webViewContainer)
        
        //loadData()
        webview.load(URLRequest(url:URL(string:"http://sjtu.edu.cn")!))
        
        webview.heightChangingHandler = {
            [weak self] height in
            if let that = self {
                that.tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .none)
            }
        }
        webview.updateHeight()
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 0
        }
        return 100
        //return UITableViewAutomaticDimension
    }
    
}

