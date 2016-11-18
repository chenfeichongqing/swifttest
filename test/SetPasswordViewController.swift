//
//  SetPasswordViewController.swift
//  test
//
//  Created by 陈小爷 on 2016/11/16.
//  Copyright © 2016年 陈小爷. All rights reserved.
//

import UIKit

class SetPasswordViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "密码设置"
        setNavBar()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setNavBar() {
        
        let leftBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self,
                                         action: #selector(backToPrevious))
        self.navigationItem.leftBarButtonItem = leftBarBtn
        
    }
    
    //返回按钮点击响应
    func backToPrevious(){
        self.dismiss(animated: true) { () -> Void in
        }
    }
    
}
