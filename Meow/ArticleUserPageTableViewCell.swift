//
//  ArticleUserPageTableViewCell.swift
//  Meow
//
//  Created by 林武威 on 2017/7/20.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit

class ArticleUserPageTableViewCell: UITableViewCell {
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var commentCountLabel: UILabel!
    
    func configure(model: ArticleSummary) {
        if let url = model.cover{
            coverImageView.af_setImage(withURL: url)
        }
        titleLabel.text =  model.title
        contentLabel.text = model.summary
        
        if let likeCount = model.likeCount {
            likeCountLabel.text = "\(likeCount)"
        } else {
            likeCountLabel.text = "0"
        }
        
        if let commentCount = model.commentCount {
            commentCountLabel.text = "\(commentCount)"
        } else {
            commentCountLabel.text = "0"
        }
        //likeCountLabel.text = "\(model.likeCount)"
        //commentCountLabel.text = "\(model.commentCount)"
    }
}
