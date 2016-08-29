//
//  NewsViewController.swift
//  YZGithub
//
//  Created by 郑建文 on 16/8/24.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import MBProgressHUD
import JLSwiftRouter

class NewsViewController: BaseTableViewController<Event> {


    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "动态"
        fetchData()
        
    }
    
    func fetchData() {
        let hub = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hub.labelText = "网络请求中..."
        Provider.sharedProvider.request(GitHubAPI.UserEvent(username: UserInfoHelper.sharedInstance.user!.login!, page: 0)) { (result) in
            switch result {
            case .Success(let response):
                do {
                    self.dataArray = try response.mapArray(Event)
                    MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                }catch{
                        GlobalHubHelper.showError("数据解析失败", view: self.view)
                }
            case .Failure(let error):
                GlobalHubHelper.showError("网络请求失败:\(error)", view: self.view)
            }
        }
    }
    
}
