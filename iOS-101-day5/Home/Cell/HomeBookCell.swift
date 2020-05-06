//
//  HomeBookCell.swift
//  iOS-101-day5
//
//  Created by Guang Lei on 2020/5/5.
//  Copyright © 2020 Guang Lei. All rights reserved.
//

import UIKit
import Kingfisher

class HomeBookCell: UITableViewCell {

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookAuthorLabel: UILabel!

    func configure(model: HomeBookCellModel) {
        bookImageView.kf.setImage(with: model.image)
        bookTitleLabel.text = model.title
        bookAuthorLabel.text = model.author.joined(separator: ", ")
    }
}
