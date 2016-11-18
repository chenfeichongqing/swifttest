//
//  mainView.swift
//  Swfit之QQ
//
//  Created by HuJiazhou on 16/7/30.
//  Copyright © 2016年 HuJiazhou. All rights reserved.
//

import UIKit


class MainView: UIView {
    
    override init(frame: CGRect) {
      super.init(frame: frame)
        
        self.window?.backgroundColor=UIColor(red: 13/255, green: 184/255, blue: 246/255, alpha: 1)
        print(KSCREEN.width)
        print(KSCREEN.height)
        
       let headview:HeadView = HeadView(frame: CGRect.init(x:0, y:0, width: KSCREEN.width-48, height: KSCREEN.height*0.5 - 60))
        
        let footview:FootView = FootView(frame: CGRect.init(x:0, y: KSCREEN.height-48, width: KSCREEN.width-48, height: 48))
        
        let letView:LeftTabelView = LeftTabelView(frame: CGRect(x:0, y: KSCREEN.height*0.5 - 60, width: KSCREEN.width-48, height: KSCREEN.height*0.6 - 48), style: UITableViewStyle.plain)
        

        addSubview(headview)
        addSubview(letView) 
        addSubview(footview)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

        
    

}
