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
    case article(id: Int)
    case questions
    case question(id: Int)
    case answers
    case answer(id: Int)
    case uploadToken
    case postMoment(content: String, medias: [Media]?)
    case postArticle(title: String, content: String)
    case postQuestion(title: String, content: String)
    case search(keyword: String)
}

extension MeowAPI: TargetType {
    var base: String { return "http://106.14.156.19/api" }
    
    var baseURL: URL { return URL(string: base)! }
    
    public var task: Task {
        return .request
    }
    
    var path: String {
        switch self {
        case .homepage:
            return "/homepage"
        case .moments, .postMoment:
            return "/moments"
        case .questions, .postQuestion:
            return "/questions" //which one? question for homepage or ?
        case .question(let id):
            return "/questions/\(id)"
        case .answers:
            return "/answers"
        case .answer(let id):
            return "/answers/\(id)"
        case .login:
            return "/auth"
        case .signup:
            return "/signup"
        case .banners:
            return "/banners"
        case .articles, .postArticle:
            return "/articles"
        case .article(let id):
            return "/articles/\(id)"
        case .uploadToken:
            return "/upload/token"
        case .search:
            return "/search"
        }
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
        switch self {
        case .login,.signup, .postMoment, .postArticle, .postQuestion:
            return .post
        default:
            return .get
        }
    }

    public var parameterEncoding: ParameterEncoding {
        switch self {
        case .search:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
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
        case .postArticle(let title, let content):
            return ["title": title, "content": content]
        case .postQuestion(let title, let content):
            return ["title": title, "content": content]
        case .search(let keyword):
            return ["keyword": keyword]
        default:
            return nil
        }
    }

    var sampleData: Data { return Data()  }

    
}
