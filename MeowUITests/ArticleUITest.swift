//
//  ArticleUITest.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import XCTest

class ArticleUITest: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()
        app.tabBars.buttons["文章"].tap()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testArticleListShowArticleOnTap() {
        app.cells.element(boundBy: 0).tap()
        XCTAssert(app.navigationBars.element.buttons["文章"].exists)
    }
    
}
