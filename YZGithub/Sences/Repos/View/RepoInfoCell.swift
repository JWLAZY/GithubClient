//
//  RepoInfoCell.swift
//  YZGithub
//
//  Created by 郑建文 on 16/7/27.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import Kingfisher
class RepoInfoCell: UITableViewCell {

    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var actionName: UILabel!

    func customUI(image:UIImage,actionName:String) {
        imageIcon.image = image
        self.actionName.text = actionName
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
