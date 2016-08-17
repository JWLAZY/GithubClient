//
//  UserBaseInfoCell.swift
//  YZGithub
//
//  Created by 郑建文 on 16/7/28.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit

class UserBaseInfoCell: UITableViewCell {

    @IBOutlet weak var attrNameLabel: UILabel!
    @IBOutlet weak var attrValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func customUI(name name:String, value:String) {
        attrNameLabel.text = name
        attrValueLabel.text = value
    }
}
