//
//  RepoTableViewCell.swift
//  YZGithub
//
//  Created by 郑建文 on 16/7/26.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import SwiftDate
import Kingfisher

class RepoTableViewCell: UITableViewCell {

    @IBOutlet weak var repoImage: UIImageView!
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var repoLastActiveTime: UILabel!
    @IBOutlet weak var repoStarNumber: UILabel!
    @IBOutlet weak var repoInfo: UILabel!
    @IBOutlet weak var repoForkNumber: UILabel!
    @IBOutlet weak var repoLanguage: UILabel!
    
    var repo:Repository? {
        
        didSet{
            updateUI()
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
    func updateUI() {
        repoName.text = repo?.name
        repoInfo.text = repo?.cdescription
        repoForkNumber.text = "\(repo!.forks_count!)"
        repoStarNumber.text = "\(repo!.stargazers_count!)"
        repoLastActiveTime.text = (repo!.pushed_at!.toDate(DateFormat.ISO8601)?.toRelativeString(abbreviated: false, maxUnits: 1))! + " age"
        if let lan = repo?.language {
            repoLanguage.text = lan
        }
        
        repoImage.kf_setImageWithURL(NSURL(string: (repo?.owner!.avatar_url)!)!)
    }
    
}
