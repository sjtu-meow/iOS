//
//  QuestionSummary.swift
//  Meow
//
//  Created by 林武威 on 2017/7/18.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import SwiftyJSON

struct QuestionSummary: ItemProtocol {
    var id: Int!
    var profile: Profile!
    var type: ItemType!
    var createTime: Date!
    
    var title: String!
    var answerCount: Int!
}

extension QuestionSummary: JSONConvertible {
    static func fromJSON(_ json: JSON) -> QuestionSummary? {
        let item = Item.fromJSON(json)!
        
        var question = self.init()
        question.id = item.id
        question.type = item.type
        question.profile = item.profile
        question.createTime = item.createTime

        question.title <- json["title"]
        question.answerCount <- json["answerCount"]
        
        return question
    }
}



