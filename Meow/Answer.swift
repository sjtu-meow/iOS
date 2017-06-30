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
    var content: String!
    var questionId: Int!
}

extension Answer: JSONConvertible {
    static func fromJSON(_ json: JSON) -> Answer? {
        guard let item = Item.fromJSON(json),
              let content = json["content"].string,
              let questionId = json["questionId"].int
            else { return nil }
        
        var answer = self.init()
        answer.id = item.id
        answer.type = item.type
        answer.profile = item.profile
        answer.content = content
        answer.questionId = questionId
        
        return answer
    
    }
}
