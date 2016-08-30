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
    func NSRangeFromRange(range:Range<String.Index>) -> NSRange {
        let utf16view = self.utf16
        let from = String.UTF16View.Index(range.startIndex, within: utf16view)
        let to = String.UTF16View.Index(range.endIndex, within: utf16view)
        return NSMakeRange(utf16view.startIndex.distanceTo(from), from.distanceTo(to))
    }
}