//
//  BannerViewCell.swift
//  Meow
//
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit
import ImageSlideshow
import RxSwift

class BannerViewCell: UITableViewCell {

    var slideShow: ImageSlideshow!
    let disposeBag = DisposeBag()
    
    var banners: [Banner]!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        slideShow = ImageSlideshow()
        
        slideShow.contentScaleMode = .scaleToFill
        slideShow.slideshowInterval = 5
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTapBanner))
        slideShow.addGestureRecognizer(recognizer)
        contentView.addSubview(slideShow)
        
    }
    

    func didTapBanner() {
        let index = slideShow.currentPage
        onTapBanner?(banners?[index])
    }
    
    var onTapBanner:((Banner?)->Void)?
    
    func configure(banners: [Banner]) {
        self.banners = banners
        let sources = banners
            .flatMap {
                (banner) -> AlamofireSource? in
                let url = URL(string: banner.url)
                if let url = url {
                    return AlamofireSource(url: url)
                }
                logger.log("Invalid banner url \(banner.url)")
                return nil
            }
        slideShow.setImageInputs(sources)
    }
    
}
    
