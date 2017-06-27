//
//  Networking.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Alamofire

class MeowAPIProvider {
    open static var shared: MeowAPIProvider = MeowAPIProvider()

    static func refresh() {
        shared = MeowAPIProvider()
    }
    
    let delegate: RxMoyaProvider<MeowAPI>
    
    let token: Token?
    
    private init() {
        token = Token.load()
        
        let xToken:Token? = token 
        let endpointClosure = { (target: MeowAPI) -> Endpoint<MeowAPI> in
            
            var endpoint = MoyaProvider.defaultEndpointMapping(for: target)
            
            if let xToken = xToken {
                endpoint = endpoint.adding(httpHeaderFields: ["X-Access-Token": xToken.access])
            }
            
            return endpoint
        }
        
        delegate = RxMoyaProvider<MeowAPI>(endpointClosure: endpointClosure)

    }

    
    func request(_ target: MeowAPI) -> Observable<Response> {
        return delegate.request(target)
    }
    
}
