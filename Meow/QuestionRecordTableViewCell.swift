//
//  QuestionRecordTableViewCell.swift
//  Meow
//
//  Created by 林武威 on 2017/7/13.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit

class QuestionRecordTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    func configure(model: QuestionSummary) {
    
        titleLabel.text = model.title  
        if let url = model.profile.avatar {
            avatarImageView.af_setImage(withURL: url)
        }
        
    }
    
    
}
