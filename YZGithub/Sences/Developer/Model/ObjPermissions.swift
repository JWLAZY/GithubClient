//
//  ObjPermissions.swift
//  YZGithub
//
//  Created by 郑建文 on 16/7/25.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import ObjectMapper

class ObjPermissions: NSObject,Mappable {
    var admin:Int?
    var pull:Int?
    var push:Int?
    
    required init?(_ map: Map) {
        //        super.init(map)
    }
    
    func mapping(map: Map) {
        //        super.mapping(map)
        admin <- map["admin"]
        pull <- map["pull"]
        push <- map["push"]
    }

}
