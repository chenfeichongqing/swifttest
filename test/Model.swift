//
//  Model.swift
//  test
//
//  Created by 陈小爷 on 2016/11/11.
//  Copyright © 2016年 陈小爷. All rights reserved.
//
import UIKit

let width = UIScreen.main.bounds.size.width
let widthCell = (width - 10.0 * 3) / 2
let heightHeader:CGFloat = 30.0
let heightFooter:CGFloat = 20.0
let heightCell:CGFloat = 80.0

class Model: NSObject {
    
    var text:String!
    
    override init() {
        super.init()
    }
    
}
