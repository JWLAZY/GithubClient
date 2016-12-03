//
//  UserEngine.swift
//  YZGithub
//
//  Created by 郑建文 on 16/11/30.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import ObjectMapper

class UserEngine: BaseEngine {
    class func getUserInfo(token:String, onCompletion: @escaping Completion, onError:@escaping EngineError) {
        fetchData(api: GitHubAPI.myInfo, model: ObjUser.self, onCompetion: {
            result in
            ObjUser.saveUserInfo(result)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationGitLoginSuccessful), object:nil)
            onCompletion(result)
        }, onError: {error in
            onError(error)
        })
    }
    class func getFollowers(userName:String, onCompletion:@escaping Completion,onError:@escaping EngineError) {
        fetchDatas(api: GitHubAPI.followers(username: userName), model: ObjUser.self, onCompetion: {
            result -> () in
            onCompletion(result)
        }, onError: { error in
            onError(error)
        })
    }
}
