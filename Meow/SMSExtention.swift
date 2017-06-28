//
//  SMSExtention.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import AVOSCloud

extension AVSMS {
    class func sendValidationCode(phoneNumber: String, callback:@escaping (Bool, Error?)->()) {
        let options = AVShortMessageRequestOptions()
        options.ttl = 10;                     // 验证码有效时间为 10 分钟
        options.applicationName = "应用名称";  // 应用名称
        options.operation = "某种操作";        // 操作名称
        AVSMS.requestShortMessage(forPhoneNumber: phoneNumber, options: options, callback:callback)
    }
}
