//
//  BaseEngine.swift
//  YZGithub
//
//  Created by 郑建文 on 16/11/30.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import ObjectMapper

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

class BaseEngine {
    let provider = Provider.sharedProvider
    class func fetchData<T:Mappable>(api:GitHubAPI,model:T.Type,onCompetion: @escaping (T)->(), onError:@escaping (Error)->()) {
        let engine = BaseEngine()
        engine.provider.request(api, completion: {
            (result) -> () in
            switch result{
            case .success(let res):
                do {
                    let object = Mapper<T>().map(JSON: try res.mapJSON() as! [String : Any])
                    guard let r = object else {
                        onError(NetError.seriaelError("no data"))
                        return
                    }
                    onCompetion(r)
                }catch{
                    onError(NetError.seriaelError("result is not json "))
                }
            case .failure(let error):
                onError(NetError.httpError(error))
            }
        })
    }
}

