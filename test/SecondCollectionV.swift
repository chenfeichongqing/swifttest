//
//  SecondCollectionV.swift
//  test
//
//  Created by 陈小爷 on 2016/11/11.
//  Copyright © 2016年 陈小爷. All rights reserved.
//

import UIKit

class SecondCollectionV: UICollectionView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
 //   var  data:[Dictionary<String, String>] = []

    let data = [
        
        ["name":"隐患排查","pic":"5"],
        ["name":"异常排序","pic":"6"],
        ["name":"燃油补贴","pic":"7"],
        ["name":"事故处理","pic":"8"],
        ["name":"事故报告","pic":"9"],
        ]
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        
        let layout = UICollectionViewFlowLayout()
        let rows = Int(data.count/3)
        var cellheight:Int
        var cellwidth:Int
        
        //设置每一个cell的宽高
        if(isIPhone5()){
            cellwidth=70
            cellheight=90
        }
        else if (isIPhone6()) {
            cellwidth=80
            cellheight=100
            
        }
        else if(isIPhone6Plus()){
            cellwidth=90
            cellheight=110
        }
        else{
            cellwidth=70
            cellheight=90
            
        }
        layout.itemSize = CGSize(width:cellwidth, height:cellheight)
        //滑动方向 默认方向是垂直
        layout.scrollDirection = .vertical
        //每个Item之间最小的间距
        layout.minimumInteritemSpacing = 0
        //每行之间最小的间距
        layout.minimumLineSpacing = 0
        super.init(frame: CGRect(x:0, y:KSCREEN.width/2+64+50+200, width:KSCREEN.width, height:CGFloat(rows*cellheight)), collectionViewLayout: layout)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    //返回多少个cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
                   return data.count
          }
    //返回自定义的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mycell", for: indexPath as IndexPath) as! testCell
                cell.gongneng.setImage(UIImage(named: data[indexPath.item]["pic"]!), for: .normal)
               cell.gongneng.setTitle(data[indexPath.item]["name"], for: .normal)
           return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }

}
