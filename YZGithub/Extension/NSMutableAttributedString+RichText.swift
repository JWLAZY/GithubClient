//
//  NSMutableAttributedString+RichText.swift
//  YZGithub
//
//  Created by 郑建文 on 16/8/29.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {
    func linkWithString(string:String,inString:String,url:String) {
        let range = inString.NSRangeFromRange(inString.rangeOfString(string)!)
        self.addAttributes([NSFontAttributeName:UIFont.italicSystemFontOfSize(16),NSLinkAttributeName:NSURL(string:url)!], range: range)
    }
}
