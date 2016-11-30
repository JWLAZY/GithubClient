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
        let provider = Provider.sharedProvider
        provider.request(GitHubAPI.myInfo, completion:{
            (result) -> () in
            switch result{
            case let .success(response):
                do {
                    if let gitUser:ObjUser = Mapper<ObjUser>().map(JSONObject: try response.mapJSON()) {
                        
                        onCompletion("获取好友信息成功")
                        ObjUser.saveUserInfo(gitUser)
                        
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationGitLoginSuccessful), object:nil)
                        
                    } else {
                    }
                }catch{
                    onError(NetError.seriaelError("解析错误"))
                }
            case let .failure(error):
                onError(NetError.httpError(error))
            }
        } )
    }
}
