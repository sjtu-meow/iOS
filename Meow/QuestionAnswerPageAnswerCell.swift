 //
//  QuestionAnswerPageAnswerCell.swift
//  Meow
//
//  Created by 林武威 on 2017/7/10.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit

class QuestionAnswerPageAnswerCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    
    func configure(model: Answer) {
        titleLabel.text = model.questionTitle
        contentLabel.text = model.content
        likeCountLabel.text = "\(model.likeCount!)"
        commentCountLabel.text = "\(model.commentCount!)"
    }
}
