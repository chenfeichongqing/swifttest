//
//  HeadView.swift
//  Swfit之QQ
//
//  Created by HuJiazhou on 16/7/30.
//  Copyright © 2016年 HuJiazhou. All rights reserved.
//

import UIKit
import SnapKit

@objc protocol TouxiangDelegate{
    @objc optional func choicetouxiang()
}

class HeadView: UIView {
    
    var nameimage = UIImageView()
    
    weak var delegate:TouxiangDelegate?
    
    override init(frame: CGRect) {
    
        super.init(frame: frame)
        
        let imgeview1 = UIImageView(image: UIImage(named: "sidebar_bg"))
        imgeview1.frame  = CGRect(x:0,y: 0,width: self.frame.size.width,height: KSCREEN.height*0.4)
        
        self.addSubview(imgeview1)
  
        //头像
        nameimage.image = UIImage(named: "123")
        nameimage.layer.cornerRadius = 25
        nameimage.layer.masksToBounds = true
        nameimage.layer.borderWidth = 0.1
        nameimage.layer.borderColor = UIColor.orange.cgColor
        //为头像添加点击事件
        nameimage.isUserInteractionEnabled=true
        let userIconActionGR = UITapGestureRecognizer()
        userIconActionGR.addTarget(self, action: #selector(choicetouxiang))
        nameimage.addGestureRecognizer(userIconActionGR)
        
        self.addSubview(nameimage)

        
        nameimage.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(60)
            make.left.equalTo(self).offset(30)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        
        //QQ名称
        
        let namelable = UILabel()
        
        namelable.text = "安全管理员"
        
        namelable.font = UIFont.boldSystemFont(ofSize: 16)
        
        self.addSubview(namelable)
        
        namelable.snp.makeConstraints { (make) -> Void in
            
            make.top.equalTo(self).offset(60)
            make.left.equalTo(nameimage).offset(60)
            make.height.equalTo(25)
        }
        
        //二维码
        
        let erweima = UIImageView()
        
        erweima.image = UIImage(named:"sidebar_ QRcode_normal")
        
        self.addSubview(erweima)
        
        erweima.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(60)
            make.left.equalTo(namelable).offset(100)
            make.height.equalTo(30)
            make.width.equalTo(30)
            
        }

    }

    func choicetouxiang(){
        self.delegate?.choicetouxiang!()
        
    }


   required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }

}
