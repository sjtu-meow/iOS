//
//  PostTypePickerViewController.swift
//  Meow
//
//  Created by 林武威 on 2017/7/4.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit

class PostTypeViewController: UIViewController {

    class func show(from viewController: UIViewController) {
        let vc = R.storyboard.main.postTypePickerViewController()!
 
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func postMoment(_ sender: Any) {
        let vc = R.storyboard.postPages.postMomentController()!
        navigationController!.pushViewController(vc, animated: true)
    }
    
    @IBAction func postArticle(_ sender: Any) {
        let vc = R.storyboard.postPages.postArticleController()!
        navigationController!.pushViewController(vc, animated: true)
    } 
    
    @IBAction func postQuestion(_ sender: Any) {
        let vc = R.storyboard.postPages.postQuestionController()!
        navigationController!.pushViewController(vc, animated: true)
    }
    
}
