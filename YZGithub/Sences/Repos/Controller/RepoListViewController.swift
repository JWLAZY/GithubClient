//
//  RepoListViewController.swift
//  YZGithub
//
//  Created by 郑建文 on 16/7/28.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import SnapKit

class RepoListViewController: UIViewController {

    //MARK: 搜索属性
    var page = 1
    var perpage = 10
    var type = "owner"
    var sort = "created"
    var direction = "desc"

    //MARK: DATA
    var developer:ObjUser? = nil
    var reposArray:[Repository]?
    
    lazy var tableView:UITableView? = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customUI()
        fetchRepoList()
    }
    func customUI() {
        view.addSubview(tableView!)
        title = "仓库列表"
        tableView?.snp.makeConstraints({ (make) in
            make.top.bottom.leading.trailing.equalTo(view)
        })
//        tableView?.estimatedRowHeight = 100
//        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.register(UINib(nibName: "RepoTableViewCell",bundle: nil), forCellReuseIdentifier: "RepoTableViewCell")
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    func fetchRepoList() {
        Provider.sharedProvider.request(GitHubAPI.userRepos(username: (developer?.login)!, page: page, perpage: perpage, type: type, sort: sort, direction: direction)) { (result) in
            switch result {
            case let .success(response):
                do{
                    let repos:[Repository] = try response.mapArray(Repository.self) 
                    if self.page == 1 {
                        self.reposArray?.removeAll()
                        self.reposArray = repos
                    }else{
                        self.reposArray = self.reposArray! + repos
                    }
                    self.page += 1
                    self.tableView?.reloadData()
                }catch{
                    
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}
extension RepoListViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let a = reposArray {
                return a.count + 1
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == reposArray?.count {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            let label = UILabel()
            label.frame.size = CGSize(width: 120, height: 40)
            label.textColor = UIColor.white
            label.text = "点击加载更多"
            label.textAlignment = .center
            cell.addSubview(label)
            label.snp.makeConstraints({ (make) in
                make.center.equalTo(cell)
            })
            cell.backgroundColor = UIColor.hexStr("00631b", alpha: 1)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoTableViewCell", for: indexPath) as? RepoTableViewCell
        cell?.repo = reposArray![indexPath.row]
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row  == reposArray?.count{
            return 40
        }
        return 100
    }
}
extension RepoListViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == reposArray?.count {
            fetchRepoList()
            return
        }
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let repoInfoVC = sb.instantiateViewController(withIdentifier: "repoinfo") as? RepoInfoViewController
        repoInfoVC!.repoInfo = reposArray![indexPath.row]
        navigationController?.pushViewController(repoInfoVC!, animated: true)
    }
}

