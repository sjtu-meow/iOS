//
//  HomeViewController.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit
import RxSwift

class HomeViewController: UITableViewController {
    let disposeBag = DisposeBag()
    
    var banners: [Banner]?
    
    var items: [ItemProtocol]?
    
    override func viewDidLoad() {
       
        let vc = R.storyboard.postPages.postMomentNavigationController()

        present(vc!, animated: true, completion: nil)
        logger.log("hello world")
        COSProvider.shared.upload(path: "logger.txt", filename: "log", directory: "/")
    }
}
