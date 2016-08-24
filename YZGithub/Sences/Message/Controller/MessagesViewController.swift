//
//  MessagesViewController.swift
//  YZGithub
//
//  Created by 郑建文 on 16/8/23.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import SnapKit
import MBProgressHUD

class MessagesViewController: UIViewController {

    var messageArray = [Message]()
    
    let tableView = UITableView(frame: CGRectZero, style: .Plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customUI()
        fetchData()
    }
    func customUI() {
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.size.left.top.equalTo(self.view)
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.registerNib(UINib(nibName: "MessageCell",bundle: nil), forCellReuseIdentifier: "messageCell")
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    func fetchData() {
        let hub = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hub.labelText = "加载数据中"
        Provider.sharedProvider.request(GitHubAPI.Message(page: 0)) { (result) in
            switch result {
            case .Success(let response):
                do{
                    let array = try  response.mapArray(Message)
                    self.messageArray.appendContentsOf(array)
                    MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                    self.tableView.reloadData()
                }catch {
                    GlobalHubHelper.showMessage("数据解析失败", view: self.view)
                }
            case .Failure(let error):
                GlobalHubHelper.showError("error:\(error.response)", view: self.view)
            }
        }
    }
}
extension MessagesViewController:UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("messageCell", forIndexPath: indexPath) as? MessageCell
        cell?.message = messageArray[indexPath.row]
        return cell!
    }
}
extension MessagesViewController:UITableViewDelegate {
    
}
