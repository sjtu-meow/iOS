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

}

extension MeowAPI: TargetType {
    var base: String { return "http://localhost:8080" }
    
    var baseURL: URL { return URL(string: base)! }
    
    public var task: Task {
        return .request
    }
    
    var path: String {
        switch self {
            
        case .moments:
            return "/moments"
        case .login:
            return "/login"
        case .signup:
            return "/signup"
        case .banners:
            return "/banners"
        
        
        }
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
        switch self {
        case .login,.signup:
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
            return ["phone": phone, "password": password, "validationCode": validationCode]
        default:
            return nil
        }
    }

    var sampleData: Data { return Data()  }

    
}
