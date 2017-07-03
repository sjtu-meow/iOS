//
//  SignupController.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//


import UIKit
import AVOSCloud
import PKHUD

class SignupViewController: UIViewController {
    
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var confirmText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var verificationText: UITextField!
    @IBOutlet weak var verifyButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
   
    // Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    
    
    var countdown: Int = 5
    var timer: Timer!
    @IBAction func getVerificationCode(_ sender: Any) {
        verifyButton.isEnabled = false
        countdown = 5
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
        AVSMS.sendValidationCode(phoneNumber: "15821883353") {
            (succeeded, error) in
            
        }
    }
    
    func updateCounter(){
        if countdown == 0 {
            timer.invalidate()
            verifyButton.isEnabled = true
            
        }
        else{
            countdown -= 1
            verifyButton.setTitle("\(countdown)秒后点击重发", for: UIControlState.disabled)
            
        }
        
    }
    
    @IBAction func signup(_ sender: Any) {
        guard let username = usernameText.text,
              let password = passwordText.text,
              let confirm = confirmText.text,
              let phone = phoneText.text,
              let verificationCode = verificationText.text
        else  {return}
        
        //verify confirm & password consistency
        if password != confirm{
            HUD.flash(.labeledError(title: "密码输入不一致", subtitle: nil), delay: 1)
            return
        }
        
        
        //verify verfication code
        AVOSCloud.verifySmsCode(verificationCode, mobilePhoneNumber: phone){(succeeded, error) in
            if succeeded{
            }
            else{
                HUD.flash(.labeledError(title: "短信验证码错误", subtitle: nil), delay: 1)
                return
            }
            }
        
        

        
    }
}
