//
//  Observable+MapTo.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import RxSwift
import SwiftyJSON

extension Observable {
    func map <T:JSONConvertible>(to type: T.Type) -> Observable<T?> {
        return map {
            (element) -> T? in
            if let element = element as? JSON {
                return T.fromJSON(element)
            }
            return nil 
        }
    }
}
