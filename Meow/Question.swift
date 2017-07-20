//
//  Question.swift
//  Meow
//
//  Created by 林树子 on 2017/6/30.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import SwiftyJSON

struct Question: ItemProtocol {
    var id: Int!
    var type: ItemType!
    var profile: Profile!
    var createTime: Date!
    
    var title: String!
    var content: String!
    var answers: [Answer]?
    
    var likeCount: Int!
    var commentCount: Int!
}

extension Question: JSONConvertible {
    static func fromJSON(_ json: JSON) -> Question? {
        let item = Item.fromJSON(json)!

        var question = self.init()
        question.id = item.id
        question.type = item.type
        question.profile = item.profile
        question.createTime = item.createTime
        
        question.title <- json["title"]
        question.content <- json["content"]
        question.answers <- json["answers"]
        
        question.likeCount <- json["likeCount"]
        question.commentCount <- json["commentCount"]
        
        return question
    }
}


