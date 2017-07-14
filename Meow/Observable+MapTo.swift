//
//  Observable+MapTo.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import RxSwift
import SwiftyJSON

enum MeowError: String {
    case badCast, badData
}

extension MeowError: Swift.Error { }

extension Observable {
    func mapTo<T: JSONConvertible>(type: T.Type) -> Observable<T> {
        return map {
            (element) -> T in
            
            guard let json = element as? JSON else {
                throw MeowError.badData
            }
            guard let model = T.fromJSON(json) else {
                throw MeowError.badCast
            }
            return model
        }
    }

    func mapTo<T: JSONConvertible>(arrayOf type: T.Type) -> Observable<[T]> {
        return self.map {
            (element) -> [T] in
            guard let json = element as? JSON else {
                throw MeowError.badData
            }
            let array = json.arrayValue
            return array.flatMap {
                (jsonElement) -> T? in
                T.fromJSON(jsonElement)
            }
        }
    }
    
    func mapToItems() -> Observable<[ItemProtocol]> {
        return self.map {
            (element) -> [ItemProtocol] in
            guard let json = element as? JSON else {
                throw MeowError.badData
            }
            let array = json.arrayValue
            return array.flatMap {
                (jsonElement) -> ItemProtocol? in
                guard let item = Item.fromJSON(jsonElement)
                    else { return nil }
                switch item.type! {
                    case .moment:
                        return Moment.fromJSON(jsonElement)
                    case .article:
                        return ArticleSummary.fromJSON(jsonElement)
                    case .question:
                        return Question.fromJSON(jsonElement)
                    case .answer:
                        return AnswerSummary.fromJSON(jsonElement)
                
                }
                
            }
        }
        
    }
        


}
