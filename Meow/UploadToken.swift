//
//  UploadToken.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import SwiftyJSON

struct UploadToken {
    var token: String!
    var expireTime: TimeInterval?
}

extension UploadToken: JSONConvertible {
    
    
    static func fromJSON(_ json: JSON) -> UploadToken? {
        guard let token = json["token"].string else {return nil}
    
        var uploadToken = UploadToken(token: token, expireTime: nil)
        
        uploadToken.expireTime <- json["expireTime"]
        return uploadToken
    }
    
    func isExpired() -> Bool {
        let now = NSDate().timeIntervalSince1970
        return (expireTime != nil) ? (now - expireTime! >= 0) : false
    }
}
