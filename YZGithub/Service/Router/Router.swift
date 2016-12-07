//
//  Router.swift
//  YZGithub
//
//  Created by 郑建文 on 16/12/1.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import RxSwift

public enum RouterPage {
    case setting
    case login(url:String)
    case DeveList(ofUser:ObjUser?)
    
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
        case .DeveList(_):
            return "develist"
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
        case .DeveList(let user):
            let listvc = vc as! DeveloperListViewController
            listvc.vm.user = Variable<ObjUser>(user!)
            listvc.listType = .follewers
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
