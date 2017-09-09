//
//  QuestionDetailAnswerCell.swift
//  Meow
//
//  Created by 林武威 on 2017/7/12.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit

class QuestionDetailAnswerCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    
    @IBOutlet weak var nicknameLabel: UILabel!
    
    @IBOutlet weak var bioLabel: UILabel!
    
    @IBOutlet weak var summaryLabel: UILabel!
    
    @IBOutlet weak var likeCountLabel: UILabel!
    
    @IBOutlet weak var commentCountLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    var model: Answer?
    
    func configure(model: Answer) {
        let profile = model.profile!
        
        if let url = profile.avatar {
            avatarImageView.af_setImage(withURL: url)
        }
        likeCountLabel.text = "\(model.likeCount ?? 0)"
        commentCountLabel.text = "\(model.commentCount ?? 0)"
        summaryLabel.text = model.content
        nicknameLabel.text=profile.nickname
        bioLabel.text = profile.bio
        
        sizeToFit()
    }

}
