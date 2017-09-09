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
    func didToggleLike(id: Int, isLiked: Bool) -> Bool
}

protocol MomentCellDelegate: AvatarCellDelegate, ToggleLikeDelegate {}

class MomentHomePageTableViewCell: UITableViewCell {

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
        likeButton.titleLabel?.text = isLiked ? "已赞" : "赞"
    }
    
    @IBAction func toggleLike(_ sender: Any) {
        delegate?.didToggleLike(id: itemId!, isLiked: self.isLiked)
        isLiked = !isLiked
        self.updateLikeLabel()
        
        // FIXME: update label upon repsonse

    }
    
    
    // comment function


}


