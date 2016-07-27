//
//  BaseTabBarViewController.swift
//  YZGithub
//
//  Created by 郑建文 on 16/7/13.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit

class BaseTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        custemUI()
    }

    func custemUI() {
        self.tabBar.tintColor = UIColor.whiteColor()
    }
}
