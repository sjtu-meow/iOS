//
//  ArticleRecordTableViewCell.swift
//  Meow
//
//  Created by 林武威 on 2017/7/13.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit

class ArticleRecordTableViewCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    func configure(model: ArticleSummary) {
      
        if let url = model.cover{
            avatarImageView?.af_setImage(withURL: url)
        }
        titleLabel.text = model.title
        contentLabel.text = model.summary
    }
}
