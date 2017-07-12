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
    var title: String!
    var content: String!
    var likeCount: Int?
    var commentCount: Int?
    var answers: [Answer]?
    
}

extension Question: JSONConvertible {
    static func fromJSON(_ json: JSON) -> Question? {
        
        var question = self.init()
        question.id <- json["id"]
        question.type = .question
        question.profile = Profile.fromJSON(json["profile"])
        question.title <- json["title"]
        question.content <- json["content"]
        question.likeCount <- json["likeCount"]
        question.commentCount <- json["commentCount"]
        question.answers <- json["answers"]
        
        return question
    }
}


