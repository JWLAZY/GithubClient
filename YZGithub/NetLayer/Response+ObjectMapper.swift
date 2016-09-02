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
    public func mapObject<T: Mappable>(type: T.Type) throws -> T {
        guard let object = Mapper<T>().map(try mapJSON()) else {
            throw Error.JSONMapping(self)
        }
        return object
    }
    public func mapArray<T: Mappable>(type: T.Type) throws -> [T] {
        guard let objects = Mapper<T>().mapArray(try mapJSON()) else {
            throw Error.JSONMapping(self)
        }
        return objects
    }
    public func pageNumberWithType(type:PageType) -> Int? {
        if let linkString = self.Link() {
            let linkArray = linkString.componentsSeparatedByString(",")
            for link in linkArray {
                if link.containsString(type.rawValue) {
                    let startindex = link.rangeOfString("page=")?.endIndex
                    let endindex = link.rangeOfString(">;")?.startIndex
                    if let start = startindex , let end = endindex {
                        let page =  link.substringWithRange(start..<end)
                            return Int(page)
                    }
                }
            }
        }
        return nil
    }
    private func Link() -> String? {
        let httpresponse =  self.response as? NSHTTPURLResponse
        if let httpresponse = httpresponse {
            let allHeader = httpresponse.allHeaderFields as? [String:AnyObject]
            return allHeader?["Link"] as? String
        }
        return nil
    }
}