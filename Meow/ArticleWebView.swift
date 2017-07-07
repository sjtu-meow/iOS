//
//  ArticleWebView.swift
//  Meow
//
//  Created by 林树子 on 2017/7/5.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit
import WebKit

protocol ArticleWebViewDelegate : WKNavigationDelegate, WKUIDelegate {
}


class ArticleWebView: WKWebView {
    var heightChangingHandler:((CGFloat)->Void)?
    var contentHeight:CGFloat = 40 //default as 40, will change as content change
    weak var delegate: ArticleWebViewDelegate?
    
    convenience init(fromSuperView superView: UIView) {
        self.init()
        self.scrollView.isScrollEnabled = false
        self.translatesAutoresizingMaskIntoConstraints = false
        superView.addSubview(self)
        
    
        self.topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        self.leftAnchor.constraint(equalTo: superView.leftAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: superView.rightAnchor).isActive = true
 
 }
    
    init() {
        super.init(frame: CGRect(x:0,y:0,width:100,height:200), configuration: WKWebViewConfiguration())
        self.navigationDelegate = self
        self.uiDelegate = delegate
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.navigationDelegate = self
        self.uiDelegate = delegate
    }
    
    func getContentHeight(cont:@escaping ((CGFloat) -> ())) {
        self.evaluateJavaScript("document.body.scrollHeight") { (val, err) in
            let height:CGFloat = val as? CGFloat ?? 1.0
            cont(100.0)
        }
    }
    
    
    func updateHeight() {
        getContentHeight { [weak self] (height) in
            if self?.contentHeight != height {
                self?.contentHeight = height
                self?.heightChangingHandler?(height)
            }
        }
 
    }
    
    func presentHTMLString(_ body:String) {
        
        
        /*
         <html>
         <head>
         <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, shrink-to-fit=no" /> //no scale
         <style type="text/css">
         img {
         max-width: 95vw !important;
         object-fit: contain !important;
         } //fit image to 95% device width
         * {
         width: auto !important;
         word-wrap:break-word;
         } //remove width attributes in any element
         </style>
         </head>
         <body>\(body)</body>
         </html>
         */
        
        let formattedBody =
        "<html><head><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, shrink-to-fit=no\" /><style type=\"text/css\"> img { max-width: 95vw !important; object-fit: contain !important; }  * { width: auto !important; word-wrap:break-word !important; } </style></head><body>\(body)</body></html>"
        
        
        self.loadHTMLString(formattedBody, baseURL: nil)
    }
}


extension ArticleWebView : WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.cancel)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        updateHeight()
        delegate?.webView?(webView, didFinish: navigation)
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        updateHeight()
        delegate?.webView?(webView, didCommit: navigation)
    }
}

