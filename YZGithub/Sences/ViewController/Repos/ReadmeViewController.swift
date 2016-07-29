//
//  ReadmeViewController.swift
//  YZGithub
//
//  Created by 郑建文 on 16/7/28.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import SnapKit
import ObjectMapper
import SwiftyJSON
//import 


class ReadmeViewController: UIViewController {

    var contentView:UITextView?
    
    var repo:Repository?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customUI()
        fetchReadMeFile()
    }
    func customUI() {
        contentView = UITextView()
        view.addSubview(contentView!)
        contentView?.snp_makeConstraints(closure: { (make) in
            make.size.top.leading.equalTo(view)
        })
    }

    func fetchReadMeFile() {
        Provider.sharedProvider.request(GitHubAPI.RepoReadme(owner: repo!.owner!.login!, repo: repo!.name!)) { (result) in
            switch result {
            case let .Success(response):
                do{
                    let string = try NSJSONSerialization.JSONObjectWithData(response.data, options: .AllowFragments)
                    let decodedData = NSData(base64EncodedString: "\(string.valueForKey("content")!)", options: NSDataBase64DecodingOptions(rawValue: 1))!
                    let decodedString = NSString(data: decodedData, encoding: NSUTF8StringEncoding)!
                    let prettyText = decodedString.richText()
                    self.contentView?.attributedText = prettyText
                }catch{
                    
                }
            case let .Failure(error):
                print(error)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
