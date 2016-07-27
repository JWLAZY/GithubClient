//
//  ProfileViewController.swift
//  YZGithub
//
//  Created by 郑建文 on 16/7/14.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import SnapKit
import Static
import Kingfisher

class ProfileViewController: BaseViewController,UITableViewDelegate{
    
    var user:ObjUser?
    var isLogin:Bool?
    
    var tableView : UITableView?
    var profileImageView : UIImageView?
    var nameLable : UILabel?
    var headerView:UIImageView?{
        return tableView?.viewWithTag(101) as? UIImageView
    }
    var datasource = DataSource()
    
    let identifier : String = "reuseIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //通知中心.注册登录成功和退出事件
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(updateUserinfoData), name: NotificationGitLoginSuccessful, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(updateUserinfoData), name: NotificationGitLogOutSuccessful, object: nil)

        tableView = UITableView(frame: self.view.bounds, style: .Plain)
        self.view.addSubview(tableView!)
        tableView?.delegate = self
        tableView?.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: identifier as String)
        tableView?.tableFooterView = UIView()
        
        customUI()
    }
    
    func customUI() {
        
        tableView?.contentInset = UIEdgeInsetsMake(175 - 44, 0, 0, 0)
        
        let header:UIImageView = UIImageView(frame: CGRect(x: 0,y:-175,width: 375,height: 175))
        header.image = UIImage(named: "profile_bk")
        header.tag = 101
        header.contentMode = UIViewContentMode.ScaleAspectFill
        profileImageView = UIImageView(image: UIImage(named: "app_logo_90"))
        header.addSubview(profileImageView!)
        
        profileImageView!.snp_makeConstraints { (make) in
            make.centerX.equalTo(header)
            make.width.height.equalTo(80)
            make.centerY.equalTo(header).offset(0)
        }
        profileImageView!.layer.masksToBounds = true
        profileImageView!.layer.cornerRadius = 40
        
        tableView?.addSubview(header)
        
        self.navigationController?.navigationBar.setMyBackgroundColor(UIColor(red: 0/255.0, green: 130/255.0, blue: 210/255.0, alpha: 0))
        
        
        nameLable = UILabel()
        nameLable!.text = "登陆"
        header.addSubview(nameLable!)
        nameLable!.snp_makeConstraints { (make) in
            make.centerX.equalTo(header)
            make.top.equalTo(profileImageView!.snp_bottom).offset(10);
        }
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.login(_:)))
        nameLable?.addGestureRecognizer(tap)
        nameLable?.userInteractionEnabled = true
        header.userInteractionEnabled = true
        
        var rows = [Row]()
        
        let row = Row(text: "weatch",cellClass: Value1Cell.self)
        let row2 = Row(text: "feedback",cellClass: Value1Cell.self)
        let row3 = Row(text: "settings",cellClass: Value1Cell.self)
        let row4 = Row(text: "share",cellClass: Value1Cell.self)
        let row5 = Row(text: "rate",cellClass: Value1Cell.self)
        let row6 = Row(text: "about",cellClass: Value1Cell.self)
        rows = [row,row2,row3,row4,row5,row6]
        
        datasource.sections = [Section(rows:rows)]
        datasource.tableView = tableView
        datasource.tableView?.delegate = self
        
        updateUserinfoData()
    }
    
    func login(tap:UITapGestureRecognizer){
        NSLog("登陆")
        NetworkHelper.clearCookies()
        let loginVC = LoginViewController()
        let url = String(format: "https://github.com/login/oauth/authorize/?client_id=%@&redirect_uri=%@&scope=%@", GithubClientID,GithubRedirectUrl,"user,user:email,user:follow,public_repo,repo,repo_deployment,repo:status,delete_repo,notifications,gist,read:repo_hook,write:repo_hook,admin:repo_hook,admin:org_hook,read:org,write:org,admin:org,read:public_key,write:public_key,admin:public_key")
        loginVC.url = url
        loginVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    func updateUserinfoData() {
        user = UserInfoHelper.sharedInstance.user
        isLogin = UserInfoHelper.sharedInstance.isLogin
        if isLogin! == true {
            nameLable?.text = user?.name
            profileImageView?.kf_setImageWithURL(NSURL(string: user!.avatar_url!)!)
        }
        
    }
}

extension ProfileViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        //下拉
        if scrollView.contentOffset.y < -175 {
            print(scrollView.contentOffset.y)
            var frame = headerView?.frame
            frame?.size.height = fabs(scrollView.contentOffset.y)
            frame?.origin.y = scrollView.contentOffset.y
            headerView?.frame = frame!
        }else{//上拉
            
        }
        
    }
}