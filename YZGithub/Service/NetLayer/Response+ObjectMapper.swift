//
//  Response+ObjectMapper.swift
//  YZGithub
//
//  Created by 郑建文 on 16/7/26.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper

public enum PageType:String {
    case last
    case next
    case first
    case prev
}

public extension Response{
    public func mapObject<T: Mappable>(_ type: T.Type) throws -> T {
        
        guard let object = Mapper<T>().map(JSONObject: try mapJSON()) else {
            throw Error.jsonMapping(self)
        }
        return object
    }
    public func mapArray<T: Mappable>(_ type: T.Type) throws -> [T] {
        
        guard let objects = Mapper<T>().mapArray(JSONObject: try mapJSON()) else {
            throw Error.jsonMapping(self)
        }
        return objects
    }
    public func pageNumberWithType(_ type:PageType) -> Int? {
        if let linkString = self.Link() {
            let linkArray = linkString.components(separatedBy: ",")
            for link in linkArray {
                if link.contains(type.rawValue) {
                    let startindex = link.range(of:"page=")?.upperBound
                    let endindex = link.range(of: ">;")?.lowerBound
                    if let start = startindex , let end = endindex {
                        let page =  link.substring(with: start..<end)
                            return Int(page)
                    }
                }
            }
        }
        return nil
    }
    fileprivate func Link() -> String? {
        let httpresponse =  self.response as? HTTPURLResponse
        if let httpresponse = httpresponse {
            let allHeader = httpresponse.allHeaderFields as? [String:AnyObject]
            return allHeader?["Link"] as? String
        }
        return nil
    }
}
