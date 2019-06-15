//
//  CheckTableViewCell.swift
//  CheckTableSample
//
//  Created by Masuhara on 2019/06/15.
//  Copyright © 2019 Ylab Inc. All rights reserved.
//

import UIKit
import BEMCheckBox

class CheckTableViewCell: UITableViewCell {
    
    @IBOutlet var checkBox: BEMCheckBox!
    @IBOutlet var sampleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        checkBox.boxType = .square
        checkBox.animationDuration = 0.1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
