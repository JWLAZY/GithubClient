//
//  DevelopListViewModel.swift
//  YZGithub
//
//  Created by 郑建文 on 16/12/3.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import RxSwift
class DevelopListViewModel: NSObject {
    
    var user:ObjUser?
    var users:[ObjUser]?
    
    func fetchList() -> Observable<[ObjUser]> {
        return Observable.create({[weak self](observer) -> Disposable in
            guard let name = self?.user?.login else {
                observer.onError(NetError.parameterError("name"))
                return Disposables.create()
            }
            UserEngine.getFollowers(userName: name, onCompletion: { (users) in
                observer.onNext(users as! [ObjUser])
            }, onError: { (error) in
                observer.onError(error)
            })
            return Disposables.create()
        })
    }
}
