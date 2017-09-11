//
//  ArticleProfilePageTableViewCell.swift
//  Meow
//
//  Created by 林武威 on 2017/7/18.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit

class ArticleProfilePageTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var commentCount: UILabel!
    
    func configure(model: ArticleSummary) {
        titleLabel.text = model.title
        if let url = model.cover {
            avatarImageView.af_setImage(withURL: url) 
        }
        likeCountLabel.text = "\(model.likeCount ?? 0)"
        commentCount.text = "\(model.commentCount ?? 0)"
    }
}
