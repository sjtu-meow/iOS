//
//  UserRecordTableViewCell.swift
//  Meow
//
//  Created by 林武威 on 2017/7/13.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit

protocol UnfollowUserDelegate {
    func didClickUnfollow(profile: Profile)
}

protocol UserRecordTableViewCellDelegate: UnfollowUserDelegate, AvatarCellDelegate {
}

class UserRecordTableViewCell: UITableViewCell {
    var delegate: UserRecordTableViewCellDelegate?
    var model: Profile?
    
    @IBOutlet weak var unfollowButton: UIButton!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    override func awakeFromNib() {
        unfollowButton.addTarget(self, action: #selector(didClickUnfollow), for: UIControlEvents.touchUpInside)
        avatarImageView.addGestureRecognizer(tapAvatarRecognizer)
    }
    

    
    func configure(model: Profile) {
        self.model = model
        if let avatar = model.avatar {
            avatarImageView.af_setImage(withURL: avatar)
        }

        nickNameLabel.text = model.nickname
        bioLabel.text = model.bio
    }
    
    let tapAvatarRecognizer = UIGestureRecognizer(target: self, action: #selector(didTapAvatar))
 
    func didClickUnfollow() {
        guard let model = self.model else { return }
        delegate?.didClickUnfollow(profile: model)
    }
    
    func didTapAvatar() {
        guard let model = self.model else { return }
        delegate?.didTapAvatar(userId: model.userId)
    }
}
