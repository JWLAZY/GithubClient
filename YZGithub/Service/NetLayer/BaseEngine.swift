//
//  BaseEngine.swift
//  YZGithub
//
//  Created by 郑建文 on 16/11/30.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit

typealias Completion = (Any)->()
typealias EngineError = (Error) -> ()

enum NetError:Error {
    case seriaelError(String)
    case httpError(Error)
    var localizedDescription: String{
        switch self {
        case .httpError(let error):
            return ("网络请求错误: \(error)")
        case .seriaelError(let msg):
            return (msg)
        }
    }
}

class BaseEngine: NSObject {

}

