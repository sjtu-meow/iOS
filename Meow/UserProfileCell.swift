//
//  UserProfileCell.swift
//  Meow
//
//  Created by 林武威 on 2017/7/20.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit

class UserProfileCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    
    @IBOutlet weak var bioLabel: UILabel!
    
    func configure(model: Profile) {
        if let url = model.avatar {
            avatarImageView.af_setImage(withURL: url)
        }
        nicknameLabel.text = model.nickname
        bioLabel.text = model.bio
        
    }
}
