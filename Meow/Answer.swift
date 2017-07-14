//
//  Answer.swift
//  Meow
//
//  Created by 林武威 on 2017/7/12.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import SwiftyJSON

struct Answer: ItemProtocol {
    var createTime: Date!

    var id: Int!
    var type: ItemType!
    var profile: Profile!
    
    var likeCount: Int?
    var commentCount: Int?
    var content: String!
}

extension Answer: JSONConvertible {
    static func fromJSON(_ json: JSON) -> Answer? {
        guard let item = Item.fromJSON(json) else { return nil }
        var answer = Answer()
        answer.id = item.id
        answer.type = item.type
        answer.profile = item.profile
        answer.likeCount <- json["likeCount"]
        answer.commentCount <- json["commentCount"]
        answer.content <- json["content"]
        return answer
    }
}
