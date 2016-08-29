//
//  Commit.swift
//  YZGithub
//
//  Created by 郑建文 on 16/7/29.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import ObjectMapper

//"commit": {
    //            "sha": "7fd1a60b01f91b314f59955a4e4d4e80d8edf11d",
    //            "url": "https://api.github.com/repos/octocat/Hello-World/commits/7fd1a60b01f91b314f59955a4e4d4e80d8edf11d"
    //        }
class Commit: NSObject,Mappable {
    var sha:String?
    var url:String?
    var message:String?
    required init?(_ map: Map) {
        
    }
    override init() {
        
    }
    func mapping(map: Map) {
        sha <- map["sha"]
        url <- map["url"]
        message <- map["message"]
    }
}
