//
//  AvatarImageView.swift
//  Meow
//
//  Created by 林武威 on 2017/7/31.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit

class AvatarImageView: UIImageView {
    var profile: Profile?
    var delegate: AvatarCellDelegate?
    weak var viewController: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapAvatar(_:)))
        self.addGestureRecognizer(tapRecognizer)
        self.isUserInteractionEnabled=true
    }
    
    func didTapAvatar(_ sender: UITapGestureRecognizer) {
        guard let profile = profile else { return }
        
        delegate?.didTapAvatar(profile: profile)
    }
    
    func configure(model: Profile) {
        self.profile = model
        if let url = model.avatar {
            self.af_setImage(withURL: url)
        }
    }
    
}
