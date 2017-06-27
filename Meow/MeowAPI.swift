//
//  MeowAPI.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import Moya

enum MeowAPI  {
    case moments
}

extension MeowAPI: TargetType {
    var base: String { return "http://meow.io/api" }
    
    var baseURL: URL { return URL(string: base)! }
    
    public var task: Task {
        return .request
    }
    
    var path: String {
        switch self {
            
        case .moments:
            return "/moments"
        }
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method { return .get }

    public var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var parameters: [String: Any]? { return nil  }
    
    var sampleData: Data { return Data()  }

    
}
