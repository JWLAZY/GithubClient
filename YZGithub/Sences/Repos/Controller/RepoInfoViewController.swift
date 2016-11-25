//
//  RepoInfoViewController.swift
//  YZGithub
//
//  Created by 郑建文 on 16/7/27.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import Moya
import MBProgressHUD

class RepoInfoViewController: UIViewController {
    
    enum  Identifier:String{
        case intro = "introIdentifier"
        case info = "infoIdentifier"
        case codeInfo = "codeInfoIdentifier"
    }
    deinit{
        for task in netTask {
            task.cancel()
        }
    }
    var netTask:[Cancellable] = [Cancellable]()
    var repoInfo:Repository? {
        didSet{
            fetchBranches()
        }
    }
    //设置名字需要请求仓库数据
    var repoName:String? {
        didSet {
            fetchRepoInfo()
        }
    }
    var repoOwner:String?
    var branches:[Branches]?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = repoName ?? repoInfo?.name
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(UINib(nibName: "RepoIntroCell",bundle: nil), forCellReuseIdentifier: Identifier.intro.rawValue)
        tableView.register(UINib(nibName: "RepoInfoCell",bundle: nil), forCellReuseIdentifier: Identifier.info.rawValue)
        tableView.register(UINib(nibName: "RepoCodeInfoCell",bundle: nil), forCellReuseIdentifier: Identifier.codeInfo.rawValue)
        tableView.contentInset = UIEdgeInsetsMake(-100, 0, 0, 0)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func fetchRepoInfo() {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = "加载仓库信息中"
         let nb = Provider.sharedProvider.request(GitHubAPI.userSomeRepo(owner: repoOwner!, repo: repoName!)) { [weak self](result) in
            switch result {
            case .success(let response):
                do {
                    let repo:Repository = try response.mapObject(Repository.self)
                    self!.repoInfo = repo
                    print(self?.classForCoder ?? "位置类型")
                    if self?.tableView != nil {
                        self!.tableView.reloadData()
                    }
                    
                }catch{
                    MBProgressHUD.showError("数据解析失败")
                }
            case .failure(let error):
                MBProgressHUD.showError("网络请求失败:\(error)")
            }
            hud.hide(animated: true)
        }
        netTask.append(nb)
    }
    func fetchBranches() {
       let nb =  Provider.sharedProvider.request(GitHubAPI.repoBranchs(owner: repoInfo!.owner!.login!, repo: repoInfo!.name!)) {[weak self] (result) in
            switch result {
            case let .success(response):
                do{
                    let commits:[Branches] = try response.mapArray(Branches.self)
                    self!.branches = commits    
                }catch{
                }
            case let .failure(error):
                print(error)
            }
        }
        netTask.append(nb)
    }
}
//MARK: Delegate
extension RepoInfoViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = (indexPath.section,indexPath.row)
        switch index {
        case  (1,0):
            let developerListVC = DeveloperListViewController()
            developerListVC.developer = repoInfo?.owner
            if let nav = self.parent?.navigationController {
                nav.pushViewController(developerListVC, animated: true)
            }else{
                self.navigationController?.pushViewController(developerListVC, animated: true)
            }
        case (1,1):
            showBranches()
        case (2,0):
            let prvc = PRListViewController()
            prvc.repoinfo = repoInfo
            self.navigationController?.pushViewController(prvc, animated: true)
        case (2,1):
            let readmeVC = ReadmeViewController()
            readmeVC.repo = repoInfo
            navigationController?.pushViewController(readmeVC, animated: true)
        default:
            print("等等")
        }
    }
    func showBranches() {
        if branches == nil {
            return
        }
        let title:[String] = branches!.map { (branch:Branches) -> String in
            return branch.name!
        }
        let sheet = JWSheet.init(frame: view.frame, items: title) { (index) in
            print(index)
        }
        tabBarController!.view.addSubview(sheet!)
    }
}

//MARK: DataSource
extension RepoInfoViewController:UITableViewDataSource{
    @nonobjc func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    private func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 10
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        default:
            return 2
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.intro.rawValue,for: indexPath) as? RepoIntroCell
            if let repoinfo = repoInfo {
                cell!.repoinfo = repoinfo
            }
            return cell!
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.info.rawValue, for: indexPath) as? RepoInfoCell
            switch indexPath.row {
            case 0:
                cell?.customUI(UIImage(named: "octicon_person_25")!, actionName: "成员")
            case 1:
                cell?.customUI(UIImage(named: "coticon_branch_25")!, actionName: "分支")
            default:
                return cell!
            }
            return cell!
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.info.rawValue, for: indexPath) as? RepoInfoCell
            switch indexPath.row {
            case 0:
                cell?.customUI(UIImage(named: "octicon_pull_request_25")!, actionName: "合并请求")
            case 1:
                cell?.customUI(UIImage(named: "octicon_watch_red_25")!, actionName: "README")
            default:
                return cell!
            }
            return cell!
        }
    }
}
