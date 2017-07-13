//
//  SearchResultTableView.swift
//  Meow
//
//  Created by 林武威 on 2017/7/12.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit

class SearchResultTableView: UITableView, UITableViewDelegate {
    
    class func addTo(superview: UIView) -> Self {
        let view = self.init()
        
        
        view.translatesAutoresizingMaskIntoConstraints=false
        superview.addSubview(view)

        view.leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
        view.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true

        view.rowHeight = UITableViewAutomaticDimension
        view.estimatedRowHeight = 100
        
        return view
    }

    
}

