//
//  PKHUDAnimation.swift
//  PKHUD
//
//  Created by Piergiuseppe Longo on 06/01/16.
//  Copyright © 2016 Piergiuseppe Longo, NSExceptional. All rights reserved.
//  Licensed under the MIT license.
//

import Foundation
import QuartzCore

public final class PKHUDAnimation {

    public static let discreteRotation: CAAnimation = {
        let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        animation.values = [NSNumber]()
        animation.keyTimes = [NSNumber]()
        
        for i in 0..<12 {
            animation.values!.append(NSNumber(value: Double(i) * .pi / 6.0))
            animation.keyTimes!.append(NSNumber(value: Double(i) / 12.0)) 
        }
        
        animation.duration = 1.2
        animation.calculationMode = "discrete"
        animation.repeatCount = Float(INT_MAX)
        return animation
    }()

    static let continuousRotation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = 2.0 * .pi
        animation.duration = 1.2
        animation.repeatCount = Float(INT_MAX)
        return animation
    }()
}
