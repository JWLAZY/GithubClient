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

    class func showMessage(message:String,view:UIView){
        let hub = MBProgressHUD.showHUDAddedTo(view, animated: true)
        hub.labelText = message
        hub.mode = .Text
        hub.hide(true, afterDelay: 2)
    }
    class func showError(error:String,view:UIView){
        let hub = MBProgressHUD.showHUDAddedTo(view, animated: true)
        hub.labelText = error
        hub.mode = .Text
        hub.labelColor = UIColor.navBarTintColor()
        hub.hide(true, afterDelay: 3)
    }
    
}
