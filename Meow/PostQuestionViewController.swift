//
//  PostQuestionViewController.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit
import RxSwift

class PostQuestionViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var contentTextField: UITextView!
    
    override func viewDidLoad() {
        contentTextField.textContainer.lineBreakMode = .byWordWrapping
    }
    @IBAction func cancel(_ sender: Any) {
        navigationController?.popTwice(animated: true)
    }
    @IBAction func postQuestion(_ sender: Any) {
        guard let title = titleTextField.text, let content = contentTextField.text
            else { return }
        MeowAPIProvider.shared.request(.postQuestion(title: title, content: content))
            .subscribe(onNext: {
                [weak self]
                _ in
                self?.navigationController!.popTwice(animated: true)
            })
        .addDisposableTo(disposeBag)
    }
    
}
