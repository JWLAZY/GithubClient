//
//  NSMutableAttributedString+RichText.swift
//  YZGithub
//
//  Created by 郑建文 on 16/8/29.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {
    func linkWithString(_ string:String,inString:String,url:String) {
        let range = inString.NSRangeFromRange(inString.range(of: string)!)
        self.addAttributes([NSFontAttributeName:UIFont.italicSystemFont(ofSize: 16),NSLinkAttributeName:URL(string:url)!], range: range)
    }
}
