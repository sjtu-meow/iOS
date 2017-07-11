//
//  SearchHistorySource.swift
//  Meow
//
//  Created by 林树子 on 2017/7/10.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit

struct SearchHistorySource {
    
    typealias StringSet = Set<String>
    static private let searchHistoryDefaultsKey = "searchHistoryDefaultsKey"
    
    static func setHistory(set: StringSet) {
        UserDefaults.standard.setCustomObject(set as NSSet, forKey: searchHistoryDefaultsKey)
    }
    
    static func getHistory() -> StringSet {
        return (UserDefaults.standard.customObject(forKey: searchHistoryDefaultsKey) as? NSSet as? StringSet)
            ?? StringSet()
    }
    
    static func addHistory(historyEntry: String) {
        var history = getHistory();
        history.insert(historyEntry);
        setHistory(set: history)
    }
    
    static func clearHistory() {
        setHistory(set: StringSet())
    }
    
    static func removeHistory(historyEntry: String) {
        var history = getHistory()
        history.remove(historyEntry)
        setHistory(set: history)
    }

}
