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

    @IBOutlet weak var slideShow: ImageSlideshow!
    let disposeBag = DisposeBag()
    
    var banners: [Banner]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        slideShow.contentScaleMode = .scaleToFill
        slideShow.slideshowInterval = 5
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTapBanner))
        slideShow.addGestureRecognizer(recognizer)
        
    }
    
    func didTapBanner() {
        let index = slideShow.currentPage
        onTapBanner?(banners?[index])
    }
    
    var onTapBanner:((Banner?)->Void)?
    
    func configure(banners: [Banner]) {
        guard banners.count > 0 else { return }
        self.banners = banners
        let sources = self.banners
            .map {
                (banner) in
                AlamofireSource(url: URL(string: banner.url)!)
            }
        slideShow.setImageInputs(sources)
    }
    
}
    
