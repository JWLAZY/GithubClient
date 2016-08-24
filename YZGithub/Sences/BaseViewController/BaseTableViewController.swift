//
//  BaseTableViewController.swift
//  YZGithub
//
//  Created by 郑建文 on 16/8/24.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import SnapKit

class BaseTableViewController<T>: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var dataArray:[T]? {
        didSet{
            self.tableView.reloadData()
        }
    }
    let tableView = UITableView(frame: CGRectZero, style: .Plain)
    var cellName:String? {
         return NSStringFromClass(T.self as! AnyClass) + "Cell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customTableView()
    }
    func customTableView() {
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.size.left.top.equalTo(self.view)
        }
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.registerNib(UINib(nibName: cellName!,bundle: nil), forCellReuseIdentifier: cellName!)
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    
    //MARK: DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataArray != nil {
            return dataArray!.count 
        }
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let anyclass:AnyClass? = NSClassFromString(cellName!)
        let cell = tableView.dequeueReusableCellWithIdentifier(cellName!, forIndexPath: indexPath) as? BaseCell<T>
        cell?.model = dataArray![indexPath.row]
        return cell!
    }

}
