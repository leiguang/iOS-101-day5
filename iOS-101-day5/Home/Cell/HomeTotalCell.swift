//
//  HomeTotalCell.swift
//  iOS-101-day5
//
//  Created by Guang Lei on 2020/5/5.
//  Copyright © 2020 Guang Lei. All rights reserved.
//

import UIKit

class HomeTotalCell: UITableViewCell {
    
    @IBOutlet weak var totalLabel: UILabel!
    
    func configure(model: HomeTotalCellModel) {
        totalLabel.text = "总数：\(model.total)"
    }
}
