//
//  RichTextEditor.swift
//  Meow
//
//  Created by 林武威 on 2017/7/6.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit
import RxSwift

protocol RichTextEditorDelegate {
    func didTapAddImage()
}

class RichTextEditor: UIView  {

    @IBOutlet weak var webview: UIWebView!
    
    var delegate: RichTextEditorDelegate?
   
    override func awakeFromNib() {
        loadEditor()
    }
    
    @IBAction func addImage(_ sender: Any) {
        delegate?.didTapAddImage()
    }
    
    var htmlString: String {
        get {
            return webview.stringByEvaluatingJavaScript(from: "document.getElementById('content').innerHTML")!
        }
    }
    
    
    func insertImage(id: String, url: String) {
        let script = "window.insertImage('\(id)', '\(url)')"
        let _ = webview.stringByEvaluatingJavaScript(from: script)
    }
    
    func loadEditor() {
        let editorURL = Bundle.main.url(forResource: "editor", withExtension: "html")!
        webview.loadRequest(URLRequest(url: editorURL))
    }
    
    func updateImagePath(id: String, url: String ) {
        let scripts = "window.setImagePath('\(id )', '\(url)')"
        let _ = webview.stringByEvaluatingJavaScript(from: scripts)
    }
}
