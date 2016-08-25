//
//  EventCell.swift
//  YZGithub
//
//  Created by 郑建文 on 16/8/24.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import Kingfisher

class EventCell: BaseCell {

    @IBOutlet weak var eventOwnerAvator: UIImageView!
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var EventInfo: UILabel!
    @IBOutlet weak var createTime: UILabel!
    @IBOutlet weak var eventTypeImage: UIImageView!
    
    override func setModel<T>(model: T) {
        let event = model as? Event
        if let e = event {
            if let url = e.actor?.avatar_url {
                    self.eventOwnerAvator.kf_setImageWithURL(NSURL(string: url)!)
            }
            if let name = e.actor?.login {
                self.eventLabel.text = name
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
