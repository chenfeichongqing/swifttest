//
//  UitableviewCellTableViewCell.swift
//  test
//
//  Created by 陈小爷 on 2016/11/9.
//  Copyright © 2016年 陈小爷. All rights reserved.
//

import UIKit

class UitableviewCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var touxiang: UIImageView!
       override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
