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
    var content: String?
    var medias: [Media]?
}

extension Moment: JSONConvertible {
    static func fromJSON(_ json: JSON) -> Self? {
        guard let item = Item.fromJSON(json)
            else { return nil }
        
        var moment: Moment
        moment.id = item.id
        moment.type = item.type
        moment.profile = item.profile
        moment.content <- json["content"]
        moment.medias <- json["medias"]
        return moment
    }
}


