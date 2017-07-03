//
//  Token.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import SwiftyJSON

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

extension Token: JSONConvertible {
    static func fromJSON(_ json: JSON) -> Token? {
        guard let token = json["token"].string else { return nil }
        return Token(access: token)
    }
}
