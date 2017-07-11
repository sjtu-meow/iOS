//
//  SearchHistorySourceTests.swift
//  Meow
//
//  Created by 林树子 on 2017/7/11.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//


import XCTest
@testable import Meow

class SearchHistorySourceTests : XCTestCase {
    // 炸啦炸啦 ~~>_<~~~!!!
    func testAddHistory() {
        SearchHistorySource.clearHistory()
        SearchHistorySource.addHistory(historyEntry: "meow")
        let history = SearchHistorySource.getHistory()
        XCTAssertEqual(1, history.count)
        XCTAssertEqual("meow",history.first)
        
        SearchHistorySource.clearHistory()
        XCTAssertEqual(0, SearchHistorySource.getHistory().count)
        
    }
}
