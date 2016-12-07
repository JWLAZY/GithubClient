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
import MBProgressHUD

enum DeveListType {
    case follewers
}

class DeveloperListViewController: BaseViewController {

    let vm = DevelopListViewModel()
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
        table.dataSource = self
        table.tableFooterView = UIView()
        return table
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        customUI()
        
        vm.user?.asObservable().subscribe({ [weak self](event) in
            self?.fetchFollewers()
        }).addDisposableTo(disposeBag)
    }
    func customUI() {
        view.addSubview(tableView!)
        title = "成员列表"
        tableView?.snp.makeConstraints({ (make) in
            make.bottom.top.equalTo(view)
            make.width.height.equalTo(view)
        })
        tableView?.register(UINib(nibName: "DeveloperTableViewCell",bundle: nil), forCellReuseIdentifier: "DeveloperTableViewCell")
        tableView?.rx.setDelegate(self).addDisposableTo(disposeBag)
//        tableView?.rx.setDataSource(self).addDisposableTo(disposeBag)
        vm.users?.asObservable().bindTo(self.tableView!.rx.items(cellIdentifier: "DeveloperTableViewCell", cellType: DeveloperTableViewCell.self)){ (row,element,cell) in 
            cell.deve = element
        }.addDisposableTo(disposeBag)
    }
    
    func fetchFollewers() {
//        vm.fetchListNoRx()
        vm.fetchList().subscribe(onNext: { [weak self](users) in
            self?.tableView?.reloadData()
        }, onError: nil, onCompleted: nil, onDisposed: nil).addDisposableTo(disposeBag)
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 70
    }
}
extension DeveloperListViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listType != nil{
            if let c = vm.users?.value {
                return c.count
            }
            return 0
        }else{
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeveloperTableViewCell",for: indexPath) as? DeveloperTableViewCell
        if listType != nil{
                cell?.deve = vm.users?.value[indexPath.row]
        }else{
                cell?.deve = vm.user?.value
        }
        return cell!
    }
    
}
