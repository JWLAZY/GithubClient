//
//  DeveloperListViewController.swift
//  YZGithub
//
//  Created by 郑建文 on 16/7/28.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit

class DeveloperListViewController: UIViewController {

    var developer:ObjUser?
    
    lazy var tableView: UITableView? = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView()
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customUI()
    }
    func customUI() {
        view.addSubview(tableView!)
        title = "成员列表"
        tableView?.snp_makeConstraints(closure: { (make) in
            make.bottom.top.equalTo(view)
            make.width.height.equalTo(view)
        })
        tableView?.registerNib(UINib(nibName: "DeveloperTableViewCell",bundle: nil), forCellReuseIdentifier: "DeveloperTableViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
extension DeveloperListViewController:UITableViewDelegate{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let devInfo = DeveloperViewController()
        devInfo.developer = developer
        self.navigationController?.pushViewController(devInfo, animated: true)
    }
}
extension DeveloperListViewController:UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DeveloperTableViewCell",forIndexPath: indexPath) as? DeveloperTableViewCell
        cell?.deve = developer
        return cell!
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
}
