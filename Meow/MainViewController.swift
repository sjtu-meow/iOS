//
//  MainViewController.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
/*
    override func viewDidLoad() {
        
        delegate = self
        
        var controllers = viewControllers!
        
        var ctrl = UIViewController()
        ctrl.tabBarItem.title = "发布"
        controllers.insert(ctrl, at: 3)
        
        setViewControllers(controllers, animated: false)
    }

*/
    
}


extension MainViewController: UITabBarControllerDelegate {
    
 /*
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.tabBarItem.title == "发布" { // FIXME
            let ctrl = UIViewController(nib: R.nib.postTypePicker)
            present(ctrl, animated: true, completion: nil)
            //let pop  = UIPopoverPresentationController(presentedViewController: ctrl, presenting: nil)
            return false
        }
        return true
    }
 */
   /*
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if tabBar.items?.index(of: item) == 4 {
            tabBar.isHidden = true
        } else {
            tabBar.isHidden = false
        }
    }*/
}
 
