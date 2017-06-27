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
        let access = "access", refresh = "refresh"
        let token = Token(access: access, refresh: refresh )
        token.save()
        let restored = Token.load()
        XCTAssertNotNil(restored)
        XCTAssertEqual(restored!.access, access)
        XCTAssertEqual(token.refresh, refresh)
    }
}
