//
//  LoginEngine.swift
//  YZGithub
//
//  Created by 郑建文 on 16/11/30.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import Alamofire

class LoginEngine: BaseEngine {
    class func loginIn(parameters:Dictionary<String, Any>, onCompletion: @escaping Completion, onError:@escaping EngineError) -> URLSessionTask{
        let request = Alamofire.request("https://github.com/login/oauth/access_token", method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default).responseString { (response) in
            switch response.result {
            case .failure(let error):
                onError(error)
            case .success(_):
                let str = String(data: response.data!, encoding: String.Encoding.utf8)
                if let str = str {
                    
                    let arr:[String] = (str.components(separatedBy: "&"))
                    if arr.count > 0 {
                        
                        let accesstoken = arr[0].substring(from: arr[0].index(arr[0].startIndex, offsetBy: 13))
                        let scope = arr[1].substring(from: arr[1].index(arr[1].startIndex, offsetBy: 7))
                        let tokentype = arr[2].substring(from: arr[2].index(arr[2].startIndex, offsetBy: 11))
                        
                        //获取token 并保存到userdefault中
                        var token = AppToken.shareInstance
                        token.access_token = String(format: "token %@", accesstoken)
                        token.token_type = tokentype
                        token.scope = scope
//                        onCompletion(accesstoken)
                        UserEngine.getUserInfo(token: accesstoken, onCompletion: { (token) in
                            onCompletion(accesstoken)
                        }, onError: { (error) in
                            onError(error)
                        })
                    }
                }
            }
            
        }
        return request.task!
    }
}
