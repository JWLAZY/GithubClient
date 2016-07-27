//
//  RepoInfoViewController.swift
//  YZGithub
//
//  Created by 郑建文 on 16/7/27.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit

class RepoInfoViewController: UIViewController {
    
    enum  Identifier:String{
        case intro = "introIdentifier"
        case info = "infoIdentifier"
        case codeInfo = "codeInfoIdentifier"
    }
    
    var repoInfo:Repository?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = repoInfo?.name
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.registerNib(UINib(nibName: "RepoIntroCell",bundle: nil), forCellReuseIdentifier: Identifier.intro.rawValue)
        tableView.registerNib(UINib(nibName: "RepoInfoCell",bundle: nil), forCellReuseIdentifier: Identifier.info.rawValue)
        tableView.registerNib(UINib(nibName: "RepoCodeInfoCell",bundle: nil), forCellReuseIdentifier: Identifier.codeInfo.rawValue)
        tableView.contentInset = UIEdgeInsetsMake(-100, 0, 0, 0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension RepoInfoViewController:UITableViewDataSource{
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 0
        }
        return 5
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 6
        default:
            return 2
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier(Identifier.intro.rawValue,forIndexPath: indexPath) as? RepoIntroCell
            cell!.repoinfo = repoInfo
            return cell!
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier(Identifier.info.rawValue, forIndexPath: indexPath) as? RepoInfoCell
            switch indexPath.row {
            case 0:
                cell?.customUI(UIImage(named: "octicon_person_25")!, actionName: "成员")
            case 1:
                cell?.customUI(UIImage(named: "coticon_branch_25")!, actionName: "分支")
            default:
                return cell!
            }
            return cell!
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier(Identifier.info.rawValue, forIndexPath: indexPath) as? RepoInfoCell
            
            switch indexPath.row {
            case 0:
                cell?.customUI(UIImage(named: "octicon_pull_request_25")!, actionName: "合并请求")
            case 1:
                cell?.customUI(UIImage(named: "octicon_watch_red_25")!, actionName: "README")
            default:
                return cell!
            }
            return cell!
        }
    }
    
}
