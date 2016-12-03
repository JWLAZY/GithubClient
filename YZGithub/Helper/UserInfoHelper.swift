//
//  UserInfoHelper.swift
//  YZGithub
//
//  Created by 郑建文 on 16/7/26.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit

class UserInfoHelper: NSObject {

    static let sharedInstance = UserInfoHelper()
    
    var user:ObjUser? {
        get{
            let user = ObjUser.loadUserInfo()
            return user
        }
        set(newValue){
            ObjUser.saveUserInfo(newValue)
        }
    }
    var isLogin:Bool{
        get {
            if let u = user {
                guard let _ = u.name,let _ = AppToken().access_token else {
                    return false
                }
                return true
            }
            return false
        }
    }
    var isUser:Bool {
        get {
            guard isLogin,let t = user?.type, t == "User" else {
                return false
            }
            return true
        }
    }

    var userToken:String {
        get {
            return AppToken().access_token!
        }
        set(newtoken) {
            var token = AppToken.shareInstance
            token.access_token = newtoken
        }
    }
    func deleteUser() {
        _ = ObjUser.deleteUserInfo()
    }
}
