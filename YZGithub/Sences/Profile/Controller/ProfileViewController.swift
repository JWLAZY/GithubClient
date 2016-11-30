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
import RxSwift
import RxCocoa


class ProfileViewController: BaseViewController{
    
    var user:ObjUser?
    var isLogin:Bool?
    
    var tableView : UITableView?
    var profileImageView : UIImageView?
    var nameLable : UILabel?
    var followersLable:UILabel = UILabel()
    var startLable:UILabel = UILabel()
    var headerView:UIImageView?{
        return tableView?.viewWithTag(101) as? UIImageView
    }
    var datasource = DataSource()
    var data = [
        [["title":"关注"]],
        [["title":"设置"]],
        [["title":"分享"],["title":"评个分呗!"],["title":"关于"]]
    ]
    let identifier : String = "reuseIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //通知中心.注册登录成功和退出事件
        NotificationCenter.default.addObserver(self, selector: #selector(updateUserinfoData), name: NSNotification.Name(rawValue: NotificationGitLoginSuccessful), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateUserinfoData), name: NSNotification.Name(rawValue: NotificationGitLogOutSuccessful), object: nil)

        tableView = UITableView(frame: self.view.bounds, style: .plain)
        self.view.addSubview(tableView!)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(SettingCell.classForCoder(), forCellReuseIdentifier: identifier as String)
        tableView?.tableFooterView = UIView()
        
        customUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setMyBackgroundColor(UIColor(red: 0/255.0, green: 130/255.0, blue: 210/255.0, alpha: 0))
    }
    
    func customUI() {
        tableView?.contentInset = UIEdgeInsetsMake(175 - 44, 0, 0, 0)
        let header:UIImageView = UIImageView(frame: CGRect(x: 0,y:-175,width: 375,height: 175))
        header.image = UIImage(named: "profile_bk")
        header.tag = 101
        header.contentMode = UIViewContentMode.scaleAspectFill
        profileImageView = UIImageView(image: UIImage(named: "app_logo_90"))
        header.addSubview(profileImageView!)
        
        profileImageView!.snp.makeConstraints { (make) in
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
        nameLable?.font = UIFont.systemFont(ofSize: 14)
        nameLable?.textColor = UIColor.white
        header.addSubview(nameLable!)
        nameLable!.snp.makeConstraints { (make) in
            make.centerX.equalTo(header)
            make.top.equalTo(profileImageView!.snp.bottom).offset(10);
        }
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.login(_:)))
        nameLable?.addGestureRecognizer(tap)
        nameLable?.isUserInteractionEnabled = true
        header.isUserInteractionEnabled = true
        
        //粉丝和关注的人
        header.addSubview(followersLable)
        followersLable.textColor = UIColor.white
        followersLable.font = UIFont.systemFont(ofSize: 13)
        followersLable.snp.makeConstraints { (make) in
            make.right.equalTo((nameLable?.snp.centerX)!).offset(-10)
            make.top.equalTo((nameLable?.snp.bottom)!).offset(10)
        }
        
        header.addSubview(startLable)
        startLable.textColor = UIColor.white
        startLable.font = UIFont.systemFont(ofSize: 13)
        startLable.snp.makeConstraints { (make) in
            make.left.equalTo((nameLable?.snp.centerX)!).offset(10)
            make.top.equalTo(followersLable)
        }
        
        updateUserinfoData()
    }
    
    func login(_ tap:UITapGestureRecognizer){
        NetworkHelper.clearCookies()
        let loginVC = LoginViewController()
        let url = String(format: "https://github.com/login/oauth/authorize/?client_id=%@&redirect_uri=%@&scope=%@", GithubClientID,GithubRedirectUrl,"user,user:email,user:follow,public_repo,repo,repo_deployment,repo:status,delete_repo,notifications,gist,read:repo_hook,write:repo_hook,admin:repo_hook,admin:org_hook,read:org,write:org,admin:org,read:public_key,write:public_key,admin:public_key")
        loginVC.url = url
        loginVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    //MARK: 更新UI
    func updateUserinfoData() {
        user = UserInfoHelper.sharedInstance.user
        isLogin = UserInfoHelper.sharedInstance.isLogin
        if isLogin! == true {
            nameLable?.text = user?.name
            profileImageView?.kf.setImage(with: URL(string: user!.avatar_url!)!)
            followersLable.text = "\((user?.followers!)! as Int) 人关注"
            startLable.text = "关注\((user?.following!)! as Int)人"
        }else{
            nameLable?.text = "登陆"
            profileImageView?.image = UIImage(named: "app_logo_90")
            followersLable.text = ""
            startLable.text = ""
        }
    }
}
extension ProfileViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        let dic = data[indexPath.section][indexPath.row]
        cell.textLabel?.text = dic["title"]
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
}
extension ProfileViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.hexStr("f7f7f7", alpha: 1)
        let label = UILabel()
        view.addSubview(label)
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.gray
        label.snp.makeConstraints { (make) in
            make.centerY.equalTo(view)
            make.left.equalTo(view).offset(10)
        }
        label.text = "联系我们"
        if section == 2 {
            return view
        }
        return nil

    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2 {
            return 30
        }
        return 20
    }
}

extension ProfileViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //下拉
        if scrollView.contentOffset.y < -175 {
            var frame = headerView?.frame
            frame?.size.height = fabs(scrollView.contentOffset.y)
            frame?.origin.y = scrollView.contentOffset.y
            headerView?.frame = frame!
        }else{//上拉
            
        }
        
    }
}
