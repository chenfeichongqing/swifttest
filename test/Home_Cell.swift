//
//  Home_Cell.swift
//  test
//
//  Created by 陈小爷 on 2016/10/25.
//  Copyright © 2016年 陈小爷. All rights reserved.
//

import UIKit
import SnapKit

class Home_Cell: UICollectionViewCell {
    let width = UIScreen.main.bounds.size.width//获取屏幕宽
    var imgView : UIImageView?//cell上的图片
    var titleLabel:UILabel?//cell上title
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        //初始化各种控件
        //设置每一个cell的宽高
        var cellwidth:Int
        if(isIPhone5()){
            cellwidth=75
        }
        else if (isIPhone6()) {
            cellwidth=88
            
        }
        else if(isIPhone6Plus()){
            cellwidth=98
        }
        else{
            cellwidth=70
            
        }
        imgView = UIImageView(frame: CGRect(x:10, y:6, width:cellwidth-20, height:cellwidth-20))
        titleLabel?.isEqual(imgView)
        titleLabel = UILabel(frame: CGRect(x:10, y:Int(imgView!.frame.maxY+5), width:cellwidth-20, height:15))
        titleLabel?.numberOfLines = 1
        titleLabel?.textAlignment = NSTextAlignment.center
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 13.0)
        titleLabel?.textColor = UIColor.lightGray
        self.addSubview(imgView!)
        self.addSubview(titleLabel!)

        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
