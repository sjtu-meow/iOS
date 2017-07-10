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
    func addImage() -> (URL, Observable<URL?>)?
}

class RichTextEditor: UIView  {

    @IBOutlet weak var webview: UIWebView!
    var images = [(URL,Observable<URL?>)]()
    
    var delegate: RichTextEditorDelegate?
   
    override func awakeFromNib() {
        loadEditor()
    }
    
    @IBAction func addImage(_ sender: Any) {
        if let result = delegate?.addImage() {
            insertImage(id: "\(images.count)", url: result.0.absoluteString)
            images.append(result)
        }
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
