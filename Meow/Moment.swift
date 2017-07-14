//
//  Moment.swift
//  Meow
//
//  Created by 林树子 on 2017/6/30.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Moment: ItemProtocol {
    var id: Int!
    var type: ItemType!
    var profile: Profile!
    var createTime: Date!
    
    var content: String?
    var medias: [Media]?
    var comments: [Comment]?
    
    var likeCount: Int? // FIXME: not empty
    var commentCount: Int?
}

extension Moment: JSONConvertible {
    static func fromJSON(_ json: JSON) -> Moment? {
        let item = Item.fromJSON(json)!
        
        var moment = self.init()
        moment.id = item.id
        moment.type = item.type
        moment.profile = item.profile
        moment.createTime = item.createTime
        
        moment.content <- json["content"]
        moment.medias <- json["medias"]
        moment.comments <- json["comments"]
        
        moment.likeCount <- json["likeCount"]
        moment.commentCount <- json["commentCount"]
        return moment
    }
}


