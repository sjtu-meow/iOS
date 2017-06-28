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
    
   
    var countdown = 60
    var timer: Timer!
    @IBAction func getVerificationCode(_ sender: Any) {
        verifyButton.isEnabled = false
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        timer.fire()
        AVSMS.sendValidationCode(phoneNumber: "15821883353") {
            (succeeded, error) in
            
        }
        
    }
    
    func updateCounter(){
        if countdown == 0 {
            countdown = 60
            timer.invalidate()
            
            verifyButton.isEnabled = true
            verifyButton.titleLabel?.text = "获取验证码"
        }
        else{
            countdown -= 1
            verifyButton.titleLabel?.text = "\(countdown)秒后点击重发"
    
        }
        
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
