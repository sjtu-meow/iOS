//
//  Moment.swift
//  Meow
//
//  Created by 林树子 on 2017/6/30.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import Foundation
import SwiftyJSON

enum ItemType: Int {
    case moment = 0, article = 1, question = 2, answer = 3
}

protocol ItemProtocol {
    var id: Int! {get set}
    var type: ItemType! {get set}
    var profile: Profile! {get set}
}


struct Item: ItemProtocol {
    var id: Int!
    var type: ItemType!
    var profile: Profile!
    
}


extension Item: JSONConvertible {
    static func fromJSON(_ json: JSON) -> Item? {
       
        guard let id = json["id"].int,
              let type = json["type"].int,
              let profile = Profile.fromJSON(json["profile"])
            else { return nil }
        
        var item = self.init()
        item.id = id
        item.type = ItemType.init(rawValue: type)
        item.profile = profile
        return item
    }
}