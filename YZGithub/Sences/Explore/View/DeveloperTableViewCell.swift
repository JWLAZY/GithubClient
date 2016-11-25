//
//  DeveloperTableViewCell.swift
//  YZGithub
//
//  Created by 郑建文 on 16/7/26.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class DeveloperTableViewCell: UITableViewCell {

    @IBOutlet weak var indexLable: UILabel!
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!    
    @IBOutlet weak var userInfo: UILabel!
    
    var deve:ObjUser? {
        didSet{
            userImage.kf.setImage(with:URL(string: deve!.avatar_url!)!)
            userName.text = deve!.login
            userInfo.text = deve!.email
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
