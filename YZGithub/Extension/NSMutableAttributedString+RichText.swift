//
//  NSMutableAttributedString+RichText.swift
//  YZGithub
//
//  Created by 郑建文 on 16/8/29.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {
    func linkWithString(string:String,inString:String) {
        let range = inString.NSRangeFromRange(inString.rangeOfString(string)!)
        self.addAttributes([NSUnderlineStyleAttributeName:1,NSUnderlineColorAttributeName:UIColor.blueColor(),NSForegroundColorAttributeName:UIColor.blueColor()], range: range)
    }
}
