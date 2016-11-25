//
//  ExploreReposViewController.swift
//  YZGithub
//
//  Created by 郑建文 on 16/7/26.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import ObjectMapper
import MBProgressHUD

class ExploreReposViewController: UIViewController {
    
    let cellIdentifier = "RepoTableViewCell"
    var reposData:[Repository]! = []
    
    // MARK: request parameters
    
    
    var paraSince:String = "daily"
    var paraLanguage:String = "all"

    
    
    lazy var tableView: UITableView = {
        var table:UITableView = UITableView(frame: self.view.bounds)
        table.dataSource = self
        table.delegate = self
        
        table.register(UINib(nibName: "RepoTableViewCell", bundle: nil), forCellReuseIdentifier: "RepoTableViewCell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    func fetchData() {
        let provider = Provider.sharedProvider
        provider.request(GitHubAPI.trendingRepos(since: "daily", language: "ALL")){ result in
            
            switch result {
            case let .success(response):
                do{
                    if let repos:[Repository] = try response.mapArray(Repository.self){
                            self.reposData.removeAll()
                            self.reposData = repos
                            self.tableView.reloadData()
                            self.tableView.setContentOffset(CGPoint.zero, animated:true)
                    }else{
                    }
                }catch {
                }
            case let .failure(error):
                print(error)
                guard error is CustomStringConvertible else {
                    MBProgressHUD.showError("网络请求失败")
                    break
                }
            }
        }
    }
}
extension ExploreReposViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reposData.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RepoTableViewCell
        cell.repo = reposData[indexPath.row]
        return cell
    }
}
extension ExploreReposViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let infoVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "repoinfo") as? RepoInfoViewController
        infoVC?.repoInfo = reposData[indexPath.row]
        self.parent?.navigationController?.pushViewController(infoVC!, animated: true)
    }
    
}
