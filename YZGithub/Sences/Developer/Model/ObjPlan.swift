//
//  ObjPlan.swift
//  YZGithub
//
//  Created by 郑建文 on 16/7/25.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import ObjectMapper
class ObjPlan: NSObject, NSCoding,Mappable{

    var private_repos:Int?
    var collaborators:Int?
    var space:Int?
    var name:String?
    
    struct PlanKey {
        
        static let privateReposKey = "private_repos"
        static let collaboratorsKey = "collaborators"
        static let spaceKey = "space"
        static let nameKey = "name"
        
    }
    
    required init?(_ map: Map) {
        //        super.init(map)
    }
    
    func mapping(map: Map) {
        //        super.mapping(map)
        private_repos <- map[PlanKey.privateReposKey]
        collaborators <- map[PlanKey.collaboratorsKey]
        space <- map[PlanKey.spaceKey]
        name <- map[PlanKey.nameKey]
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(private_repos, forKey:PlanKey.privateReposKey)
        aCoder.encodeObject(collaborators, forKey:PlanKey.collaboratorsKey)
        aCoder.encodeObject(space, forKey:PlanKey.spaceKey)
        aCoder.encodeObject(name, forKey:PlanKey.nameKey)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        private_repos = aDecoder.decodeObjectForKey(PlanKey.privateReposKey) as? Int
        collaborators = aDecoder.decodeObjectForKey(PlanKey.collaboratorsKey) as? Int
        space = aDecoder.decodeObjectForKey(PlanKey.spaceKey) as? Int
        name = aDecoder.decodeObjectForKey(PlanKey.nameKey) as? String
    }
    
}
