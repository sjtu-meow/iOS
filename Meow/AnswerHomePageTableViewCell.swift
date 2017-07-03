//
//  AnswerHomePageTableViewCell.swift
//  Meow
//
//  Created by 林树子 on 2017/7/3.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class AnswerHomePageTableViewCell: UITableViewCell {

    /* user profile info */
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    
    /* question & answer info */
    @IBOutlet weak var questionTitleLabel: UILabel!
    @IBOutlet weak var answerContentLabel: UILabel!
    
    /* like & comment */
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    
    func configure(model: Answer) {
        let answer = model
        let profile = answer.profile
        
        if let avatar = profile?.avatar {
            avatarImageView.af_setImage(withURL: avatar)
        }
        nicknameLabel.text = profile?.nickname
        
        questionTitleLabel.text = answer.questionTitle
        answerContentLabel.text = answer.content
        
        likeLabel.text = String(describing: answer.like)
        commentLabel.text = String(describing: answer.comment)
        
    }
    
}
