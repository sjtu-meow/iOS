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
    
    var model: Moment?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mediaCollectionView.register(R.nib.mediaViewCell)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(model: Moment) {
        self.model = model
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
        // TODO

        // media
        mediaCollectionView.dataSource = self
    }
    
    
    // like function
    @IBAction func like(_ sender: UIButton) {
    }
    // comment function

}


extension MomentHomePageTableViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if let model = model, let _ = model.medias {
            return 1
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let model = model, let medias = model.medias {
            return medias.count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let view = collectionView.dequeueReusableCell(withReuseIdentifier: R.nib.mediaViewCell.identifier, for: indexPath) as! MediaViewCell
        
        view.configure(model: model!.medias![indexPath.row])
        
        return view
        
    }
    
    
}
