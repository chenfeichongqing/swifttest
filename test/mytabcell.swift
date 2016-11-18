//
//  mytabcell.swift
//  test
//
//  Created by 陈小爷 on 2016/11/10.
//  Copyright © 2016年 陈小爷. All rights reserved.
//

import UIKit

class mytabcell: UITableViewCell {

    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
