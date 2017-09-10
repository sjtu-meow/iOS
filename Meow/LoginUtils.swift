//
//  LoginUtils.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import RxSwift

class UserManager {
    open static var shared = UserManager()
    
    let disposeBag = DisposeBag()
    
    var currentUser: Profile?
    
    @discardableResult
    func login(phone: String, password: String) -> Observable<Profile> {
        let observable = MeowAPIProvider.shared
            .request(.login(phone: phone, password: password))
            .mapTo(type: Token.self)
            .flatMap() {
                token -> Observable<Any> in
                token.save()
                MeowAPIProvider.refresh()
                return MeowAPIProvider.shared.request(.myProfile)
            }
            .mapTo(type: Profile.self)
        
        observable.subscribe(onNext: {
            profile in
            UserManager.shared.currentUser = profile
            ChatManager.didLoginSuccess(withClientId: "\(profile.userId!)")
        }).addDisposableTo(disposeBag)
        
        return observable
    }
}

