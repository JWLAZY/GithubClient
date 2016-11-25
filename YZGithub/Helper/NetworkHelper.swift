//
//  NetworkHelper.swift
//  YZGithub
//
//  Created by 郑建文 on 16/7/24.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit

open class NetworkHelper: NSObject {

    open static func clearCookies() {
        
        let storage : HTTPCookieStorage = HTTPCookieStorage.shared
        for cookie in storage.cookies! {
            storage.deleteCookie(cookie)
        }
        UserDefaults.standard
        
    }
}
