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
@objc
class ViewHistoryItem: NSObject, NSCoding {
    var id: Int
    var type: ItemType
    
    
    public static func ==(lhs: ViewHistoryItem, rhs: ViewHistoryItem) -> Bool {
        logger.log(lhs.debugDescription)
        logger.log(rhs.debugDescription)
        return lhs.id == rhs.id && lhs.type == rhs.type
    }
    
    override var hashValue: Int {
        return type.hashValue + id
    }
    func encode(with aCoder: NSCoder) {
      //  aCoder.encode(id, forKey: "id")
       // aCoder.encode(type.rawValue, forKey: "type")
    }
    
    init(id: Int, type: ItemType) {
        self.id = id
        self.type = type
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.id=1
        //self.id = aDecoder.decodeInteger(forKey: "id")
        //let raw = aDecoder.decodeInteger(forKey: "type")
        //guard let type = ItemType(rawValue: raw) else { return nil }
        self.type = .article
    }
}
