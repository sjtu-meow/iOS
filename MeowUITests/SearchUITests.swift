//
//  SearchUITests.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import XCTest

class SearchUITests: XCTestCase {
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
    
    func testSearchBarShouldAppear() {
        app.tabBars.buttons["首页"].tap()
        XCTAssert(app.searchFields.element.exists)

    }
    
    func testSearchBarOnTapShowSearchContontroller() {
        app.searchFields.element.tap()
        XCTAssert(app.staticTexts["历史记录"].exists)
    }
    
    func testSearchControllerCanShouldResult() {
        app.searchFields.element(boundBy: 0).tap()
        app.searchFields.element(boundBy: 0).typeText("Search keyword")
        app.keyboards.buttons["Search"].tap()

        XCTAssert(app.navigationBars.buttons["搜索"].exists)
    }
    
    func testSearchHistory() {
        let keyword = "keyword"
        app.searchFields.element(boundBy: 0).tap()
        app.searchFields.element(boundBy: 0).typeText(keyword)
        app.keyboards.buttons["Search"].tap()
        app.navigationBars.buttons["搜索"].tap()
        XCTAssert(app.staticTexts[keyword].exists)
        app.buttons["清空历史记录"].tap()
        XCTAssertFalse(app.staticTexts[keyword].exists)
        
    }
}
