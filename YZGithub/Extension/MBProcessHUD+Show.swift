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
    
    class func showMsg(msg:String?) {
        
        showMsg(msg, view: nil);
    }
    
    class func showError(msg:String?){
        
        showError(msg, view: nil);
    }
    
    class func showMsg(msg:String?, view:UIView?){
        
        if msg == nil || (msg?.isEmpty)! {
            return;
        }
        var aView = view;
        if view == nil {
            aView = UIApplication.sharedApplication().keyWindow;
        }
        let hub = MBProgressHUD.showHUDAddedTo(aView, animated: true)
        hub.labelText = msg
        hub.mode = .Text
        hub.hide(true, afterDelay: 2)
    }
    
    class func showError(msg:String?,view:UIView?){
        
        if msg == nil || (msg?.isEmpty)! {
            return;
        }
        var aView = view;
        if view == nil {
            aView = UIApplication.sharedApplication().keyWindow;
        }
        let hub = MBProgressHUD.showHUDAddedTo(aView, animated: true)
        hub.labelText = msg
        hub.mode = .Text
        hub.labelColor = UIColor.navBarTintColor()
        hub.hide(true, afterDelay: 3)
    }
}