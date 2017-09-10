//
//  ChatKitUser.swfit.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import ChatKit


final class ChatKitUser: NSObject,  LCCKUserDelegate {
    func encode(with aCoder: NSCoder) {
        
    }
    
    init?(coder aDecoder: NSCoder) {
        
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return zone as Any
    }
    
    
    var userId: String!
    
    var name: String!
    
    var avatarURL: URL!
    
    var clientId: String!
    
    open class func from(profile: Profile) -> ChatKitUser {
        let id = "\(profile.userId)"
        let user = ChatKitUser(userId: id, name: profile.nickname, avatarURL: profile.avatar)
        return user
    }
    
    static func user(withUserId userId: String!, name: String!, avatarURL: URL!, clientId: String!) -> ChatKitUser {
        return ChatKitUser(userId: userId, name: name, avatarURL: avatarURL)
    }
    
    
    required init(userId: String!, name: String!, avatarURL: URL!) {
        self.userId = userId
        self.name = name
        self.avatarURL = avatarURL
    }
    
    required init(userId: String!, name: String!, avatarURL: URL!, clientId: String!) {
        self.userId = userId
        self.name = name
        self.avatarURL = avatarURL
        self.clientId = clientId
    }
    
    
    required init(clientId: String!) {
        self.userId = clientId
    }
}
