//
//  MomentCommentView.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit

class MomentCommentView: UIView {
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    func configure(_ model: Comment) {
        authorLabel.text = model.profile.nickname
        contentLabel.text = model.content
    }
}
