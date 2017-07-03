//
//  MomentTableViewCell.swift
//  Meow
//
//  Created by 唐楚哲 on 2017/6/30.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit
import AlamofireImage

class MomentHomePageTableViewCell: UITableViewCell {

    //MARK: - Property
    /* user profile info */
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    /* moment */
    @IBOutlet weak var momentContentLabel: UILabel!
    @IBOutlet weak var mediaCollectionView: UICollectionView!
    
    /* like & comment */
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    // comment content
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(model: Moment) {
        let moment = model
        let profile = moment.profile
        
        if let avatar = profile?.avatar {
            avatarImageView.af_setImage(withURL: avatar)
        }
        nicknameLabel.text = profile?.nickname
        bioLabel.text = profile?.bio
        
        momentContentLabel.text = moment.content
        // collection?
        
        likeLabel.text = String(describing: moment.like) 
        commentLabel.text = String(describing: moment.comment)
        
        // comment
        
    }
    
    
    // like function
    @IBAction func like(_ sender: UIButton) {
    }
    // comment function
    
    

}
