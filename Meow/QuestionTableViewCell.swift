//
//  QuestionTableViewCell.swift
//  Meow
//
//  Created by 林武威 on 2017/7/18.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var answerCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    
    func configure(model: QuestionSummary) {
        titleLabel.text = model.title
        answerCountLabel.text = "\(model.answerCount)"
        
    }
}
