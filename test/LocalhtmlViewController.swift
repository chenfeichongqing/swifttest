//
//  LocalhtmlViewController.swift
//  test
//
//  Created by 陈小爷 on 2016/11/4.
//  Copyright © 2016年 陈小爷. All rights reserved.
//

import UIKit
import WebKit

class LocalhtmlViewController: UIViewController ,WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler{
    
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
        
        let configuretion = WKWebViewConfiguration()
        
        // Webview的偏好设置
        configuretion.preferences = WKPreferences()
        configuretion.preferences.minimumFontSize = 10
        configuretion.preferences.javaScriptEnabled = true
        // 默认是不能通过JS自动打开窗口的，必须通过用户交互才能打开
        configuretion.preferences.javaScriptCanOpenWindowsAutomatically = false
        // 通过js与webview内容交互配置
        configuretion.userContentController = WKUserContentController()
        
        // 添加一个JS到HTML中，这样就可以直接在JS中调用我们添加的JS方法
        let script = WKUserScript(source: "function showAlert() { userid=10001 }",
                                  injectionTime: .atDocumentStart,// 在载入时就添加JS
            forMainFrameOnly: true) // 只添加到mainFrame中
        configuretion.userContentController.addUserScript(script)
        
        // 添加一个名称，就可以在JS通过这个名称发送消息：
        // window.webkit.messageHandlers.AppModel.postMessage({body: 'xxx'})
        configuretion.userContentController.add(self, name: "AppModel")
        self.webview = WKWebView(frame: CGRect(x:0, y:0,width:self.view.frame.width, height:self.view.frame.height), configuration: configuretion)
        
        self.webview.navigationDelegate = self
        self.webview.uiDelegate = self
        //添加wkwebview
        self.view.addSubview(webview)
        
        let htmlpath=URL.init(fileURLWithPath: Bundle.main.path(forResource: "index", ofType: "html")!)
        webview.loadFileURL(htmlpath, allowingReadAccessTo: htmlpath)
       
    
        
        self.progBar = UIProgressView(progressViewStyle: .default)
        self.progBar.frame.size.width = self.view.frame.size.width
        self.progBar.backgroundColor = UIColor.red
        self.view.addSubview(self.progBar)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "上一个页面", style: .done, target: self, action: #selector(previousPage))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一个页面", style: .done, target: self, action: #selector(nextPage))
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.navigationItem.title = self.webview.title
    }
    
    
    func previousPage() {
        if self.webview.canGoBack {
            self.webview.goBack()
        }
    }
    
    func nextPage() {
        if self.webview.canGoForward {
            self.webview.goForward()
        }
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

    // MARK: - WKScriptMessageHandler
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
  
        // 如果在开始时就注入有很多的名称，那么我们就需要区分来处理
        if message.name == "AppModel" {
            print("message name is AppModel")
           let x = message.body as! Dictionary<String,AnyObject>
           print(x)
            if let code = x["body"] as? Dictionary<String,AnyObject> {
                let result = code["qq"]
                // do something
                print(result)
            }
            //JSONSerialization.jsonObject(with: <#T##Data#>, options: JSONSerialization.ReadingOptions)
         // let dict = try JSONSerialization.JSONObjectWithData(message.body.dataUsingEncoding(NSUTF8StringEncoding)!,options:JSONSerialization.ReadingOptions.AllowFragments) as! [String : AnyObject]
           // let tempArr2 = (message.body) as! NSDictionary
           // print(tempArr2[1])
        }
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "loading" {
            print("loading")
        } else if keyPath == "title" {
            self.title = self.webview.title
        } else if keyPath == "estimatedProgress" {
            print(webview.estimatedProgress)
            self.progBar.setProgress(Float(webview.estimatedProgress), animated: true)
        }
        
        // 已经完成加载时，我们就可以做我们的事了
        if !webview.isLoading {
            // 手动调用JS代码
            let js = "callJsAlert()";
            self.webview.evaluateJavaScript(js) { (_, _) -> Void in
                print("call js alert")
            }
            
            UIView.animate(withDuration: 0.55, animations: { () -> Void in
                self.progBar.alpha = 0.0;
            })
        }
        
    }
    func webView(webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: "Tip", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) -> Void in
            // We must call back js
            completionHandler()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: "Tip", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) -> Void in
            // 点击完成后，可以做相应处理，最后再回调js端
            completionHandler(true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) -> Void in
            // 点击取消后，可以做相应处理，最后再回调js端
            completionHandler(false)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        let alert = UIAlertController(title: prompt, message: defaultText, preferredStyle: .alert)
        
        alert.addTextField { (textField: UITextField) -> Void in
            textField.textColor = UIColor.red
        }
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) -> Void in
            // 处理好之前，将值传到js端
            completionHandler(alert.textFields![0].text!)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func webViewDidClose(_ webView: WKWebView) {
        print(#function)
    }
    
}
