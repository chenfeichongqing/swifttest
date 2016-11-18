//
//  testCell.swift
//  test
//
//  Created by 陈小爷 on 2016/11/11.
//  Copyright © 2016年 陈小爷. All rights reserved.
//

import UIKit

class testCell: UICollectionViewCell {

    @IBOutlet weak var gongneng: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        gongneng.isUserInteractionEnabled=false
    }

}
