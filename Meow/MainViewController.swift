//
//  MainViewController.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit


class MainViewController: UITabBarController {
    var backImage: UIImage?
    

    override func viewDidLoad() {
        delegate = self
//        var controllers = viewControllers!
//        
//        var ctrl = UIViewController()
//        ctrl.tabBarItem.title = "发布"
//        controllers.insert(ctrl, at: 3)
//        
//        setViewControllers(controllers, animated: false)
    }


    
}


extension MainViewController: UITabBarControllerDelegate {
    
 
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if tabBarController.selectedIndex == 4 {
            backImage = nil
        }
        else if tabBarController.viewControllers?.index(of: viewController) == 3 {
            backImage = snapView(targetView: tabBarController.view)
        }
        
        

        
        return true
//        if viewController.tabBarItem.title == "发布" { // FIXME
//            let ctrl = UIViewController(nib: R.nib.postTypePicker)
//            present(ctrl, animated: true, completion: nil)
//            //let pop  = UIPopoverPresentationController(presentedViewController: ctrl, presenting: nil)
//            return false
//        }
//        return true
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController){
        if tabBarController.viewControllers?.index(of: viewController) == 3 {
            if let backImage = backImage {
                viewController.view.backgroundColor = UIColor(patternImage: backImage)
            }
            else {
                viewController.view.backgroundColor = UIColor.white
            }
        }

    }
    
    func snapView(targetView: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(targetView.bounds.size, false, 0)
        targetView.drawHierarchy(in: targetView.bounds, afterScreenUpdates: false)
        let snapdImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snapdImage!
    }
    
//
//   
//    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        if tabBar.items?.index(of: item) == 4 {
//            tabBar.isHidden = true
//        } else {
//            tabBar.isHidden = false
//        }
//    }
    
    
}
 
