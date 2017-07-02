//
//  Media.swift
//  Meow
//
//  Created by 林武威 on 2017/6/30.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//


import SwiftyJSON

enum MediaType: Int {
    case Image = 0, Video = 1
}

struct Media {
    var type: MediaType?
    var thumbnail: URL?
    var url: URL?
}

extension Media: JSONConvertible {
    static func fromJSON(_ json: JSON) -> Media? {
        var media = self.init()
        guard let type = json["type"].int else { return nil}
        
        media.type = MediaType.init(rawValue: type)
        media.url <- json["url"]
        media.thumbnail <- json["thumbnail"]
        return media
    }
}
