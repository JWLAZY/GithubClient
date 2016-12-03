//
//  Router.swift
//  YZGithub
//
//  Created by 郑建文 on 16/12/1.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit

public enum RouterPage {
    case setting
    case login(url:String)
    
    static var rlues:Dictionary<String, Any> = [:]
    
    func addPath(viewController:AnyClass) {
        RouterPage.rlues[self.path()] = viewController
    }
    func path() -> String {
        switch self {
        case .setting:
            return "setting"
        case .login(_):
            return "login"
        }
    }
    func vc() -> UIViewController {
        var vc = (RouterPage.rlues[self.path()] as! UIViewController.Type).init()
        switch self {
        case .login(let url):
            let loginvc = vc as! LoginViewController
            loginvc.url = url
            vc = loginvc
            vc.hidesBottomBarWhenPushed = true
        default:
            print("")
        }
        return vc
    }
}

class Router {
    class func push(form vc:UIViewController,page:RouterPage) {
        vc.navigationController?.pushViewController(page.vc(), animated: true)
    }
}
