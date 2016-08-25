//
//  BaseNavController.swift
//  YZGithub
//
//  Created by 郑建文 on 16/8/24.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit

class BaseNavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /// 感觉不同的导航控制器跳转到不同的界面
        if let ident = self.restorationIdentifier {
            switch ident {
            case "new":
                let vc = NewsViewController(nibName: nil, bundle: nil)
                self.pushViewController(vc, animated: true)
            default:
                GlobalHubHelper.showError("没有这个控制器", view: self.view)
            }
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
