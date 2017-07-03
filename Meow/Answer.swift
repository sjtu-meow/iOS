//
//  Answer.swift
//  Meow
//
//  Created by 林树子 on 2017/6/30.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import SwiftyJSON

struct Answer: ItemProtocol {
    var id: Int!
    var type: ItemType!
    var profile: Profile!
    
    var questionTitle: String?
    var content: String!
    //var questionId: Int!
    var like: Int?  // FIXME: not empty
    var comment: Int?
}

extension Answer: JSONConvertible {
    static func fromJSON(_ json: JSON) -> Answer? {
        guard let item = Item.fromJSON(json),
              let content = json["content"].string
              //let questionId = json["questionId"].int
              //let like = json["like"].int,
              //let comment = json["comment"].int
            
            else { return nil }
        
        var answer = self.init()
        answer.id = item.id
        answer.type = item.type
        answer.profile = item.profile
        
        answer.questionTitle <- json["questionTitle"]
        answer.content = content
        // answer.questionId = questionId
        answer.like <- json["like"]
        answer.comment <- json["comment"]
        
        return answer
    
    }
}
