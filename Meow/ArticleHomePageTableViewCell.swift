//
//  ArticleHomePageTableViewCell.swift
//  Meow
//
//  Created by 林树子 on 2017/7/3.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import Foundation
import UIKit

class ArticleHomePageTableViewCell: UITableViewCell {
    
    /* user profile info */
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    
    
    /* article info */
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleSummaryLabel: UILabel!
        // image?
    
    
    /* like & comment */
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
        // readcount?
    
    func configure(model: Article){
        let article = model
        let profile = article.profile
        
        if let avatar = profile?.avatar {
            avatarImageView.af_setImage(withURL: avatar)
        }
        nicknameLabel.text = profile?.nickname
        
        articleTitleLabel.text = article.title
        articleSummaryLabel.text = article.summary
        
        likeLabel.text = "\(article.likeCount!)"
        commentLabel.text = "\(article.commentCount!)"
    }
}
