//
//  TokenTests.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import XCTest
@testable import Meow

class TokenTests : XCTestCase {
    func testLoadAndSave() {
        let access = "access"
        let token = Token(access: access)
        token.save()
        let restored = Token.load()
        XCTAssertNotNil(restored)
        XCTAssertEqual(restored!.access, access)
    }
}
