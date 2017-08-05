//
//  MomentTableViewCell.swift
//  Meow
//
//  Created by 唐楚哲 on 2017/6/30.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit
import AlamofireImage

protocol MomentCellDelegate: AvatarCellDelegate {
    
}

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
    
    // comment content
    
    var model: Moment?

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
    }
    
    
    // like function
    @IBAction func like(_ sender: UIButton) {
    }
    // comment function
    

}


