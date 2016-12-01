//
//  YZWebViewController.swift
//  YZGithub
//
//  Created by 郑建文 on 16/7/24.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import WebKit
import MBProgressHUD

class YZWebViewController: BaseViewController, WKNavigationDelegate {

    var webView:UIWebView?
    var hub:MBProgressHUD?
    
    var url:String? {
        didSet{
            let urlTemp = URL(string: url!)
            let urlRequest = URLRequest(url: urlTemp!)
            if webView != nil {
                self.webView!.loadRequest(urlRequest)
            }
        }
    }
    var html:String?{
        didSet{
            if  webView != nil {
                self.webView?.loadHTMLString(html!, baseURL: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setMyBackgroundColor(UIColor.navBarTintColor())
        customInit()
    }
    
    func customInit() {
        configWebView()
    }
    func configWebView() {
        
        var frame = self.view.bounds
        frame.origin.y = -44
        frame.size.height += 44
        webView = UIWebView(frame: frame)
        
        self.view.addSubview(webView!)
        
        if url != nil {
            let urlTmp = URL(string: url!)
            let urlRequest = URLRequest(url: urlTmp!)
            self.webView!.loadRequest(urlRequest)
        }
        if html != nil {
            self.webView?.loadHTMLString(html!, baseURL: nil)
        }
        
        webView?.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
extension YZWebViewController:UIWebViewDelegate{
    
    func webViewDidStartLoad(_ webView: UIWebView) {
       hub = MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        hub?.hide(animated: true)
        self.webView!.scrollView.contentInset = UIEdgeInsetsMake(self.topOffset, 0, 0, 0)
        self.webView!.scrollView.scrollRectToVisible(CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 0.1), animated: true)
        
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        hub?.hide(animated: true)
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    func goBack() {
        
        if (webView!.canGoBack) {
            webView!.goBack()
        }else {
            leftItemAction(nil)
        }
    }
    
    func goForward() {
        if webView!.canGoForward {
            webView!.goForward()
        }else {
            
        }
    }
}
