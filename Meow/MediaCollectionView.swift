//
//  MediaCollectionView.swift
//  Meow
//
//  Created by 林武威 on 2017/8/3.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit

class MediaCollectionView: UICollectionView {
    var moment: Moment?
    var heightConstraint: NSLayoutConstraint!
    static var cellHeight = {
        return UIScreen.main.bounds.width / 2 - 30
    }()
    
    static var minLineSpacing: CGFloat = 10.0
    static var minItemSpacing: CGFloat = 10.0
    static var sectionInset = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0)
    
    let CellIdentifier = "MediaCell"
    
    override func awakeFromNib() {
        
        translatesAutoresizingMaskIntoConstraints = false
        dataSource = self
        isScrollEnabled = false
    
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: MediaCollectionView.cellHeight, height: MediaCollectionView.cellHeight)
        layout.sectionInset = MediaCollectionView.sectionInset
        layout.minimumInteritemSpacing = MediaCollectionView.minItemSpacing
        layout.minimumLineSpacing = MediaCollectionView.minLineSpacing
        heightConstraint = heightAnchor.constraint(equalToConstant: 0)
        heightConstraint.priority = UILayoutPriorityDefaultHigh
        heightConstraint.isActive = true
        
        register(MediaCollectionViewCell.self, forCellWithReuseIdentifier: CellIdentifier)
    }
    
    func configure (model: Moment) {
        self.moment = model
        guard let medias = self.moment?.medias else { return }
        
        let numberOfRows = medias.count / 2
        
        let height = CGFloat(numberOfRows) * MediaCollectionView.cellHeight + CGFloat(numberOfRows - 1) * MediaCollectionView.minLineSpacing + 15.0
        heightConstraint.constant = height
        // superview?.sizeToFit()
        // superview?.setNeedsUpdateConstraints()
        setNeedsUpdateConstraints()
    }

}

extension MediaCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return moment?.medias != nil ? 1 : 0
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moment?.medias?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let view = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier, for: indexPath) as! MediaCollectionViewCell
        
        view.configure(model: moment!.medias![indexPath.row])
        
        return view
    }
    
}

extension MediaCollectionView: UICollectionViewDelegate {
   
    
}

class MediaCollectionViewCell: UICollectionViewCell {
    var imageView:UIImageView
    
    override init(frame: CGRect) {
        imageView = UIImageView(frame: frame)
        
        super.init(frame: frame)

        translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        imageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        imageView.layer.cornerRadius = 5.0
        imageView.clipsToBounds = true
    }
    
    func configure(model: Media) {
        if let url = model.url {
            imageView.af_setImage(withURL: url)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
