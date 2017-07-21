//
//  ArticleSummary.swift
//  Meow
//
//  Created by 林武威 on 2017/7/5.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import DateToolsSwift
import SwiftyJSON


struct ArticleSummary: ItemProtocol {
    var id: Int!
    var type: ItemType!
    var profile: Profile!
    var createTime: Date!
    
    /* article info */
    var cover: URL?
    var title: String!
    var summary: String?
    
    /* like & comment */
    var likeCount: Int!
    var commentCount: Int!   //FIXME: not null?
}


extension ArticleSummary: JSONConvertible {
    static func fromJSON(_ json: JSON) -> ArticleSummary? {
        let item = Item.fromJSON(json)!
        
        var articleSummary = self.init()
        
        articleSummary.id = item.id
        articleSummary.type = item.type
//        articleSummary.profile = item.profile
        articleSummary.createTime = item.createTime
        
        articleSummary.cover <- json["cover"]
        articleSummary.title <- json["title"]
        articleSummary.summary <- json["summary"]
        
        articleSummary.likeCount <- json["likeCount"]
        articleSummary.commentCount <- json["commentCount"]
        
        return articleSummary
    }
}
