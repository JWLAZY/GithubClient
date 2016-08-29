//
//  Event.swift
//  YZGithub
//
//  Created by 郑建文 on 16/8/24.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import ObjectMapper

enum EventType:String {
    case IssueCommentEvent
    case PullRequestEvent
    case WatchEvent
    case CreateEvent
    case PushEvent
}

class Event:NSObject,Mappable {
    var created_at:String?
    var type:EventType?
    var payload:NSDictionary?
    var id:String?
    var actor:ObjUser?
    var repo:Repository?
    var ispublic:Bool?
    required init?(_ map: Map) { 
        
    }
    
    func mapping(map: Map) {
        created_at <- map["created_at"]
        type <- map["type"]
        payload <- map["payload"]
        id <- map["id"]
        actor <- map["actor"]
        repo <- map["repo"]
        ispublic <- map["public"]
    }
}