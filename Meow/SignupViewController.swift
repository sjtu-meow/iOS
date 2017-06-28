//
//  SignupController.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//


import UIKit
import AVOSCloud

class SignupViewController: UIViewController {
    
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var confirmText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var verificationText: UITextField!
    @IBOutlet weak var verifyButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    
    @IBAction func getVerificationCode(_ sender: Any) {
        AVSMS.sendValidationCode(phoneNumber: "15821883353", callback: nil)
        
    }
    
    @IBAction func signup(_ sender: Any) {
        let username = usernameText.text,
            password = passwordText.text,
            confirm = confirmText.text,
            phone = phoneText.text,
            verify = verificationText.text
        dismiss(animated: true, completion: nil)
    }
}
