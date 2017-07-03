//
//  ArticlePageTableViewCell.swift
//  Meow
//
//  Created by 林树子 on 2017/6/30.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit

class ArticlePageTableViewCell: UITableViewCell {

    
    //Properties
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleSummaryLabel: UILabel!
    @IBOutlet weak var articleCoverImageView: UIImageView!
    @IBOutlet weak var articleLikeLabel: UILabel!
    @IBOutlet weak var articleCommentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
