//
//  BaseTableViewController.swift
//  YZGithub
//
//  Created by 郑建文 on 16/8/24.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import SnapKit

enum IfloadMore {
    case loading
    case noload
    mutating func change() {
        switch self {
        case .loading:
            self = .noload
        case .noload:
            self = .loading
        }
    }
}

class BaseTableViewController<T>: UIViewController,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil  , bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var page : Int = 1
    var ifloading = IfloadMore.noload
    var dataArray:[T]? {
        didSet{
            self.tableView.reloadData()
        }
    }
    let tableView = UITableView(frame: CGRect.zero, style: .plain)
    var cellName:String? {
        let name =  NSStringFromClass(T.self as! AnyClass) + "Cell"
        let cellname = name.components(separatedBy: ".")
         return cellname[1]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(fetchData), name: NSNotification.Name(rawValue: NotificationGitLoginSuccessful), object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(fetchData), name: NotificationGitLogOutSuccessful, object: nil)
        customTableView()
        isLogin()
    }
    func customTableView() {
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.size.left.top.equalTo(self.view)
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: cellName!,bundle: nil), forCellReuseIdentifier: cellName!)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func isLogin() {
        if UserInfoHelper.sharedInstance.isLogin {
            fetchData({})
        }else {
            GlobalHubHelper.showError("请先登录...", view: self.view)
        }
    }
    //MARK: NOTI
    func fetchData(_ success:()->()){
        
    }
    //MARK: DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataArray != nil {
            return dataArray!.count 
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName!, for: indexPath) as? BaseCell
        cell?.setModel(dataArray![indexPath.row])
        cell!.selectionStyle = .none
        return cell!
    }
    //上拉加载
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y >= fmax(0.0, scrollView.contentSize.height - scrollView.frame.size.height) + 60 {
            if ifloading == .noload {
                UIView.commitAnimations()
                UIView.animate(withDuration: 1.0, animations: { 
                    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0)
                    }, completion: { (result) in
                        self.ifloading.change()
                        self.fetchData({ 
                                self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 50, 0)
                        })
                })
            }
        }
    }
}
