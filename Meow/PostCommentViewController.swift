//
//  PostCommentViewController.swift
//  Meow
//
//  Created by 林武威 on 2017/7/21.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit
import RxSwift


class PostCommentViewController: UIViewController {
    let disposeBag = DisposeBag()
    var item: ItemProtocol!
    
    @IBOutlet weak var commentTextField: UITextField!
    override func viewDidLoad() {
        
    }
    
    func configure(model: ItemProtocol) {
        item = model 
    }
    
    @IBAction func postComment(_ sender: Any) {
        let content = commentTextField.text
        MeowAPIProvider.shared.request(.postComment(item: item, content: content!)).subscribe(onNext: {
            [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        })
        .addDisposableTo(disposeBag)
    }
    
}
