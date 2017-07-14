//
//  Answer.swift
//  Meow
//
//  Created by 林武威 on 2017/7/12.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import SwiftyJSON

struct Answer: ItemProtocol {
    var id: Int!
    var type: ItemType!
    var profile: Profile!
    var createTime: Date!
    
    var questionId: Int!
    var content: String!
    
    var likeCount: Int?
    var commentCount: Int?
    var comments: [Comment]?
}

extension Answer: JSONConvertible {
    static func fromJSON(_ json: JSON) -> Answer? {
        let item = Item.fromJSON(json)!
        
        var answer = Answer.init()
        answer.id = item.id
        answer.type = item.type
        answer.profile = item.profile
        answer.createTime = item.createTime
        
        answer.questionId <- json["questionId"]
        answer.content <- json["content"]
        
        answer.likeCount <- json["likeCount"]
        answer.commentCount <- json["commentCount"]
        answer.comments <- json["comments"]
        
        return answer
    }
}
