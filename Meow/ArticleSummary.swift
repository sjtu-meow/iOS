//
//  ArticleSummary.swift
//  Meow
//
//  Created by 林武威 on 2017/7/5.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import DateToolsSwift
import SwiftyJSON

struct ArticleSummary {
//    /* user profile info */
//    var id: Int!
//    var type: ItemType!
//    var profile: Profile!
    
    /* article info */
    var id: Int!
    var title: String!
    var cover: URL?
    var readCount: Int?
    var createTime: Date?
    
    /* like & comment */
    var like: Int?
    var comment: Int?   //FIXME: not null?
}


extension ArticleSummary: JSONConvertible {
    static func fromJSON(_ json: JSON) -> ArticleSummary? {
        guard let title = json["title"].string
            else { return nil }

        var articleSummary = self.init()
        
        articleSummary.id <- json["id"]
        articleSummary.title = title
        articleSummary.cover <- json["cover"]
        articleSummary.readCount <- json["readCount"]
         // TODO: format of date ??
        articleSummary.readCount <- json["createTime"]
        
        articleSummary.like <- json["likeCount"]
        articleSummary.comment <- json["commentCount"]
        
       
        return articleSummary
    }
}
