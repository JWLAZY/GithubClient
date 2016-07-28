//
//  DeveloperViewController.swift
//  YZGithub
//
//  Created by 郑建文 on 16/7/27.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import SnapKit

class DeveloperViewController: UIViewController {

    enum CellIdentifier:String {
        case UserBaseInfoCell
        case RepoInfoCell
    }
    
    let tableView:UITableView = UITableView(frame: CGRectZero, style: .Grouped)
    var headerView:UIView?
    var userImage:UIImageView?
    
    var headerHeight:CGFloat {
        return 200
    }
    var viewWidth: CGFloat{
        return view.frame.width
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customUI()
    }
    
    func customUI(){
        
        // MARK: tableview UI
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.registerNib(UINib(nibName: CellIdentifier.UserBaseInfoCell.rawValue,bundle: nil), forCellReuseIdentifier: CellIdentifier.UserBaseInfoCell.rawValue)
        tableView.registerNib(UINib(nibName: CellIdentifier.RepoInfoCell.rawValue,bundle: nil), forCellReuseIdentifier: CellIdentifier.RepoInfoCell.rawValue)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        view.addSubview(tableView)
        automaticallyAdjustsScrollViewInsets = false
        tableView.contentInset = UIEdgeInsetsMake(64 + headerHeight, 0, 0, 0)
        tableView.snp_makeConstraints { (make) in
            make.size.equalTo(view)
            make.top.bottom.leading.trailing.equalTo(view)
        }
        
        // MARK: headerView
        headerView = UIView(frame: CGRectMake(0, -headerHeight, viewWidth, headerHeight))
        headerView?.backgroundColor = UIColor.redColor()
        tableView.addSubview(headerView!)
        let bgImageView = UIImageView(image: UIImage(named: "profile_bk"))
        bgImageView.contentMode = UIViewContentMode.ScaleAspectFill
        headerView!.addSubview(bgImageView)
        bgImageView.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(headerView!)
            make.leading.trailing.equalTo(headerView!)
        }
        
        // MARK: user logo
        userImage = UIImageView(image: UIImage(named: "app_logo_90"))
        headerView?.addSubview(userImage!)
        userImage?.snp_makeConstraints(closure: { (make) in
            make.centerX.equalTo(headerView!)
            make.width.height.equalTo(90)
            make.bottom.equalTo(headerView!.snp_bottom).offset(-60)
        })
        userImage?.layer.masksToBounds = true
        userImage?.layer.cornerRadius = 45
    }
}
extension DeveloperViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        print(offsetY)
        if fabs(offsetY) > headerHeight {
            var oldFrame = headerView?.frame
            oldFrame?.size.height = fabs(offsetY) - 64
            oldFrame?.origin.y = offsetY + 64
            headerView?.frame = oldFrame!
        }else{
            
        }
    }
}
extension DeveloperViewController: UITableViewDelegate{
    
}

extension DeveloperViewController:UITableViewDataSource {
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.1
        }
        return 10
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 1
        default:
            return 3
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier.UserBaseInfoCell.rawValue, forIndexPath: indexPath) as? UserBaseInfoCell
            cell?.selectionStyle = .None
            return cell!
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier.RepoInfoCell.rawValue, forIndexPath: indexPath) as? RepoInfoCell
            
            return cell!
        }
        
    }
}
