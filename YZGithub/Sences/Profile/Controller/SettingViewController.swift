//
//  SettingViewController.swift
//  YZGithub
//
//  Created by 郑建文 on 16/8/10.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class SettingViewController: BaseViewController {

    var tableView = UITableView(frame: CGRect.zero, style: .grouped)
    override func viewDidLoad() {
        super.viewDidLoad()
        customUI()
    }
    func customUI() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "settingCell")
        tableView.snp_makeConstraints { (make) in
            make.size.equalTo(self.view)
            make.left.top.equalTo(self.view)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    deinit{
        print("销毁")
    }
}
extension SettingViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1.0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = (indexPath.section,indexPath.row)
        
        switch index {
        case (0,0):
            let cell = tableView.viewWithTag(101) as! UITableViewCell
            KingfisherManager.shared.cache.clearDiskCache(completion: { 
                GlobalHubHelper.showMessage("缓存清除成功", view: self.view)
                cell.textLabel?.text = "无缓存"
            })
        default:
            if ObjUser.deleteUserInfo() {
                GlobalHubHelper.showMessage("退出成功", view: view)
                self.navigationController?.popViewController(animated: true)
                NotificationCenter.default.post(name: Notification.Name(rawValue: NotificationGitLogOutSuccessful), object: nil)
                
            }else{
                GlobalHubHelper.showError("退出失败", view: view)
            }
        }
    }
}
extension SettingViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath)
        
        let index = (indexPath.section,indexPath.row)
        switch index {
        case (0,0):
            KingfisherManager.shared.cache.calculateDiskCacheSize(completion: { (size) in
                cell.textLabel?.text = "清除缓存  (\(size / 1024  / 1024) M)"
            })
            cell.textLabel?.text = "清除缓存"
            cell.tag = 101
        case(1,0):
                cell.textLabel?.text = "退出"
        default:
                print("等待")
        }
        return cell
    }
}
