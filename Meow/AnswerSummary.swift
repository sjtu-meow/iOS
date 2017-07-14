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
        var answerJson = json["answer"]
        let item = Item.fromJSON(answerJson)!
        
        var answerSummary = self.init()
        
        answerSummary.id = item.id
        answerSummary.type = item.type
        answerSummary.profile = item.profile
        answerSummary.createTime = item.createTime
        
        answerSummary.questionId <- json["questionId"]
        answerSummary.questionTitle <- json["questionTitle"]
        
        answerSummary.content <- answerJson["content"]
        
        answerSummary.likeCount <- answerJson["likeCount"]
        answerSummary.commentCount <- answerJson["commentCount"]
       
        return answerSummary
    }
}
