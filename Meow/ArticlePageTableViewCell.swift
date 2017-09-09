//
//  ArticlePageTableViewCell.swift
//  Meow
//
//  Created by 林树子 on 2017/6/30.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit
import AlamofireImage

class ArticlePageTableViewCell: UITableViewCell {

    
    @IBOutlet weak var articleCoverImageView: UIImageView!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleLikeLabel: UILabel!
    @IBOutlet weak var articleCommentLabel: UILabel!
    // TODO: readCount, createTime
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(model: ArticleSummary){
        let articleSummary = model
        if let coverURL = articleSummary.cover {
            articleCoverImageView.af_setImage(withURL: coverURL)
        }
        articleTitleLabel.text = articleSummary.title
        
        if let likeCount = articleSummary.likeCount {
            articleLikeLabel.text = "\(likeCount)"
        } else {
            articleLikeLabel.text = "0"
        }
        
        if let commentCount = articleSummary.commentCount {
            articleCommentLabel.text = "\(commentCount)"
        } else {
            articleCommentLabel.text = "0"
        }
        
    }


}
