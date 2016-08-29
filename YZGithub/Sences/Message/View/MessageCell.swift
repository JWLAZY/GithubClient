//
//  MessageCell.swift
//  YZGithub
//
//  Created by 郑建文 on 16/8/24.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    var message:Message? {
        didSet{
            if let reason = message?.reason {
                switch reason {
                case Reason.subscribed:
                    messageTypeImage.image = UIImage(named: "octicon_watch_20")
                default:
                    messageTypeImage.image = UIImage(named: "octicon_pull_request_25")
                }
            }
            if let title = message?.subject?.title {
                messageTitle.text = title
            }
            if let time = message?.updated_at {
                messageTime.text = time
            }
        }
    }
    
    @IBOutlet weak var messageTypeImage: UIImageView!
    @IBOutlet weak var messageTitle: UILabel!
    @IBOutlet weak var messageTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
