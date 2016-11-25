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
    
    let tableView = UITableView(frame: CGRect.zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customUI()
        isLogin()
        NotificationCenter.default.addObserver(self, selector: #selector(fetchData), name: NSNotification.Name(rawValue: NotificationGitLoginSuccessful), object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(fetchData), name: NotificationGitLogOutSuccessful, object: nil)
    }
    func customUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.size.left.top.equalTo(self.view)
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(UINib(nibName: "MessageCell",bundle: nil), forCellReuseIdentifier: "messageCell")
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    func fetchData() {
        let hub = MBProgressHUD.showAdded(to: self.view, animated: true)
        hub.label.text = "加载数据中"
        Provider.sharedProvider.request(GitHubAPI.message(page: 0)) { (result) in
            switch result {
            case .success(let response):
                do{
                    let array = try  response.mapArray(Message.self)
                    self.messageArray.append(contentsOf: array)
                    hub.hide(animated: true)
                    MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                    self.tableView.reloadData()
                }catch {
                    MBProgressHUD.showMsg("数据解析失败")
                }
            case .failure(let error):
                MBProgressHUD.showError("error:\(error.response)")
            }
        }
    }
    func isLogin() {
        if UserInfoHelper.sharedInstance.isLogin {
            fetchData()
        }else {
            MBProgressHUD.showError("请先登录...")
        }
    }
}
extension MessagesViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell
        cell?.message = messageArray[indexPath.row]
        return cell!
    }
}
extension MessagesViewController:UITableViewDelegate {
    
}
