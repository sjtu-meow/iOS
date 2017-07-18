//
//  ViewHistorySource.swift
//  Meow
//
//  Created by 唐楚哲 on 2017/7/18.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit

struct ViewHistorySource {
    
    typealias ItemArray = Array<ViewHistoryItem>
    static private let viewHistoryDefaultsKey = "viewHistoryDefaultsKey"
    
    static func setHistory(array: ItemArray) {
        UserDefaults.standard.setCustomObject(array as NSArray, forKey: viewHistoryDefaultsKey)
    }
    
    static func getHistory() -> ItemArray {
        return (UserDefaults.standard.customObject(forKey: viewHistoryDefaultsKey) as? NSArray as? ItemArray)
            ?? ItemArray()
    }
    
    static func addHistory(historyItem: ViewHistoryItem) {
        var history = getHistory()
        history.append(historyItem)
        setHistory(array: history)
    }
    
    static func clearHistory() {
        setHistory(array: ItemArray())
    }
    
    static func removeHistory(historyItem: ViewHistoryItem) {
        var history = getHistory()
        if let index = history.index(of: historyItem) {
            history.remove(at: index)
        }
        setHistory(array: history)
    }
    
}

struct ViewHistoryItem: Equatable {
    var id: Int!
    var type: ItemType!
    
    public static func ==(lhs: ViewHistoryItem, rhs: ViewHistoryItem) -> Bool {
        return lhs.id == rhs.id && lhs.type == rhs.type
    }
}
