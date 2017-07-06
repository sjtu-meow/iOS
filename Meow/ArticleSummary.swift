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
    var id: Int!
    var title: String?
    var cover: String?
    var profile: Profile?
    var likeCount: Int?
    var commentCount: Int?
    var createTime: Date?
}


extension ArticleSummary: JSONConvertible {
    static func fromJSON(_ json: JSON) -> ArticleSummary? {
        guard let id = json["id"].int else { return nil }
        var article = ArticleSummary()
        
        article.id = id
        article.cover <- json["cover"]
        article.title <- json["title"]
        article.profile = Profile.fromJSON(json["profile"])
        article.likeCount <- json["likeCount"]
        article.commentCount <- json["commentCount"]
        
        // TODO: format of date ??
        return article
    }
}
