//
//  ViewController.swift
//  test
//
//  Created by 陈小爷 on 2016/10/19.
//  Copyright © 2016年 陈小爷. All rights reserved.
//

import UIKit


let kScreenColoc = UIColor(red: 111/255, green:218/255 , blue:242/255 , alpha: 1)
let KSCREEN=UIScreen.main.bounds.size

class ViewController: UITabBarController
{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.getAddChrldControl(MainTabViewController(), title: "首页", imageName: "tab_recent")
        
        self.getAddChrldControl(MessageViewController(), title: "消息", imageName: "tab_buddy")
        
        self.getAddChrldControl(MainTabViewController(), title: "图表", imageName: "tab_qworld")

    }
    
    
    
    func getAddChrldControl(_ vc:UIViewController,title:String,imageName:String){
        
        //设置标题
        vc.title=title
       // 设置图片
        vc.tabBarItem.image=UIImage(named:"\(imageName)_nor")?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage=UIImage(named:"\(imageName)_press")?.withRenderingMode(.alwaysOriginal)
        let nav = UINavigationController(rootViewController: vc)
        addChildViewController(nav)
    }
    
}

