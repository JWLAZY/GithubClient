//
//  ExploreDevelopersViewController.swift
//  YZGithub
//
//  Created by 郑建文 on 16/7/26.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import Moya
import Alamofire
import ObjectMapper
import DGElasticPullToRefresh


class ExploreDevelopersViewController: UIViewController {

    let cellIdentifier = "DeveloperTableViewCell"
    
    
    // MARK: Data
    let para = ParaSearchUser()
    var data = [ObjUser]()
    
    lazy var tableView: UITableView = {
        var table:UITableView = UITableView(frame: self.view.bounds)
        table.dataSource = self
        table.delegate = self
        table.register(UINib(nibName: "DeveloperTableViewCell", bundle: nil), forCellReuseIdentifier: "DeveloperTableViewCell")
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
        table.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            
                self!.fetchDeveData()
            }, loadingView: loadingView)
        table.dg_setPullToRefreshFillColor(UIColor(red: 22/255, green: 150/255, blue: 122/255, alpha: 1))
        table.dg_setPullToRefreshBackgroundColor(table.backgroundColor!)
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        customUI()
        fetchDeveData()
    }
    
    func customUI() {
        
    }
    deinit {
        tableView.dg_removePullToRefresh()
    }
    func fetchDeveData() {
        Provider.sharedProvider.request(GitHubAPI.searchUsers(para: para)) {[weak self] (result) in
            switch result{
            case let .success(response):
                do{
                    if let userResult:SearchUserResponse = Mapper<SearchUserResponse>().map(JSONObject: try response.mapJSON()) {
                        
                        if userResult.items == nil{
                            return
                        }
                        
                        if self!.para.page == 1{
                            self!.data.removeAll()
                            self!.data += userResult.items!
                            self!.tableView.dg_stopLoading()
                            self!.tableView.reloadData()
                        }else {
                            self!.data += userResult.items!
                            self!.tableView.reloadData()
                        }
                    }
                }catch{
                    self!.tableView.dg_stopLoading()
                }
            case let .failure(error):
                print(error)
                self!.tableView.dg_stopLoading()
            }
        }
    }
    func refeshingHandle() {
        para.page = 1
        fetchDeveData()
    }
    func footerRefesh() {
        para.page += 1
        fetchDeveData()
    }
}
extension ExploreDevelopersViewController:UIScrollViewDelegate {
  
}

extension ExploreDevelopersViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == data.count {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "next")
            let label = UILabel()
            label.frame.size = CGSize(width: 120, height: 40)
            label.textColor = UIColor.white
            label.text = "点击加载更多"
            label.textAlignment = .center
            cell.addSubview(label)
            label.snp_makeConstraints({ (make) in
                make.center.equalTo(cell)
            })
            cell.backgroundColor = UIColor.hexStr("00631b", alpha: 1)
            
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DeveloperTableViewCell
        cell.deve = data[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == data.count {
            return 44
        }
        return 70
    }
}
extension ExploreDevelopersViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == data.count {
            footerRefesh()
        }else{
            let devVC = DeveloperViewController()
            devVC.developer = data[indexPath.row]
            parent?.navigationController?.pushViewController(devVC, animated: true)
        }
    }
}
