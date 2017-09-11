//
//  QuestionDetailQuestionCell.swift
//  Meow
//
//  Created by 林武威 on 2017/7/12.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit
import RxSwift
import SwiftyJSON

protocol FollowQuestionDelegate {
    func didToggleFollowQuestion(question: Question, from cell: QuestionDetailQuestionCell)
}

protocol QuestionDetailQuestionCellDelegate : FollowQuestionDelegate {}

class QuestionDetailQuestionCell: UITableViewCell {
    var model: Question!
    var isFollowed = false
    var delegate: QuestionDetailQuestionCellDelegate?
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!

    @IBOutlet weak var answerCountLabel: UILabel!
    
    @IBOutlet weak var followingCountLabel: UILabel!
    
    @IBOutlet weak var addAnswerButton: UIButton!
    
    @IBOutlet weak var followButton: UIButton!
    
    func configure(model: Question) {
        self.model = model
        titleLabel.text = model.title
        contentLabel.text = model.content
        answerCountLabel.text = "\(model.answers!.count)"
        
        initFollowButton()
    }
    
    func initFollowButton() {
        MeowAPIProvider.shared
            .request(.isFollowingQuestion(id: model.id))
            .subscribe(onNext: {
                [weak self]
                json in
                self?.isFollowed = (json as! JSON)["following"].bool!
                self?.updateFollowButton()
            })
            .addDisposableTo(disposeBag)
    }
    
    @IBAction func toggleFollowQuestion(_ sender: Any) {
        delegate?.didToggleFollowQuestion(question: model, from: self)
    }
    
    func updateFollowButton() {
        let title = isFollowed ? "取消关注" : "关注"
        followButton.setTitle(title, for: .normal)
    }

}
