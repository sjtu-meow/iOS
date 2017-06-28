//
//  LoginViewController.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//


import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    
    @IBAction func login(_ sender: Any) {
        let username = usernameText.text, password = passwordText.text
    
        dismiss(animated: true, completion: nil )
    }
    
    @IBAction func signup(_ sender: Any) {
        
    }
}
