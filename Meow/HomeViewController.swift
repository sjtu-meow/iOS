//
//  HomeViewController.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {
    override func viewDidLoad() {
       let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
        present(vc!, animated: true, completion: nil)
        logger.log("hello world")
        COSProvider.shared.upload(path: "logger.txt", filename: "log", directory: "/")
    }
}
