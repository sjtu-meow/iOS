 //
//  Comment.swift
//  Meow
//
//  Created by 林武威 on 2017/7/7.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import SwiftyJSON
import DateToolsSwift

struct Comment {
    var id: Int!
    var createTime: Date!
    var parent: Int!
    var content: String!
    
    var profile: Profile!
}

extension Comment: JSONConvertible {
    static func fromJSON(_ json: JSON) -> Comment? {
        var comment = Comment()
        comment.id <- json["id"]
        comment.createTime <- json["createTime"]
        comment.parent <- json["parent"]
        comment.content <- json["content"]
        let profile = Profile.fromJSON("profile")
        comment.profile = profile
        return comment
    }
}
