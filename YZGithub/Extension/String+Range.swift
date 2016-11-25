//
//  String+Range.swift
//  YZGithub
//
//  Created by 郑建文 on 16/8/29.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import Foundation

extension String {
    func NSRangeFromRange(_ range:Range<String.Index>) -> NSRange? {
        let utf16view = self.utf16
        let from = String.UTF16View.Index(range.lowerBound, within: utf16view)
        let to = String.UTF16View.Index(range.upperBound, within: utf16view)
//        return NSMakeRange(utf16view.startIndex.distanceTo(from), from.distanceTo(to))
//        return (from...to)
        return nil
//        return NSRange(from.)
//        return NSMakeRange(<#T##loc: Int##Int#>, <#T##len: Int##Int#>)
    }
}
