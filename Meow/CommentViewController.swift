//
//  CommentViewController.swift
//  Meow
//
//  Created by 林武威 on 2017/7/18.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit

class CommentViewController: UITableViewController {
    var item: ItemProtocol!
    var comments: [Comment] {
        switch item.type! {
        case .answer:
            return (item as! Answer).comments
        case .article:
            return (item as! Article).comments
        default:
            return []
        }
    }
    
    override func viewDidLoad() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
    }

    func configure(model: ItemProtocol) {
        self.item = model
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment = comments[indexPath.row]
        return UITableViewCell()
    }
    
}
