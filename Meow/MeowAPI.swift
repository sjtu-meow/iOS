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
    case moment(id: Int)
    case articles
    case article(id: Int)
    case questions
    case question(id: Int)
    case answers
    case answer(id: Int)
    case uploadToken
    case postMoment(content: String, medias: [Media]?)
    case postArticle(title: String, content: String, cover:String)
    case postQuestion(title: String, content: String)
    case postAnswer(questionId: Int, content: String)
    case search(keyword: String)
    
    case myMoments
    case myArticles
    case myQuestions
    case myAnswers
    case myProfile
    
    case myFollowingUsers
    case myFollowingQuestions
    
    case herMoments(id: Int)
    case herArticles(id: Int)
    case herQuestions(id: Int)
    case herAnswers(id: Int)
    case herProfile(id: Int)
    
    case followUser(id: Int)
    case followQuestion(id: Int)
    case unfollowUser(id: Int)
    case unfollowQuestion(id: Int)
    case isFollowingUser(id: Int)
    case isFollowingQuestion(id: Int)
    
    case addFavoriteArticle(id: Int)
    case addFavoriteAnswer(id: Int)
    case removeFavoriteArticle(id: Int)
    case removeFavoriteAnswer(id: Int)
    case isFavoriteArticle(id: Int)
    case isFavoriteAnswer(id: Int)
    
    case likeMoment(id: Int)
    case likeArticle(id: Int)
    case likeAnswer(id: Int)
    
    case unlikeMoment(id: Int)
    case unlikeArticle(id: Int)
    case unlikeAnswer(id: Int)
    
    case isLikedMoment(id: Int)
    case isLikedArticle(id: Int)
    case isLikedAnswer(id: Int)
    
    case myFavorite
    
    case postReport(id: Int, type: ItemType, reason: String)
    
    case updateProfile(profile: Profile)
    
    case postComment(item: ItemProtocol, content: String)
    
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
        case .moment(let id):
            return "/moments/\(id)"
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
        case .postAnswer(let id, _):
            return "/questions/\(id)/answers"
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
        
        case .myAnswers:
            return "/user/answers"
        case .myQuestions:
            return "/user/questions"
        case .myArticles:
            return "/user/articles"
        case .myMoments:
            return "/user/moments"
        case .myProfile:
            return "/user/profile"
            
        case .myFollowingUsers:
            return "/user/following/users"
        case .myFollowingQuestions:
            return "/user/following/questions"
        
            
        case .herAnswers(let id):
            return "/users/\(id)/answers"
        case .herQuestions(let id):
            return "/users/\(id)/questions"
        case .herArticles(let id):
            return "/users/\(id)/articles"
        case .herMoments(let id):
            return "/users/\(id)/moments"
        case .herProfile(let id):
            return "/users/\(id)/profile"
        
        case .followUser(let id):
            return "/users/\(id)/follow"
        case .unfollowUser(let id):
            return "/users/\(id)/follow"
        case .isFollowingUser(let id):
            return "/users/\(id)/follow"
        case .followQuestion(let id):
            return "/questions/\(id)/follow"
        case .unfollowQuestion(let id):
            return "/questions/\(id)/follow"
        case .isFollowingQuestion(let id):
            return "/questions/\(id)/follow"

        case .addFavoriteAnswer(let id):
            return "/answers/\(id)/favorite"
        case .addFavoriteArticle(let id):
            return "/articles/\(id)/favorite"
        case .removeFavoriteAnswer(let id):
            return "/answers/\(id)/favorite"
        case .removeFavoriteArticle(let id):
            return "/articles/\(id)/favorite"
        case .isFavoriteArticle(let id):
            return "/articles/\(id)/favorite"
        case .isFavoriteAnswer(let id):
            return "/answers/\(id)/favorite"
            
        case .likeMoment(let id):
            return "/moments/\(id)/like"
        case .likeAnswer(let id):
            return "/answers/\(id)/like"
        case .likeArticle(let id):
            return "/articles/\(id)/like"
            
        case .unlikeMoment(let id):
            return "/moments/\(id)/like"
        case .unlikeAnswer(let id):
            return "/answers/\(id)/like"
        case .unlikeArticle(let id):
            return "/articles/\(id)/like"
        
        case .isLikedMoment(let id):
            return "/moments/\(id)/like"
        case .isLikedAnswer(let id):
            return "/answers/\(id)/like"
        case .isLikedArticle(let id):
            return "/articles/\(id)/like"
            
        case .myFavorite:
            return "/user/favorite"
            
        case .postReport:
            return "/reports"
        
        case .updateProfile:
            return "/user/profile"
            
        case .postComment(let item, _):
            switch item.type! {
            case .article:
                return "/articles/\(item.id!)/comments"
            case .answer:
                return "/answers/\(item.id!)/comments"
            case .moment:
                return "/moments/\(item.id!)/comments"
            default:
                return ""
        }
        
        }
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
        switch self {
        case .unfollowQuestion, .unfollowUser, .removeFavoriteAnswer, .removeFavoriteArticle, .unlikeAnswer, .unlikeMoment, .unlikeArticle:
            return .delete
        
        case .login,.signup, .postMoment, .postArticle, .postQuestion, .postAnswer, .followQuestion, .followUser, .addFavoriteAnswer, .addFavoriteArticle, .likeAnswer, .likeMoment, .likeArticle, .postReport, .postComment:
            
            return .post
        case .updateProfile:
            return .put
            
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
                "url": $0.url!.absoluteString + "?imageView2/4/w/200/h/200",
                "type": $0.type!.toInt()
            ]}) ?? []
            return ["content": content, "medias": jsonMedias]
        case .postArticle(let title, let content, let cover):
            return ["title": title, "content": content, "cover": cover]
        case .postQuestion(let title, let content):
            return ["title": title, "content": content]
        case .postAnswer( _, let content):
            return ["content": content]
        case .search(let keyword):
            return ["keyword": keyword]
        case .postReport(let id, let type, let reason):
            return ["id": id, "type": type.rawValue, "reason": reason]
        case .updateProfile(let profile):
            return ["avatar": profile.avatar?.absoluteString ?? "", "nickname": profile.nickname ?? "", "bio": profile.bio ?? ""]
        case .postComment(_, let content):
            return ["content": content]
        default:
            return nil
        }
    }

    var sampleData: Data { return Data()  }

    
}
