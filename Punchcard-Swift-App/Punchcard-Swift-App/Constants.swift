//
//  Constants.swift
//  Punchcard-Swift-App
//
//  Created by Gabriele Pregadio on 2/2/17.
//  Copyright © 2017 Super Slo Brothers. All rights reserved.
//

import Foundation
import UIKit

enum StoryboardIdentifiers: String {
    case allPlaces, placeDetail, punch, myOfferInstances, myOfferInstancesDetail, loginVC
}

struct Colors {
    static let tabBarBackground = UIColor(red: 0.2, green: 0.21, blue: 0.22, alpha: 1.0)
    static let lightGrayBackground = UIColor(red: 0.45, green: 0.45, blue: 0.45, alpha: 1.0)
    static let darkGrayBackground = UIColor(red: 0.33, green: 0.33, blue: 0.33, alpha: 1.0)
    static let cyan = UIColor(red: 0.22, green: 0.9, blue: 0.68, alpha: 1.0)
    static let gold = UIColor(red: 1.0, green: 0.64, blue: 0, alpha: 1.0)
    static let buttonNormalBackground = UIColor(red: 0.22, green: 0.9, blue: 0.68, alpha: 1.0)
    static let buttonDisabledBackground = UIColor(red: 0.29, green: 0.58, blue: 0.48, alpha: 1.0)
    static let buttonSelectedText = UIColor(red: 0.78, green: 0.87, blue: 0.98, alpha: 1.0)
    static let buttonDisabledText = UIColor(red: 0.51, green: 0.7, blue: 0.63, alpha: 1)
    static let progressOrange = UIColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0)
    static let progressBlue = UIColor(red: 0.25, green: 0.5, blue: 0.5, alpha: 1.0)
    static let progressComplete = UIColor(red: 0.07, green: 1.0, blue: 0, alpha: 1.0)
}
