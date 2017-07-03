//
//  MomentTableViewCell.swift
//  Meow
//
//  Created by 唐楚哲 on 2017/6/30.
//  Copyright © 2017年 喵喵喵的伙伴. All rights reserved.
//

import UIKit

class MomentTableViewCell: UITableViewCell {

    //MARK: - Property
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var nicknameBioSepetatorLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var momentTextLabel: UILabel!
    @IBOutlet weak var momentImageCollectionView: UICollectionView!
    @IBOutlet weak var thumbupCountLabel: UILabel!
    @IBOutlet weak var thumbupTextLabel: UILabel!
    @IBOutlet weak var thumbupCommentSeperatorLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var commentTextLabel: UILabel!
    @IBOutlet weak var commentListSeperatorView: UIView!
    @IBOutlet weak var commentListTableView: UITableView!
    @IBOutlet weak var commentTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(model:Moment) {
        
    }

}
