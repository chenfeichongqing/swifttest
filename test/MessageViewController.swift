//
//  MessageViewController.swift
//  xQQ
//
//  Created by 方武显 on 15/3/9.
//  Copyright (c) 2015年 小五哥Swift教程. All rights reserved.
//

import UIKit
class MessageViewController: UIViewController {
    //
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //左侧显示头像
      /*  let photoView:UIImageView=UIImageView(image: UIImage(named: "AppIcon-160x60@2x.png"))
        photoView.frame=CGRect(x: 0, y: 0, width: 30, height: 30)
        let photoItem:UIBarButtonItem=UIBarButtonItem(customView: photoView)
        self.navigationItem.leftBarButtonItem=photoItem
        //头像变圆形(设弧度为宽度的一半)
        photoView.clipsToBounds=true
        photoView.layer.cornerRadius=photoView.bounds.width*0.5  */
   
        let titleSegment=UISegmentedControl(items: ["待处理", "记录"])
        titleSegment.selectedSegmentIndex=0
        self.navigationItem.titleView=titleSegment
        
        let rightButton:UIButton=UIButton()
        rightButton.frame=CGRect(origin:CGPoint.zero, size: CGSize(width: 26, height: 26))
        rightButton.setBackgroundImage(UIImage(named: "tab_qworld_nor.png"), for: UIControlState());
        let rightItem:UIBarButtonItem=UIBarButtonItem(customView: rightButton)
        self.navigationItem.rightBarButtonItem=rightItem
        //
    }
    
  
}
