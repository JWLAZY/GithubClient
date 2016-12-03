//
//  LoginViewController.swift
//  YZGithub
//
//  Created by 郑建文 on 16/7/24.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire
import ObjectMapper
import SwiftyJSON
import RxCocoa
import RxSwift

class LoginViewController: YZWebViewController {

    let viewModel:LoginViewModel = LoginViewModel()
    let bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    deinit{
       print("登陆界面销毁") 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func webViewDidStartLoad(_ webView: UIWebView) {
        super.webViewDidStartLoad(webView)
    }
    override func webViewDidFinishLoad(_ webView: UIWebView) {
        super.webViewDidFinishLoad(webView)
        let  url:String =  (webView.request?.url?.absoluteString)!
        let codePrefix:String = "code="
        if url.contains("code=") {
            let range = url.range(of: codePrefix)!
            let index = url.characters.distance(from: url.startIndex, to: range.lowerBound) + 5
            let codeR = url.characters.index(url.startIndex, offsetBy: index) ..< url.endIndex
            let code = url.substring(with: codeR)
            
            viewModel.loginin(code: code).subscribe(onNext: { [weak self](msg) in
                _ = self?.navigationController?.popViewController(animated: true)
            }, onError: { (error) in
                MBProgressHUD.showMsg("\(error)")
            }, onCompleted: nil, onDisposed: nil).addDisposableTo(bag)
            
        }
    }
    
}
