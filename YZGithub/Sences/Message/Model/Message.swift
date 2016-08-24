//
//  Message.swift
//  YZGithub
//
//  Created by 郑建文 on 16/8/24.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import ObjectMapper

enum Reason:String {
    case subscribed
    case manual
    case author
    case comment
    case mention
    case team_mention
    case state_change
    case assign
}

class Message:NSObject,Mappable {
    var subject:Subject?
    var last_read_at:String?
    var unread:Int?
    var id:String?
    var updated_at:String?
    var reason:Reason?
    var repository:Repository?
    var url:String?
    required init?(_ map: Map) { 
        
    }
    
    func mapping(map: Map) {
        subject <- map["subject"]
        last_read_at <- map["last_read_at"]
        unread <- map["unread"]
        id <- map["id"]
        updated_at <- map["updated_at"]
        reason <- map["reason"]
        repository <- map["repository"]
        url <- map["url"]
    }
}
