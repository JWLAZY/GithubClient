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
            if user != nil {
                if ( ((user!.name) != nil) && !((user!.name!).isEmpty) && (AppToken().access_token != nil)){
                    return true
                }
            }
            return false
        }
    }
    var isUser:Bool {
        get {
            if (isLogin && ( (user!.type!) == "User" )) {
                return true
            }
            return false
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
        
        ObjUser.deleteUserInfo()
    }
}
