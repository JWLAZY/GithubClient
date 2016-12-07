//
//  DevelopListViewModel.swift
//  YZGithub
//
//  Created by 郑建文 on 16/12/3.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import RxSwift
class DevelopListViewModel:BaseViewModel {
    
    var user:Variable<ObjUser>?
    var users:Variable<[ObjUser]>?
    
    override init() {
        
    }
    
    func fetchList() -> Observable<[ObjUser]> {
        return Observable.create({[weak self](observer) -> Disposable in
            guard let name = self?.user?.value.login else {
                observer.onError(NetError.parameterError("name"))
                return Disposables.create()
            }
            UserEngine.getFollowers(userName: name, onCompletion: { (users) in
                observer.onNext(users as! [ObjUser])
                if let us = users as? [ObjUser] {
                    self?.users = Variable<[ObjUser]>(us)
                }
            }, onError: { (error) in
                observer.onError(error)
            })
            return Disposables.create()
        })
    }
    func fetchListNoRx(){
        guard let name = self.user?.value.login else {
            return
        }
        UserEngine.getFollowers(userName: name, onCompletion: { [weak self](users) in   
            if let us = users as? [ObjUser] {
                self?.users?.value = us
            }
        }, onError: { (error) in
            
        })
    }
}
