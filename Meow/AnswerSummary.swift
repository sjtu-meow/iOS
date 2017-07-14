//
//  Answer.swift
//  Meow
//
//  Created by 林树子 on 2017/6/30.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import SwiftyJSON

struct AnswerSummary: ItemProtocol {
    var id: Int!
    var type: ItemType!
    var profile: Profile!
    var createTime: Date!
    
    var questionId: Int!
    var questionTitle: String?
    
    var content: String!
    
    var likeCount: Int!
    var commentCount: Int!
    
}

extension AnswerSummary: JSONConvertible {
    static func fromJSON(_ json: JSON) -> AnswerSummary? {
        var answer = self.init()
        let answerJson = json["answer"]
        guard let item = Item.fromJSON(answerJson) else { return nil }
        
        answer.id = item.id
        answer.type = item.type
        answer.profile = item.profile
        
        answer.questionTitle <- json["questionTitle"]
        answer.questionId <- json["questionId"]
        
        answer.content <- answerJson["content"]
        
        answer.likeCount <- answerJson["likeCount"]
        answer.commentCount <- answerJson["commentCount"]
       
        return answer
    }
}
