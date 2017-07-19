//
//  ViewHistorySourceTests.swift
//  Meow
//
//  Created by 唐楚哲 on 2017/7/18.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import XCTest
@testable import Meow

class ViewHistorySourceTests : XCTestCase {
    func testAddHistory() {
        // item to add
        var item = ViewHistoryItem()
        item.id = 1
        item.type = .article
        
        // add and test
        ViewHistorySource.clearHistory()
        ViewHistorySource.addHistory(historyItem: item)
        let history = ViewHistorySource.getHistory()
        XCTAssertEqual(1, history.count)
        XCTAssertEqual(history[0], item)
        
        // delete and test
        ViewHistorySource.clearHistory()
        XCTAssertEqual(0, ViewHistorySource.getHistory().count)
        
    }
}
