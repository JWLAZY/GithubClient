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
import Alamofire
//import 


class ReadmeViewController: UIViewController {

    var contentView:UITextView?
    
    var repo:Repository?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customUI()
        fetchReadMeFile()
    }
    
    deinit{
//        print("释放")
    }
    func customUI() {
        contentView = UITextView()
        view.addSubview(contentView!)
        contentView?.snp.makeConstraints({ (make) in
            make.size.top.leading.equalTo(view)
        })
    }

    func fetchReadMeFile() {
        Provider.sharedProvider.request(GitHubAPI.repoReadme(owner: repo!.owner!.login!, repo: repo!.name!)) { (result) in
            switch result {
            case let .success(response):
                if response.statusCode == 404 {
                    self.contentView?.text = "作者太懒,什么都没有写"
                    return
                }
                do{
                    if Thread.current.isMainThread {
                        DispatchQueue.global(qos: .utility).async(execute: { 
                            do{
                                let string = try JSONSerialization.jsonObject(with: response.data, options: .allowFragments)
//                                let content = string as []
                                let decodedData = NSData(base64Encoded: string as! String, options: NSData.Base64DecodingOptions(rawValue: 1))!
                                let decodedString = NSString(data: decodedData as Data, encoding: String.Encoding.utf8.rawValue)!
                                let prettyText = decodedString.richText()
                                DispatchQueue.main.async(execute: { 
                                    self.contentView?.attributedText = prettyText
                                })
                            }catch{
                            }
                        })
                    }else{
                        let string = try JSONSerialization.jsonObject(with: response.data, options: .allowFragments)
                        let decodedData = NSData(base64Encoded: string as! String, options: NSData.Base64DecodingOptions(rawValue: 1))!
                        let decodedString = NSString(data: decodedData as Data, encoding: String.Encoding.utf8.rawValue)!
                        let prettyText = decodedString.richText()
                        self.contentView?.attributedText = prettyText
                    }
                }catch{
                    
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
