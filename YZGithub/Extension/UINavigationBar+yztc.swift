//
//  UINavigationBar+yztc.swift
//  YZGithub
//
//  Created by 郑建文 on 16/7/14.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import Foundation
import UIKit

var key: String = "coverView"

extension UINavigationBar {
    //计算属性
    var coverView: UIView? {
        get {
            return objc_getAssociatedObject(self, &key) as? UIView
        }
        set {
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func setMyBackgroundColor(color: UIColor) {
        
        if self.coverView != nil {
            self.coverView!.backgroundColor = color
        }else {
            self.setBackgroundImage(UIImage(), forBarMetrics: .Default)
            self.shadowImage = UIImage()
            let view = UIView(frame: CGRectMake(0, -20, UIScreen.mainScreen().bounds.size.width, CGRectGetHeight(self.bounds) + 20))
            view.userInteractionEnabled = false
            view.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
            self.insertSubview(view, atIndex: 0)
            
            view.backgroundColor = color
            self.coverView = view
        }
    }
    func setMyBackgroundColorAlpha(alpha: CGFloat) {
        
        guard let coverView = self.coverView else {
            return
        }
        self.coverView!.backgroundColor = coverView.backgroundColor?.colorWithAlphaComponent(alpha)
    }

}