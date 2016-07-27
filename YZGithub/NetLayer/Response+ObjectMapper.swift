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
}