//
//  MomentRecordTableViewCell.swift
//  Meow
//
//  Created by 林武威 on 2017/7/13.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit

class MomentRecordTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var nicknameLabel: UILabel!
    
    func configure(model: Moment) {
        if let url = model.profile.avatar {
            avatarImageView.af_setImage(withURL: url)
        }
        contentLabel.text = model.content
        nicknameLabel.text = model.profile.nickname
    }
}
