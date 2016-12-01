//
//  Router.swift
//  YZGithub
//
//  Created by 郑建文 on 16/12/1.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit

public enum RouterPage:String {
    case setting
    case login
}

class Router {
    static let share = Router()
    var rlues:Dictionary<String, Any> = [:]
    init() {
        
    }
    func addPath(path:String,viewController:AnyClass) {
        rlues[path] = viewController
    }
    func vcFor(path:String) -> UIViewController {
        let vc = (rlues[path] as! UIViewController.Type).init()
        return vc
    }
    class func push(form vc:UIViewController,page:RouterPage) {
        vc.navigationController?.pushViewController(Router.share.vcFor(path: page.rawValue), animated: true)
    }
}
