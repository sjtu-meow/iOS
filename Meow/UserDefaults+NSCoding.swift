//
//  UserDefaults+NSCoding.swift
//  Meow
//
//  Created by 林树子 on 2017/7/10.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit

extension UserDefaults {
    func setCustomObject(_ value: NSCoding, forKey key: String) {
        let data = NSKeyedArchiver.archivedData(withRootObject: value)
        self.set(data, forKey: key)
    }
    
    func customObject(forKey key: String) -> Any? {
        if let data = self.data(forKey: key) {
            let obj = NSKeyedUnarchiver.unarchiveObject(with: data)
            return obj
        }
        return nil
    }
    
}

