//
//  QuestionDetailQuestionCell.swift
//  Meow
//
//  Created by 林武威 on 2017/7/12.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit

class QuestionDetailQuestionCell: UITableViewCell {
    var model: Question!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!

    @IBOutlet weak var answerCountLabel: UILabel!
    
    @IBOutlet weak var followingCountLabel: UILabel!
    
    func configure(model: Question) {
        self.model = model
        titleLabel.text = model.title
        contentLabel.text = model.content
        answerCountLabel.text = "\(model.answers!.count)"
        
    }

    @IBAction func addAnswer(_ sender: Any) {
        
    }
    
    @IBAction func follow(_ sender: Any) {
        
    }
}
