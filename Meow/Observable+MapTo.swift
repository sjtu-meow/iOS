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
    func map <T:JSONConvertible>(to type: T.Type) -> Observable<T> {
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
    
    func mapTo<T: JSONConvertible>(arrayOf classType: T.Type) -> Observable<[T]> {
        return self.map {
            (element) -> [T] in
            guard let array = element as? [AnyObject], let jsonArray = array as? [JSON] else {
                throw MeowError.badData
            }
            
            do {
                let models = try jsonArray.map {
                    (jsonElement) -> T in
                    guard let model = T.fromJSON(jsonElement) else {
                        throw MeowError.badCast
                    }
                    return model
                }
            
                return models
            }
        }
    }

}
