//
//  NetworkHelper.swift
//  YZGithub
//
//  Created by 郑建文 on 16/7/24.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit

public class NetworkHelper: NSObject {

    public static func clearCookies() {
        
        let storage : NSHTTPCookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        for cookie in storage.cookies! {
            storage.deleteCookie(cookie)
        }
        NSUserDefaults.standardUserDefaults()
        
    }
}
