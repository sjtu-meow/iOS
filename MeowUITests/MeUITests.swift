//
//  MeUITests.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import XCTest

class MeUITests: XCTestCase {
    var app: XCUIApplication!
    override func setUp() {
        super.setUp()

        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()

    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testChangeNickname() {
        let nickname = "NICKNAME"
        
        app.tabBars.buttons["我的"].tap()
        
        let oldNickname = app.cells.element(boundBy: 0).staticTexts.element(boundBy: 0).label
        
        app.cells.element(boundBy: 0).tap()
        app.sheets["编辑个人资料"].buttons["修改昵称"].tap()
        app.alerts["修改昵称"].textFields.element(boundBy:0).typeText(nickname)
        app.alerts["修改昵称"].buttons["取消"].tap()
        let unchangedNickname = app.cells.element(boundBy: 0).staticTexts.element(boundBy: 0).label
        XCTAssertEqual(oldNickname, unchangedNickname)
        
        app.cells.element(boundBy: 0).tap()
        app.sheets["编辑个人资料"].buttons["修改昵称"].tap()
        app.alerts["修改昵称"].textFields.element(boundBy:0).typeText(nickname)
        app.alerts["修改昵称"].buttons["好"].tap()
        
        let newNickname = app.cells.element(boundBy: 0).staticTexts.element(boundBy: 0).label
        
        XCTAssertEqual(newNickname, nickname)
    }
    
    func testChangeBio() {
        let bio = "BIO"
        
        
        app.tabBars.buttons["我的"].tap()
        
        let oldBio = app.cells.element(boundBy: 0).staticTexts.element(boundBy: 1).label
        
        app.cells.element(boundBy: 0).tap()
        app.sheets["编辑个人资料"].buttons["修改简介"].tap()
        app.alerts["修改个人简介"].textFields.element(boundBy:0).typeText(bio)
        app.alerts["修改个人简介"].buttons["取消"].tap()
        
        let unchangedBio = app.cells.element(boundBy: 0).staticTexts.element(boundBy: 1).label
        XCTAssertEqual(oldBio, unchangedBio)

        app.cells.element(boundBy: 0).tap()
        app.sheets["编辑个人资料"].buttons["修改简介"].tap()
        app.alerts["修改个人简介"].textFields.element(boundBy:0).typeText(bio)
        app.alerts["修改个人简介"].buttons["好"].tap()
        
        
        let newBio = app.cells.element(boundBy: 0).staticTexts.element(boundBy: 1).label
        
        XCTAssertEqual(newBio, bio)
    }
    
    func testItemsTappable() {
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["我的"].tap()
        
        app.staticTexts["我的点滴"].tap()
        XCTAssert(app.navigationBars["我的点滴"].exists)
        app.navigationBars["我的点滴"].buttons["我"].tap()
        
        app.staticTexts["我的文章"].tap()
        XCTAssert(app.navigationBars["我的文章"].exists)
        app.navigationBars["我的文章"].buttons["我"].tap()
        
        app.staticTexts["我的问答"].tap()
        XCTAssert(app.navigationBars["我的问答"].exists)
        app.navigationBars["我的问答"].buttons["我"].tap()
    }

}
