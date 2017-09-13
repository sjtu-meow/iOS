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
        
        
        //dismiss(animated: true, completion: nil )
        
        MeowAPIProvider.shared.request(.login(phone: username, password: password))
            .mapTo(type:Token.self)
            .subscribe(onNext: {
                [weak self]
                token in
                token.save()
                MeowAPIProvider.refresh()
                self?.dismiss(animated: true, completion: nil )
                }, onError: {
                    [weak self]
                    e in
                    let alert = UIAlertController(title: "登录失败", message: "用户名或密码错误", preferredStyle: UIAlertControllerStyle.alert)
                    let alertAction = UIAlertAction(title: "好", style: UIAlertActionStyle.default)
                    {
                        (UIAlertAction) -> Void in
                    }
                    alert.addAction(alertAction)
                    self?.present(alert, animated: false, completion: nil)
            })
            .addDisposableTo(disposeBag)
        }
    
    @IBAction func signup(_ sender: Any) {
        
    }
}
