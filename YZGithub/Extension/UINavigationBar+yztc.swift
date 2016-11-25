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
    
    func setMyBackgroundColor(_ color: UIColor) {
        if self.coverView != nil {
            self.coverView!.backgroundColor = color
        }else {
            self.setBackgroundImage(UIImage(), for: .default)
            self.shadowImage = UIImage()
            let view = UIView(frame: CGRect(x: 0, y: -20, width: UIScreen.main.bounds.size.width, height: self.bounds.height + 20))
            view.isUserInteractionEnabled = false
            view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            self.insertSubview(view, at: 0)
            view.backgroundColor = color
            self.coverView = view
        }
    }
    func setMyBackgroundColorAlpha(_ alpha: CGFloat) {
        guard let coverView = self.coverView else {
            return
        }
        self.coverView!.backgroundColor = coverView.backgroundColor?.withAlphaComponent(alpha)
    }

}
