//
//  CustomOfferTableViewCells.swift
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

}

class MatchingOfferTableViewCell: MCSwipeTableViewCell {
    
    @IBOutlet weak var progressImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
}
