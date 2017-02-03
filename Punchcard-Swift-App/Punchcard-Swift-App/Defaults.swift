//
//  Defaults.swift
//  Punchcard-Swift-App
//
//  Created by Amir Saifi on 2/3/17.
//  Copyright © 2017 Super Slo Brothers. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

// see usage at https://github.com/radex/SwiftyUserDefaults
extension DefaultsKeys {
    static let apiToken = DefaultsKey<String?>("punchApiToken")
}
