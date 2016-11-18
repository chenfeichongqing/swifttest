//
//  Anquanhuodong+CoreDataProperties.swift
//  test
//
//  Created by 陈小爷 on 2016/11/8.
//  Copyright © 2016年 陈小爷. All rights reserved.
//

import Foundation
import CoreData


extension Anquanhuodong {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Anquanhuodong> {
        return NSFetchRequest<Anquanhuodong>(entityName: "Anquanhuodong");
    }

    @NSManaged public var id: Int32
    @NSManaged public var image: NSData?
    @NSManaged public var time: NSDate?
    @NSManaged public var title: String?
    @NSManaged public var url: String?

}
