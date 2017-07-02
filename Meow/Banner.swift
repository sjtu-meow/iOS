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
}

extension Banner: JSONConvertible {
    static func fromJSON(_ json: JSON) -> Banner? {
        guard let url = json["url"].string,
              let itemId = json["itemId"].int
            else { return nil }
        
        var banner = self.init()
        banner.url = url
        banner.itemId = itemId
        
        return banner
    }
}


