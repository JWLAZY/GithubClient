//
//  SearchUserResponse.swift
//  YZGithub
//
//  Created by 郑建文 on 16/7/27.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class SearchUserResponse: NSObject,Mappable{
    
    var totalCount:Int?
    var incompleteResults:Bool?
    var items:[ObjUser]?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        //        super.mapping(map)
        totalCount <- map["total_count"]
        incompleteResults <- map["incomplete_results"]
        items <- map["items"]
    }
    
}