//
//  QuestionHomePageTableViewCell.swift
//  Meow
//
//  Created by 林树子 on 2017/7/3.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class QuestionHomePageTableViewCell: UITableViewCell {
    
    /* user profile info */
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    
    /* question info */
    @IBOutlet weak var questionTitleLabel: UILabel!
    
    /* like & comment */
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    func configure(model: Question) {
        let question = model
        let profile = question.profile
        
        if let avatar = profile?.avatar {
            avatarImageView.af_setImage(withURL: avatar)
        }
        nicknameLabel.text = profile?.nickname
        
        questionTitleLabel.text = question.title
        
        likeLabel.text = String(describing: question.likeCount )
        commentLabel.text = String(describing: question.commentCount)
        
    }

}
