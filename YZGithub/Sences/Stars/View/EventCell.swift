//
//  EventCell.swift
//  YZGithub
//
//  Created by 郑建文 on 16/8/24.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit

class EventCell: BaseCell {

    
    override func setModel<T>(model: T) {
        let event = model as? Event
        if let e = event {
            print(e.actor?.login)
            self.textLabel?.text = e.actor?.login!
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
