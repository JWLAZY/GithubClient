//
//  RepoIntroCell.swift
//  YZGithub
//
//  Created by 郑建文 on 16/7/27.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import Kingfisher

class RepoIntroCell: UITableViewCell {

    @IBOutlet weak var repoImage: UIImageView!
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var repoAuthor: UILabel!
    @IBOutlet weak var repoIntro: UILabel!
    var repoinfo:Repository? {
        didSet{
            repoImage.kf_setImageWithURL(NSURL(string: (repoinfo!.owner!.avatar_url)!)!)
            repoName.text = repoinfo?.name
            repoAuthor.text = repoinfo?.owner?.login
            repoIntro.text = repoinfo?.cdescription
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
