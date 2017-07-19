//
//  article.swift
//  Meow
//
//  Created by 林树子 on 2017/6/30.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import SwiftyJSON


struct Article: ItemProtocol {
    var id: Int!
    var type: ItemType!
    var profile: Profile!
    var createTime: Date!
    
    var cover: URL?
    var title: String!
    var summary: String?
    var content: String?
    
    var likeCount: Int!
    var commentCount: Int!
    var comments: [Comment]!
}

extension Article: JSONConvertible {
    static func fromJSON(_ json: JSON) -> Article? {
        let item = Item.fromJSON(json)!
        
        var article = self.init()
        
        article.id = item.id
        article.type = item.type
        article.profile = item.profile
        article.createTime = item.createTime
        
        article.cover <- json["cover"]
        article.title <- json["title"]
        article.summary <- json["summary"]
        article.content <- json["content"]

        article.likeCount <- json["likeCount"]
        article.commentCount <- json["commentCount"]
        article.comments <- json["comments"]
        
        return article
    }
    
}



