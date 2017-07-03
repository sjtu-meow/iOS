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
    var answersId: [Int]?
    var like: Int? // FIXME: not empty
    var comment: Int?
    
}

extension Question: JSONConvertible {
    static func fromJSON(_ json: JSON) -> Question? {
        guard let item = Item.fromJSON(json),
            let title = json["title"].string,
            let content = json["content"].string
            else { return nil }
        
        var question = self.init()
        question.id = item.id
        question.type = item.type
        question.profile = item.profile
        question.title = title
        question.content = content
        question.answersId <- json["answersId"]
        question.like <- json["like"]
        question.comment <- json["comment"]
        
        return question
    }
}


