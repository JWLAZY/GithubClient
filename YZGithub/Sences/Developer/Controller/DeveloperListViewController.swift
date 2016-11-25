//
//  DeveloperListViewController.swift
//  YZGithub
//
//  Created by 郑建文 on 16/7/28.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire

enum DeveListType {
    case follewers
}

class DeveloperListViewController: BaseViewController {

    var developer:ObjUser?
    var developers:[ObjUser] = [ObjUser]()
    var listType:DeveListType? {
        didSet{
            switch listType! {
            case .follewers:
                fetchFollewers()
            }
        }
    }
    
    lazy var tableView: UITableView? = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView()
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customUI()
    }
    func customUI() {
        view.addSubview(tableView!)
        title = "成员列表"
        tableView?.snp.makeConstraints({ (make) in
            make.bottom.top.equalTo(view)
            make.width.height.equalTo(view)
        })
        tableView?.register(UINib(nibName: "DeveloperTableViewCell",bundle: nil), forCellReuseIdentifier: "DeveloperTableViewCell")
    }
    func fetchFollewers() {
            Provider.sharedProvider.request(GitHubAPI.followers(username: developer!.login!)) { [weak self](result) in
                switch result {
                case let .success(value):
                    
                    do{
                        let string = try value.mapString()
                        print(string)
                        let deves:[ObjUser] = try value.mapArray(ObjUser.self) 
                        self!.developers = deves
                        self?.tableView?.reloadData()
                    }catch{
                        print("解析失败")
                    }
                case let .failure(error):
                        print(error)
                }
            }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
extension DeveloperListViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let devInfo = DeveloperViewController()
        if listType != nil{
                devInfo.developer = developers[indexPath.row]
        }else{
                devInfo.developer = developer
        }
        self.navigationController?.pushViewController(devInfo, animated: true)
    }
}
extension DeveloperListViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listType != nil{
            return developers.count
        }else{
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeveloperTableViewCell",for: indexPath) as? DeveloperTableViewCell
        if listType != nil{
                cell?.deve = developers[indexPath.row]
        }else{
                cell?.deve = developer
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
