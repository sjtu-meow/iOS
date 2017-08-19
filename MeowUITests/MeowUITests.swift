//
//  MeowUITests.swift
//  MeowUITests
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import XCTest

class MeowUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testTabSwitchable() {
        let tabBarsQuery = app.tabBars
        
        tabBarsQuery.buttons["文章"].tap()
        XCTAssert(app.navigationBars["文章"].exists)

        tabBarsQuery.buttons["问答"].tap()
        XCTAssert(app.navigationBars["问答"].exists)

        tabBarsQuery.buttons["我的"].tap()
        XCTAssert(app.navigationBars["我"].exists)

        tabBarsQuery.buttons["首页"].tap()
        XCTAssert(app.navigationBars["首页"].exists)
    }
    
    func testArticleListShowArticleOnTap() {
        app.tabBars.buttons["文章"].tap()
        
        app.cells.element(boundBy: 0).tap()
        XCTAssert(app.navigationBars.element.buttons["文章"].exists)
    }
    
    func testDeviceChange() {
        XCUIDevice.shared().orientation = .faceDown
        XCUIDevice.shared().orientation = .landscapeLeft
        XCUIDevice.shared().orientation = .portrait
        
        // Assert nothing happens
    }
    
    func testMePageItemsTappable() {
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
