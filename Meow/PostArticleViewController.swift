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
    var question: Question?
    
    @IBAction func postArticle(_ sender: Any) {
        checkHTML()
        
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        // self.navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let question = self.question {
            self.navigationItem.title = "添加回答"
            self.titleTextField.text = question.title
        }
        
        // Add observer for keyboard apperance
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    
        // Add editor
        editor = R.nib.richTextEditor.firstView(owner: self)
        editorContainer.addSubview(editor)
        
        // Add constraint to editor subview
        editor.translatesAutoresizingMaskIntoConstraints = false;
        let topConstraint = NSLayoutConstraint(item: editor, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: editorContainer, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        let buttomConstraint = NSLayoutConstraint(item: editor, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: editorContainer, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        let leadingConstraint = NSLayoutConstraint(item: editor, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: editorContainer, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: editor, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: editorContainer, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        
        editorContainer.addConstraints([topConstraint, buttomConstraint, leadingConstraint, trailingConstraint])
    }
    
    func configure(question: Question) {
        self.question = question
        
    }
    
    func keyboardWillShow(notification: NSNotification) {
        //FIXME: change add image button's position according to keyboard apperance
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            editorContainer.frame.size.height -= keyboardSize.height
//        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        //FIXME: change add image button's position according to keyboard apperance
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            editorContainer.frame.size.height += keyboardSize.height
//        }
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

