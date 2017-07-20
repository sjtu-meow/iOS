//
//  Banner.swift
//  Meow
//
//  Created by 林树子 on 2017/6/30.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import SwiftyJSON
struct Banner {
    var url: String!
    var itemId: Int!
    var itemType: ItemType!
}

extension Banner: JSONConvertible {
    static func fromJSON(_ json: JSON) -> Banner? {
        guard   let url = json["image"].string,
                let itemId = json["itemId"].int,
                let rawType = json["itemType"].int,
                let itemType = ItemType(rawValue: rawType)
            else { return nil }
        
        var banner = self.init()
        banner.url = url
        banner.itemId = itemId
        banner.itemType = itemType
        
        return banner
    }
}


