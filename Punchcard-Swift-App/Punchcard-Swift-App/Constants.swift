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
    static let tabBarBackground = UIColor(red: 0.20, green: 0.21, blue: 0.22, alpha: 1.0)
    static let lightGrayBackground = UIColor(red: 0.45, green: 0.45, blue: 0.45, alpha: 1)
    static let darkGrayBackground = UIColor(red: 0.33, green: 0.33, blue: 0.33, alpha: 1)
    static let cyan = UIColor(red: 0.22, green: 0.90, blue: 0.68, alpha: 1)
    static let gold = UIColor(red: 1, green: 0.64, blue: 0, alpha: 1)
    static let buttonNormal = UIColor(red: 0.22, green: 0.90, blue: 0.68, alpha: 1)
    static let buttonSelected = UIColor(red: 0.78, green: 0.87, blue: 0.98, alpha: 1.0)
}
