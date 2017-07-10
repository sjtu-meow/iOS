//
//  PostArticleViewController.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit


class PostArticleViewController:UIViewController {
   

    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var editorContainer: UIView!
    var editor: RichTextEditor!
    
    @IBAction func postArticle(_ sender: Any) {
        checkHTML()
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editor = R.nib.richTextEditor.firstView(owner: self)
        editorContainer.addSubview(editor)
    }
    
    func addImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func checkHTML() -> Bool{
        return editor.htmlString.isEmpty
    }
    
}

extension PostArticleViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        
    }


}

