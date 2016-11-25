//
//  PRListViewController.swift
//  YZGithub
//
//  Created by 郑建文 on 16/7/29.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import SnapKit
import MBProgressHUD


class PRListViewController: UIViewController {

    lazy var tableView: UITableView? = {
        let table = UITableView()
//        table.delegate = self
        table.dataSource = self
        return table
    }()
    var repoinfo:Repository? {
        didSet{
            fetchPRS()
        }
    }
    var prArray:[PullRequest]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customUI()
    }
    func customUI() {
        title = "PR列表"
        view.addSubview(tableView!)
        tableView?.estimatedRowHeight = 100
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.tableFooterView = UIView()
        tableView?.register(UINib(nibName: "PRCell",bundle: nil), forCellReuseIdentifier: "cell")
        tableView?.snp.makeConstraints({ (make) in
            make.top.bottom.equalTo(view)
            make.leading.trailing.equalTo(view)
        })
    }
    deinit{
        print("释放")
    }
    func fetchPRS() {
        Provider.sharedProvider.request(GitHubAPI.repoPullRequest(owner: repoinfo!.owner!.login!, repo: repoinfo!.name!)) { (result) in
            switch result {
            case let .success(response):
                do{
                    if let prs:[PullRequest] = try response.mapArray(PullRequest.self) {
                        if prs.count == 0{
                            let hub = MBProgressHUD.showAdded(to: self.view, animated: true)
                            hub.labelText = "这个仓库太冷清,没人提PR"
                            hub.mode = .text
                            hub.hide(true, afterDelay: 1)
                            return
                        }
                        self.prArray = prs
                        self.tableView?.reloadData()
                    }
                }catch{
                    
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}
extension PRListViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if prArray != nil {
            return prArray!.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PRCell
        cell?.prinfo = prArray![indexPath.row]
        return cell!
    }
}
