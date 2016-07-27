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

    let tableView:UITableView = UITableView(frame: CGRectZero, style: .Grouped)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customUI()
        // Do any additional setup after loading the view.
    }
    func customUI(){
        self.view.backgroundColor = UIColor.whiteColor()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        automaticallyAdjustsScrollViewInsets = false
        tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        tableView.snp_makeConstraints { (make) in
            make.size.equalTo(view)
            make.top.bottom.leading.trailing.equalTo(view)
        }
    }
}
extension DeveloperViewController: UITableViewDelegate{
    
}
extension DeveloperViewController:UITableViewDataSource {
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        return cell
    }
}
