//
//  Token.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import Foundation

struct Token {
    var access: String
}

private let AccessKey = "AccessKey"

extension Token {
    static func load() -> Token? {
        let defaults = UserDefaults.standard
        let access = defaults.string(forKey: AccessKey)
        if let access = access {
            return Token(access: access)
        }
        return nil
    }
    
    func save() {
        let defaults = UserDefaults.standard
        defaults.set(access, forKey: AccessKey)
    }
}
