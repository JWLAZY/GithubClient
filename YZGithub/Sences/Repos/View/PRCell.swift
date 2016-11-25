//
//  PRCell.swift
//  YZGithub
//
//  Created by 郑建文 on 16/7/29.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import Kingfisher

class PRCell: UITableViewCell {

    @IBOutlet weak var PRUserImage: UIImageView!
    @IBOutlet weak var PRTitle: UILabel!
    @IBOutlet weak var PRBody: UILabel!
    
    var prinfo:PullRequest? {
        didSet{
            PRUserImage.kf.setImage(with:URL(string: prinfo!.user!.avatar_url!)!)
            PRTitle.text = prinfo!.title!
            PRBody.attributedText = prinfo!.body!.richText()
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
