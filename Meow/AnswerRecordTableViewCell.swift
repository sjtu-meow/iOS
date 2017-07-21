//
//  AnswerRecordTableViewCell.swift
//  Meow
//
//  Created by 林武威 on 2017/7/13.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit

class AnswerRecordTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    func configure(model: AnswerSummary) {
        if let url = model.profile.avatar {
            avatarImageView.af_setImage(withURL: url)
        }
        nicknameLabel.text = model.profile.nickname
        contentLabel.text = model.content
        titleLabel.text = model.questionTitle
    }
}
