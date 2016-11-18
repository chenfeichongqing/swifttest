//
//  CollectionReusableViewFooter.swift
//  test
//
//  Created by 陈小爷 on 2016/11/11.
//  Copyright © 2016年 陈小爷. All rights reserved.
//
import UIKit

let footerIdentifier = "CollectionReusableViewFooter"

class CollectionReusableViewFooter: UICollectionReusableView {
    
    var label:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.label = UILabel(frame: CGRect(x:10.0, y:0.0, width:(self.bounds.width - 10.0 * 2), height:heightFooter))
        self.addSubview(self.label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
