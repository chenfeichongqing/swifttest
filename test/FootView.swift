//
//  FootView.swift
//  Swfit之QQ
//
//  Created by HuJiazhou on 16/7/30.
//  Copyright © 2016年 HuJiazhou. All rights reserved.
//

import UIKit

class FootView: UIView {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        
        self.backgroundColor = UIColor.clear
        let button1 =  button(widthX: 0, name:"sidebar_setting", titile: "  设置")
        let button2 =  button(widthX: 96, name: "sidebar_nightmode_on", titile: "  夜间")
        
        addSubview(button1)
        addSubview(button2)
        

        
        
    }
    func button(widthX X:CGFloat ,name image:String, titile ti:String) ->UIButton{
        
        let button = UIButton()
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.frame = CGRect( x: X , y: 0 , width: 48*2 , height: 48)
        button.setTitle(ti, for: UIControlState())
        button.setImage(UIImage(named: image), for: UIControlState())
   
        return button
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
   
}





