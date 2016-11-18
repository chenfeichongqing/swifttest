//
//  Global.swift
//  test
//
//  Created by 陈小爷 on 2016/11/2.
//  Copyright © 2016年 陈小爷. All rights reserved.
//

import Foundation

func isIPhone4() -> Bool {
    return UIScreen.main.currentMode?.size == CGSize(width:640, height:960)
}
func isIPhone5() -> Bool {
    return UIScreen.main.currentMode?.size == CGSize(width:640, height:1136)
}
func isIPhone6() -> Bool {
    return UIScreen.main.currentMode?.size == CGSize(width:750, height:1334)
}
func isIPhone6Plus() -> Bool {
    return UIScreen.main.currentMode?.size == CGSize(width:1242, height:2208)
}
func isIPhone6PlusBigMode() -> Bool {
    return UIScreen.main.currentMode?.size == CGSize(width:1125, height:2001)
}


func currentLanguage() -> String {
    return NSLocale.preferredLanguages.first!
}

func systemVersion() -> String {
    return UIDevice.current.systemVersion
}

func appVersion() -> String {
    return String(describing: Bundle.main.infoDictionary!["CFBundleShortVersionString"]!)
}


extension UIColor {
    public convenience init(hexString: UInt32, alpha: CGFloat = 1.0) {
        let red     = CGFloat((hexString & 0xFF0000) >> 16) / 255.0
        let green   = CGFloat((hexString & 0x00FF00) >> 8 ) / 255.0
        let blue    = CGFloat((hexString & 0x0000FF)      ) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension UITableViewDataSource {
    // return total rows in the tableView
    func totalRows(tableView: UITableView) -> Int {
        let totalSections = self.numberOfSections!(in: tableView)
        var section = 0, total = 0
        while section < totalSections {
            total += self.tableView(tableView, numberOfRowsInSection: section)
            section += 1
        }
        return total
    }
}
