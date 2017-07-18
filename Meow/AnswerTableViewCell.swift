 //
//  QuestionAnswerPageAnswerCell.swift
//  Meow
//
//  Created by 林武威 on 2017/7/10.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit

protocol AnswerCellDelegate {
    func onTitleTapped(model: AnswerSummary)
}
 
class AnswerTableViewCell: UITableViewCell {
    var model: AnswerSummary?
    var delegate: AnswerCellDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    
    override func awakeFromNib() {
        let tapAction = UITapGestureRecognizer(target: self, action: #selector(self.onTitleTapped(_:)))
        titleLabel.addGestureRecognizer(tapAction)
        
    }
    func configure(model: AnswerSummary) {
        self.model = model
        titleLabel.text = model.questionTitle
        contentLabel.text = model.content
        likeCountLabel.text = "\(model.likeCount ?? 0)"
        commentCountLabel.text = "\(model.commentCount ?? 0)"
    }
    
    func onTitleTapped(_ sender: UITapGestureRecognizer) {
        guard let model = model else { return }
        delegate?.onTitleTapped(model: model)
    }
    
    
}
