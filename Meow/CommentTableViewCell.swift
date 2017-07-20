//
//  CommentTableViewCell.swift
//  Meow
//
//  Created by 唐楚哲 on 2017/7/19.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    var model: Comment?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(model: Comment) {
        self.model = model
        
        let profile = model.profile
        if let url = profile?.avatar {
            avatarImageView.af_setImage(withURL: url)
        }
        nicknameLabel.text = profile?.nickname
        contentLabel.text = model.content
    }
    
}
