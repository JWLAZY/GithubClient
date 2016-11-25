//
//  GlobalHubHelper.swift
//  YZGithub
//
//  Created by 郑建文 on 16/8/10.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import MBProgressHUD

class GlobalHubHelper {

    class func showMessage(_ message:String,view:UIView){
        MBProgressHUD.hideAllHUDs(for: view, animated: true)
        let hub = MBProgressHUD.showAdded(to: view, animated: true)
        hub.labelText = message
        hub.mode = .text
        hub.hide(true, afterDelay: 2)
    }
    class func showError(_ error:String,view:UIView){
        MBProgressHUD.hideAllHUDs(for: view, animated: true)
        let hub = MBProgressHUD.showAdded(to: view, animated: true)
        hub.labelText = error
        hub.mode = .text
        hub.labelColor = UIColor.navBarTintColor()
        hub.hide(true, afterDelay: 3)
    }
    
}
