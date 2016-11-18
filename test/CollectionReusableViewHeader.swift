//
//  CollectionReusableViewHeader.swift
//  test
//
//  Created by 陈小爷 on 2016/11/11.
//  Copyright © 2016年 陈小爷. All rights reserved.
//

import UIKit

let headerIdentifier = "CollectionReusableViewHeader"

class CollectionReusableViewHeader: UICollectionReusableView {
    
   // var bgview:UIView!
    var label:UILabel!
    //var  title :String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    //    self.bgview = UIView.init(frame: CGRect(x:0, y:0, width:KSCREEN.width, height:40))
    //    bgview.backgroundColor=#colorLiteral(red: 0.9027998096, green: 0.9027998096, blue: 0.9027998096, alpha: 1)
        self.label = UILabel.init(frame: CGRect(x:10, y:0+5, width:KSCREEN.width, height:20))
     //   label.text=title
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        label.textColor=#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
      //  self.addSubview(self.bgview)
        self.addSubview(self.label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
