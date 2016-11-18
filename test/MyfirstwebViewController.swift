//
//  MyfirstwebViewController.swift
//  test
//
//  Created by 陈小爷 on 2016/10/28.
//  Copyright © 2016年 陈小爷. All rights reserved.
//

import UIKit
import WebKit

class MyfirstwebViewController: UIViewController,WKNavigationDelegate,WKUIDelegate {
var webview = WKWebView()
    var btnBack = UIBarButtonItem()
    var btnForward = UIBarButtonItem()
    var progBar = UIProgressView()
    override func viewDidLoad() {
        super.viewDidLoad()
        //创建wkwebview
        //获取导航栏高度
     //   let navHeight = self.navigationController?.navigationBar.frame.height
        //获取状态栏高度
    //    let statusHeight = UIApplication.shared.statusBarFrame.height
        webview = WKWebView(frame: CGRect(x:0, y:0,width:self.view.frame.width, height:self.view.frame.height))
        
        //创建网址
        let url = NSURL(string: "http://www.jianshu.com/users/040395b7230c/latest_articles")
       // let url = NSURL(string: "http://evt.tiancity.com/csol2/1565/home/index.php")
        //创建请求
        let request = NSURLRequest(url: url! as URL)
        //加载请求
        webview.load(request as URLRequest)
        //添加wkwebview
        self.view.addSubview(webview)
        self.webview.navigationDelegate = self
        self.webview.uiDelegate = self
        

        setNavBar()
        
        progBar = UIProgressView(frame: CGRect(x:0, y:0, width:self.view.frame.width, height:30))
        progBar.progress = 0.0
        progBar.tintColor = UIColor.red
        self.webview.addSubview(progBar)
       // self.webview.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)
        
        // Do any additional setup after loading the view.
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.navigationItem.title = self.webview.title
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func toBack() {
        if self.webview.canGoBack {
            self.webview.goBack()
        }
    }
    
    func toForward() {
        if self.webview.canGoForward {
            self.webview.goForward()
        }
    }
    func setNavBar() {
        
        let leftBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self,
                                         action: #selector(backToPrevious))
        self.navigationItem.leftBarButtonItem = leftBarBtn
       // btnBack = UIBarButtonItem(title: "后退", style: UIBarButtonItemStyle.plain, target: self, action: #selector(toBack))
        btnForward = UIBarButtonItem(title: "前进", style: UIBarButtonItemStyle.plain, target: self, action: #selector(toForward))
        //self.navigationItem.leftBarButtonItem = btnBack
        self.navigationItem.rightBarButtonItem = btnForward
    }
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        //如果目标主视图不为空,则允许导航
        if !(navigationAction.targetFrame?.isMainFrame != nil) {
            self.webview.load(navigationAction.request)
        }
        return nil
    }
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) -> Void in
            completionHandler()
        }))
        self.present(alert, animated: true, completion: nil)
    }
  /*   func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutableRawPointer) {
        if keyPath == "estimatedProgress" {
            self.progBar.alpha = 1.0
            progBar.setProgress(Float(webview.estimatedProgress), animated: true)
            //进度条的值最大为1.0
            if(self.webview.estimatedProgress >= 1.0) {
                UIView.animate(withDuration: 0.3, delay: 0.1, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
                    self.progBar.alpha = 0.0
                    }, completion: { (finished:Bool) -> Void in
                        self.progBar.progress = 0
                })
            }
        }
    }
    func viewWillDisappear(animated: Bool) {
        webview.removeObserver(self, forKeyPath: "estimatedProgress")
    }*/
    
    //返回按钮点击响应
    func backToPrevious(){
        self.dismiss(animated: true) { () -> Void in
            
        }
    }
}
