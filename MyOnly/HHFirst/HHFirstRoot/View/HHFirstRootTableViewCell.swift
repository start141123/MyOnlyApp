//
//  HHFirstRootTableViewCell.swift
//  MyOnly
//
//  Created by mac on 2017/11/3.
//  Copyright © 2017年 macZh. All rights reserved.
//

import UIKit

class HHFirstRootTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.randomColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
