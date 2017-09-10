//
//  MomentTableViewCell.swift
//  Meow
//
//  Created by 唐楚哲 on 2017/6/30.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit
import RxSwift
import SwiftyJSON
import AlamofireImage

protocol ToggleLikeDelegate {
    @discardableResult 
    func didToggleLike(id: Int, isLiked: Bool) -> Bool
}

protocol PostCommentDelegate {
    func didPostComment(moment: Moment, content: String, from cell: MomentHomePageTableViewCell)
}

protocol MomentCellDelegate: AvatarCellDelegate, ToggleLikeDelegate, PostCommentDelegate {}

class MomentHomePageTableViewCell: UITableViewCell {

    @IBOutlet weak var commentListStackView: UIStackView!
    //MARK: - Property
    /* user profile info */
    @IBOutlet weak var avatarImageView: AvatarImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    /* moment */
    @IBOutlet weak var momentContentLabel: UILabel!
    @IBOutlet weak var mediaCollectionView: MediaCollectionView!
    
    /* like & comment */
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    
    @IBOutlet weak var likeButton: UIButton!
    // comment content
    @IBOutlet weak var commentTextField: UITextField!
    
    let disposeBag = DisposeBag()
    
    var model: Moment?
    var itemId : Int?
    
    var isLiked = false

    var delegate: MomentCellDelegate? {
        didSet {
            avatarImageView.delegate = delegate
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.delegate = self.delegate
       
        // mediaCollectionView.heightAnchor.constraint(equalToConstant: mediaCollectionView.contentSize.height).isActive = true
        commentTextField.delegate = self
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(model: Moment) {
        self.model = model
        self.itemId = model.id
        let moment = model
        let profile = moment.profile
        
        avatarImageView.configure(model: profile!)
        nicknameLabel.text = profile?.nickname
        bioLabel.text = profile?.bio
        
        momentContentLabel.text = moment.content
        
        updateLikeCountLabel()
        updateCommentCountLabel()
        updateCommentList()
        
        //likeLabel.text = String(describing: moment.likeCount!)
        // collection?
        
//        likeLabel.text = String(describing: moment.like) 
//        commentLabel.text = String(describing: moment.comments)
        
        // comment
        // TODO

        // media
        //mediaCollectionView.configure(model: model)
        mediaCollectionView.configure(model: moment)
        
        setNeedsUpdateConstraints()
        
        initLikeLabel()
        
    }
    
    func updateCommentList() {
        guard let commnets = model?.comments else { return }
        for comment in commnets {
            let view = R.nib.momentCommentTableViewCell.firstView(owner: nil)!
            view.configure(comment)
            commentListStackView.addArrangedSubview(view)
        }
    }
    
    func updateLikeCountLabel() {
        likeLabel.text = "\(model!.likeCount ?? 0)"
    }
    
    func updateCommentCountLabel() {
        commentLabel.text = "\(model!.commentCount ?? 0)"
    }

    func initLikeLabel() {
        MeowAPIProvider.shared
            .request(.isLikedMoment(id: itemId!))
            .subscribe(onNext: {
                [weak self]
                json in
                self?.isLiked = (json as! JSON)["liked"].bool!
                self?.updateLikeLabel()
            })
            .addDisposableTo(disposeBag)
    }

    func updateLikeLabel() {
        let title = isLiked ? "已赞" : "赞"
        likeButton.setTitle(title, for: .normal)
    }
    
    @IBAction func toggleLike(_ sender: Any) {
        delegate?.didToggleLike(id: itemId!, isLiked: self.isLiked)
        isLiked = !isLiked
        self.updateLikeLabel()
        
        if (self.model != nil) {
            self.model!.likeCount = self.model!.likeCount! + (isLiked ? 1 : -1)
            self.updateLikeCountLabel()
        }

    }
    
    @IBAction func postComment(_ sender: Any) {
        
    }
    
    // comment function

    func clearComment() {
        commentTextField.text = ""
    }
}

extension MomentHomePageTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let content = commentTextField.text
        delegate?.didPostComment(moment: model!, content: content!, from: self)
        return true
    }
}
