//
//  Profile.swift
//  Meow
//
//  Created by 林树子 on 2017/6/30.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//


import SwiftyJSON

struct Profile{
    //var id: Int?
    var nickname: String?
    var bio: String?
    var avatar: String?
    var userId: Int!
}

extension Profile: JSONConvertible{
    static func fromJSON(_ json: JSON) -> Profile? {
        guard let userId = json["userId"].int
            else{ return nil}
        
        var profile = self.init()
        profile.nickname <- json["nickname"]
        profile.bio <- json["bio"]
        profile.avatar <- json["avatar"]
        profile.userId = userId
        return profile
    }
}
