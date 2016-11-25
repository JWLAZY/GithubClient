//
//  LoginViewController.swift
//  YZGithub
//
//  Created by 郑建文 on 16/7/24.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire
import ObjectMapper
import SwiftyJSON


class LoginViewController: YZWebViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.navigationBar.setMyBackgroundColor(UIColor.navBarTintColor())
    }
    
    deinit{
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func webViewDidStartLoad(_ webView: UIWebView) {
        super.webViewDidStartLoad(webView)
    }
    override func webViewDidFinishLoad(_ webView: UIWebView) {
        super.webViewDidFinishLoad(webView)
        let  url:String =  (webView.request?.url?.absoluteString)!
        let codePrefix:String = "code="
        if url.contains(codePrefix) {
            let range = url.range(of: codePrefix)!
            let index = url.characters.distance(from: url.startIndex, to: range.lowerBound) + 5
            let codeR = url.characters.index(url.startIndex, offsetBy: index) ..< url.endIndex
            let code = url.substring(with: codeR)
            signIn(code)
        }
    }
    
    func signIn(_ code:String) {
        let para = [
            "client_id":GithubClientID,
            "client_secret":GithubClientSecret,
            "code":code,
            "redirect_uri":GithubRedirectUrl,
        ]
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        Alamofire.request("https://github.com/login/oauth/access_token", method: HTTPMethod.post, parameters: para, encoding: JSONEncoding.default).responseString { [weak self](response) in
            hud.hide(animated: true)
            switch response.result {
            case .failure(let error):
                MBProgressHUD.showError("登陆失败:\(error)")
            case .success(_):
                let str = String(data: response.data!, encoding: String.Encoding.utf8)
                if let str = str {
                    
                    let arr:[String] = (str.components(separatedBy: "&"))
                    if arr.count > 0 {
                        
                        let accesstoken = arr[0].substring(from: arr[0].index(arr[0].startIndex, offsetBy: 13))
                        let scope = arr[1].substring(from: arr[1].index(arr[1].startIndex, offsetBy: 7))
                        let tokentype = arr[2].substring(from: arr[2].index(arr[2].startIndex, offsetBy: 11))
                        
                        //获取token 并保存到userdefault中
                        var token = AppToken.shareInstance
                        token.access_token = String(format: "token %@", accesstoken)
                        token.token_type = tokentype
                        token.scope = scope
                        
                        self!.getUserInfo(accesstoken)
                    }
                }
            }

        }
    }
    
    func getUserInfo(_ token:String) {
        let provider = Provider.sharedProvider
        provider.request(GitHubAPI.myInfo, completion:{
            (result) -> () in
            switch result{
            case let .success(response):
                do {
                    if let gitUser:ObjUser = Mapper<ObjUser>().map(JSONObject: try response.mapJSON()) {
                        self.navigationController?.popViewController(animated: true)
                        ObjUser.saveUserInfo(gitUser)
                        //post successful noti
                        
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationGitLoginSuccessful), object:nil)
                        
                    } else {
                    }

                }catch{
                }
            
            case let .failure(error):
                guard let error = error as? CustomStringConvertible else {
                    break
                }
                print(error)
            }
        } )
    }
}
