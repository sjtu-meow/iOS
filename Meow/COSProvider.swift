//
//  COSProvider.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import Keys

class COSProvider {
    open static let shared = COSProvider()
    
    let BucketName = "meow", Region = "sh"
    
    var client: COSClient
    
    private init() {
        let keys = MeowKeys()
        client = COSClient(appId: keys.qCloudCOSAppId, withRegion: "unknown")
    }
    
    func upload(path: String, filename: String, directory: String?) {
        let task = COSObjectPutTask()!
        task.filePath = path
        task.fileName = filename
        task.directory = directory ?? "/"
        task.insertOnly = true
        task.sign = "sign"
        
        client.completionHandler = {
            (response, context) in
                print(response?.retCode ?? -1)
        }
        client.putObject(task)
        
    }
    
    
}
