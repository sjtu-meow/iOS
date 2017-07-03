//
//  LoginViewController.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//


import UIKit
import RxSwift

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    @IBAction func login(_ sender: Any) {
        guard let username = usernameText.text, let password = passwordText.text else { return }
        
        
        
        MeowAPIProvider.shared.request(.login(phone: username, password: password))
            .mapTo(type:Token.self)
            .subscribe(onNext: {
                token in
                token.save()
                MeowAPIProvider.refresh()
            })
            .addDisposableTo(disposeBag)
        //dismiss(animated: true, completion: nil )
    }
    
    @IBAction func signup(_ sender: Any) {
        
    }
}
