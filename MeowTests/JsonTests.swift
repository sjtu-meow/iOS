//
//  JsonTests.swift
//  Meow
//
//  Created by 林武威 on 2017/9/11.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import XCTest
import SwiftyJSON

class JsonTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInt () {
        let json1 = JSON(integerLiteral: 1)
        let json2 = JSON(stringLiteral: "a")
        XCTAssertEqual(1,Int.fromJSON(json1))
        XCTAssertNil(Int.fromJSON(json2))
    }
    
    func testDouble () {
        let json1 = JSON(floatLiteral: 1.0)
        let json2 = JSON(stringLiteral: "a")
        XCTAssertEqual(1.0, Double.fromJSON(json1))
        XCTAssertNil(Double.fromJSON(json2))
    }
    
}
