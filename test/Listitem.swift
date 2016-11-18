//
//  Listitem.swift
//  test
//
//  Created by 陈小爷 on 2016/11/9.
//  Copyright © 2016年 陈小爷. All rights reserved.
//

import UIKit
import RealmSwift

class Listitem: Object {
    
    dynamic var name = ""
    dynamic var title = ""
    dynamic var imageview: NSData? = nil // optionals supported
    dynamic var datetime = NSDate(timeIntervalSince1970: 1)

}
