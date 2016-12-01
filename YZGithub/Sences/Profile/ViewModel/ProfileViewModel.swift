//
//  ProfileViewModel.swift
//  YZGithub
//
//  Created by 郑建文 on 16/11/30.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class ProfileViewModel {

    var user = Variable<ObjUser?>(UserInfoHelper.sharedInstance.user)
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateUserInfo), name: NSNotification.Name(rawValue: NotificationGitLoginSuccessful), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateUserInfo), name: NSNotification.Name(rawValue: NotificationGitLogOutSuccessful), object: nil)
    }
    @objc func updateUserInfo() {
        user.value = UserInfoHelper.sharedInstance.user
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: NotificationGitLoginSuccessful), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: NotificationGitLogOutSuccessful), object: nil)
    }
}
