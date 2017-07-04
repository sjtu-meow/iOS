//
//  MediaViewCell.swift
//  Meow
//
//  Created by 林武威 on 2017/7/4.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit

class MediaViewCell: UICollectionViewCell {
    
    var model: Media?
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    func configure(model: Media) {
        self.model = model
        
        if model.type == .Image, let url = model.url {
            imageView.af_setImage(withURL: url)
        }
    }
    
    
}
