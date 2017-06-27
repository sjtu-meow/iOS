//
//  GlobalFunctions.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import Foundation

func logPath() -> URL {
    let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
    return docs.appendingPathComponent("logger.txt")
}

let logger = Logger(destination: logPath())
