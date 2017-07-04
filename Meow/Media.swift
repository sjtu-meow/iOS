//
//  Media.swift
//  Meow
//
//  Created by 林武威 on 2017/6/30.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//


import SwiftyJSON

enum MediaType: String {
    case Image = "Image", Video = "Video"
    
    func toInt() -> Int {
        switch self {
        case .Image:
            return 0
        case .Video:
            return 1
        }
    }
}

struct Media {
    var type: MediaType?
    var url: URL?
}

extension Media: JSONConvertible {
    static func fromJSON(_ json: JSON) -> Media? {
        var media = self.init()
        guard let type = json["type"].string else { return nil}
        
        media.type = MediaType.init(rawValue: type)
        media.url <- json["url"]
        return media
    }
}
