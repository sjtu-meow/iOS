//
//  Token.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import Foundation

struct Token {
    var access, refresh: String
}

private let AccessKey = "AccessKey", RefreshKey = "RefreshKey"

extension Token {
    static func load() -> Token? {
        let defaults = UserDefaults.standard
        let access = defaults.string(forKey: AccessKey), refresh = defaults.string(forKey: RefreshKey)
        if let access = access, let refresh = refresh {
            return Token(access: access, refresh: refresh)
        }
        return nil 
    }
    
    func save() {
        let defaults = UserDefaults.standard
        defaults.set(access, forKey: AccessKey)
        defaults.set(refresh, forKey: RefreshKey)
    }
}
