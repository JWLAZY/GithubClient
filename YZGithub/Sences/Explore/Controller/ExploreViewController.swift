//
//  ExploreViewController.swift
//  YZGithub
//
//  Created by 郑建文 on 16/7/26.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import SnapKit

class ExploreViewController: BaseViewController {

    let scrollView:UIScrollView = UIScrollView()
    var scrollHeight:CGFloat {
        return UIScreen.main.bounds.height - 66 - 44
    }
    var viewWidth:CGFloat {
        return self.view.bounds.size.width
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        customUI()
    }
    func customUI() {
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view)
            make.width.equalTo(self.view)
            make.bottom.equalTo(self.view.snp.bottom)
        }
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: self.view.frame.width * 2, height: scrollView.bounds.height)
        scrollView.isPagingEnabled = true
        scrollView.backgroundColor = UIColor.red
        
        //仓库页面
        let repo = ExploreReposViewController()
        let table1 = repo.tableView
        table1.frame = CGRect(x: 0, y: 0, width: viewWidth, height: scrollHeight)
        scrollView.addSubview(table1)
        self.addChildViewController(repo)
        
        //开发者页面
        let deve = ExploreDevelopersViewController()
        let table2 = deve.tableView
        table2.frame = CGRect(x: viewWidth, y: 0, width: viewWidth, height: scrollHeight)
        scrollView.addSubview(table2)
        self.addChildViewController(deve)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
extension ExploreViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView.contentOffset.x > viewWidth {
//            segmentView.selectedSegment = 1
//        }else{
//            segmentView.selectedSegment = 0
//        }
    }
}
