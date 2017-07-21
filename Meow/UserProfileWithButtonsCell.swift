//
//  UserProfileWithButtonsCell.swift
//  Meow
//
//  Created by 林武威 on 2017/7/20.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit

protocol UserProfileCellDelegate {
    func didTapFollowButton(_ sender: UIButton)
    func didTapSendMessageButton(_ sender: UIButton)
}

class UserProfileWithButtonsCell: UITableViewCell {
    
    var delegate: UserProfileCellDelegate?
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var sendMessageButton: UIButton!
    
    
    func configure(model: Profile) {
        if let url = model.avatar {
            avatarImageView.af_setImage(withURL: url)
        }
        nicknameLabel.text = model.nickname
        bioLabel.text = model.bio
        
    }
    
    func updateFollowingButton(isFollowing: Bool) {
        let title = isFollowing ? "取消关注" : "关注"
        followButton.setTitle(title, for: UIControlState.normal)
    }
    
    @IBAction func follow(_ sender: Any) {
        delegate?.didTapFollowButton(sender as! UIButton)
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        delegate?.didTapSendMessageButton(sender as! UIButton)
    }
}
