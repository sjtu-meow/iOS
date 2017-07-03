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
    var title: String!
    var summary: String?
    var readCount: Int!
    var cover: URL?
    var like: Int? // FIXME: not empty
    var comment: Int?
    //content? 
    
}

extension Article: JSONConvertible {
    static func fromJSON(_ json: JSON) -> Article? {
        
        guard let item = Item.fromJSON(json),
            let title = json["title"].string,
            let readCount = json["readCount"].int
            else { return nil }
        
        var article = self.init()
        article.id = item.id
        article.type = item.type
        article.profile = item.profile
        article.title = title
        article.summary <- json["summary"]
        article.readCount = readCount
        article.cover <- json["cover"]
        article.like <- json["like"]
        article.comment <- json["comment"]
        
        return article
    }
    
}



