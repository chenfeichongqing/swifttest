//
//  MainClassicalCell.swift
//  test
//
//  Created by 陈小爷 on 2016/11/9.
//  Copyright © 2016年 陈小爷. All rights reserved.
//

import UIKit

class MainClassicalCell: UITableViewCell {
    
    var showImage   : UIImageView?
    var firstTitle  : UILabel?
    var subTitle    : UILabel?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI()
    }
    
    func setUpUI() {
        showImage = UIImageView.init(frame: CGRect(x:20, y:20, width:50, height:50))
        showImage!.layer.masksToBounds = true
        self.addSubview(showImage!)
        
        subTitle = UILabel.init(frame: CGRect(x:10, y:20, width:(showImage?.frame.size.width)!-20, height:12))
        subTitle?.font = UIFont.systemFont(ofSize: 15)
        subTitle?.textAlignment = NSTextAlignment.center
        subTitle?.textColor = UIColor.red
        self.addSubview(subTitle!)
        
        firstTitle = UILabel.init(frame: CGRect(x:10, y:(subTitle?.frame)!.minY-38, width:(subTitle?.frame.size.width)!,height: 30))
        firstTitle?.font = UIFont.systemFont(ofSize: 18)
        firstTitle?.textAlignment = NSTextAlignment.center
        firstTitle?.textColor = UIColor.blue
        self.addSubview(firstTitle!)
    }
    
    func setValueForCell(dic: NSDictionary) {
        subTitle!.text = "45道菜谱"
        firstTitle!.text = "世界各地大排档的招牌美食"
        showImage!.image = UIImage(named: "img.jpg")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

