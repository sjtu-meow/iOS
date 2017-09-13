//
//  Date+toString.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

extension Date {
    func toString() -> String {
        if !isToday {
            return format(with: "MM月dd日 HH:mm")
        }
        let now = Date()
        let diffHours = now.hour - hour
        if diffHours <= 1 {
            return "刚刚"
        } else {
            return "\(diffHours)小时前"
        }
    }
}
