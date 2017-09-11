//
//  UINavigationController+PopTwice.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit

extension UINavigationController {
    func popTwice(animated: Bool) {
        let vc = viewControllers[viewControllers.count - 3]
        popToViewController(vc, animated: animated)
    }
}
