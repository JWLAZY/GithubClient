//
//  MBProcessHUD+Show.swift
//  YZGithub
//
//  Created by wmg on 16/9/1.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import Foundation
import MBProgressHUD

extension MBProgressHUD{
    
    
    class func showMsg(_ msg:String?, view:UIView? = UIApplication.shared.keyWindow){
        
        if msg == nil || msg!.isEmpty {
            return;
        }
        
        let hub = MBProgressHUD.showAdded(to: view!, animated: true)
        hub.labelText = msg!
        hub.mode = .text
        hub.hide(true, afterDelay: 2)
    }
    
    class func showError(_ msg:String?,view:UIView? = UIApplication.shared.keyWindow){
        
        if msg == nil || msg!.isEmpty {
            return;
        }
        
        let hub = MBProgressHUD.showAdded(to: view!, animated: true)
        hub.labelText = msg!
        hub.mode = .text
        hub.labelColor = UIColor.navBarTintColor()
        hub.hide(true, afterDelay: 3)
    }
}
