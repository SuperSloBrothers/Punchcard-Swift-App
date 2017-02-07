//
//  CurrentOfferTableViewCell.swift
//  Punchcard-Swift-App
//
//  Created by Gabriele Pregadio on 2/6/17.
//  Copyright © 2017 Super Slo Brothers. All rights reserved.
//

import UIKit
import MCSwipeTableViewCell

class CurrentOfferTableViewCell: MCSwipeTableViewCell {

    @IBOutlet weak var punchCountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
