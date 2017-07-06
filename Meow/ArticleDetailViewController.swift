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

class ArticleDetailViewController: UIViewController {
    
    /* user profile info */
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    @IBOutlet weak var webViewContainer: UIView!
    var webview:ArticleWebView!
    
    override func viewDidLoad() {
        webview = ArticleWebView(fromSuperView: webViewContainer)
        loadArticle()
    }
    
    var content: String?
    var htmlString: String?
    
    func loadArticle() {
        webview.presentHTMLString("???")
    }
}

