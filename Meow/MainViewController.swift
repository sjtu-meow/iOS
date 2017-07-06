//
//  MainViewController.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit


class MainViewController: UITabBarController {
    var backImage: UIImage!
    var previousIndex: Int?
    

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
        previousIndex = tabgBarController.selectedIndex

        if tabBarController.viewControllers?.index(of: viewController) == 3 {
            //backImage = blurImage(targetImage: snapView(targetView: tabBarController.view))
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
            if previousIndex == 4 {
                viewController.view.backgroundColor = UIColor.white
            }
            else if previousIndex != 3 {
                viewController.view.backgroundColor = UIColor(patternImage: backImage)
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
    
    func blurImage(targetImage: UIImage) -> UIImage {
        let ciImage = CIImage(image: targetImage)
        let filter = CIFilter(name: "CIGaussianBlur")!
        //filter.setDefaults()
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        let resultImage = filter.value(forKey: kCIOutputImageKey) as! CIImage
        let context = CIContext()
        let cgImage = context.createCGImage(resultImage, from: resultImage.extent)!
        
        let blurredImage = UIImage(cgImage:cgImage)
        //let blurredImage = UIImage(ciImage: resultImage)
        return blurredImage
        
        

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
 
