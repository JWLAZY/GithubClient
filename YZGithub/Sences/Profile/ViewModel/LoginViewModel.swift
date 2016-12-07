//
//  LoginViewModel.swift
//  YZGithub
//
//  Created by 郑建文 on 16/11/30.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import Foundation
import RxSwift
import MBProgressHUD

class LoginViewModel {
    
    deinit {

    }
    func loginin(code: String) -> Observable<Any> {
        return Observable.create({ (observer) -> Disposable in
            let para = [
                "client_id":GithubClientID,
                "client_secret":GithubClientSecret,
                "code":code,
                "redirect_uri":GithubRedirectUrl,
                ]
            let task = LoginEngine.loginIn(parameters: para, onCompletion: { (result) in
                observer.onNext(result)
                print("---result---\(result)")
            }, onError: { (error) in
                observer.onError(error)
            })
            return Disposables.create {
                task.cancel()
            } 
        })
    }
    
}
