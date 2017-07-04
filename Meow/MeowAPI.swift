//
//  MeowAPI.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import Moya

enum MeowAPI  {
    case moments
    case signup(phone: String, password: String, validationCode: String )
    case login(phone: String, password: String)
    case banners
    case homepage // api?
    case articles
    case questions
    case uploadToken
    case postMoment(content: String, medias: [Media]?)

}

extension MeowAPI: TargetType {
    var base: String { return "http://localhost:8080/api" }
    
    var baseURL: URL { return URL(string: base)! }
    
    public var task: Task {
        return .request
    }
    
    var path: String {
        switch self {
        case .homepage:
            return "/homepage"
        case .moments:
            return "/moments"
        case .questions:
            return "/questions" //which one? question for homepage or ?
        case .login:
            return "/auth"
        case .signup:
            return "/signup"
        case .banners:
            return "/banners"
        case .articles:
            return "/articles"
        case .uploadToken:
            return "/upload/token"
        case .postMoment:
            return "/moments"
        }
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
        switch self {
        case .login,.signup, .postMoment:
            return .post
        default:
            return .get
        }
    }

    public var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .login(let phone, let password):
            return ["phone": phone, "password": password]
        case .signup(let phone, let password, let validationCode):
            return ["phone": phone, "password": password, "code": validationCode]
        case .postMoment(let content, let medias):
            let jsonMedias = (medias?.map{[
                "url": $0.url!.absoluteString,
                "type": $0.type!.toInt()
            ]}) ?? []
            return ["content": content, "medias": jsonMedias]
        
        default:
            return nil
        }
    }

    var sampleData: Data { return Data()  }

    
}
