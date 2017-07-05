//
//  PostArticleViewController.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit


class PostArticleViewController: UIViewController {
    var htmlString: String {
        get {
            return richTextEditorWebView.stringByEvaluatingJavaScript(from: "document.getElementById('content').innerHTML")!
        }
    }
    var images: [(URL,UIImage,String)]?
    
    @IBOutlet weak var richTextEditorWebView: UIWebView!

    @IBAction func pickImage(_ sender: Any) {
        addImage()
    }
    @IBAction func postArticle(_ sender: Any) {
        checkHTML()
        
        
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        richTextEditorWebView.delegate = self
        
        let editorURL = Bundle.main.url(forResource: "editor", withExtension: "html")!
        richTextEditorWebView.loadRequest(URLRequest(url: editorURL))
        

    }
    
    func addImage() {
        var imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func checkHTML() -> Bool{
        return htmlString.isEmpty
    }
    
}

extension PostArticleViewController: UIWebViewDelegate, UINavigationControllerDelegate {
}

extension PostArticleViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let script = "window.insertImage('1', 'http://lorempixel.com/200/200')"
        richTextEditorWebView.stringByEvaluatingJavaScript(from: script)
        dismiss(animated: true, completion: nil)
        
    }


}

