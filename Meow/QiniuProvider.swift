//
//  QiniuProvider.swift
//  Meow
//
//  Created by 林武威 on 2017/7/4.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import Qiniu
import RxSwift
import Result

enum QiniuError: Swift.Error {
    case error(QNResponseInfo) // FIXME: add detailed error types
}

class QiniuProvider {
    open static let shared = QiniuProvider()
    
    let disposeBag = DisposeBag()
    
    var token: UploadToken?
    
    let manager = QNUploadManager()
    
    init() {
        if token == nil {
            MeowAPIProvider.shared.request(.uploadToken)
            .mapTo(type: UploadToken.self)
            .subscribe(onNext:{[weak self] token in self?.token = token})
            .addDisposableTo(disposeBag)
        }
    }
    
    func upload(data: Data) -> Observable<String> {
        return Observable<String>.create{
            (observer) in
            
            self.manager?.put(data, key: nil,
                                  token: self.token?.token,
                                  complete: {
                                    (info, key, response) in
                                    if info!.isOK {
                                        observer.onNext(response!["key"]! as! String)
                                        observer.onCompleted()
                                    } else {
                                        observer.onError(QiniuError.error(info!))
                                    }
            },option: nil)
            
            return Disposables.create()
        }

    }
    
    func upload(file path: String) -> Observable<String> {
        return Observable<String>.create{
            (observer) in
            
            self.manager?.putFile(path, key: nil,
                             token: self.token?.token,
                             complete: {
                                (info, key, response) in
                                if info!.isOK {
                                    observer.onNext(key!)
                                    observer.onCompleted()
                                } else {
                                    observer.onError(QiniuError.error(info!))
                                }
                },option: nil)
            
            return Disposables.create()
        }
    }
}
