//
//  StatusCode.swift
//  Punchcard-Swift-App
//
//  Created by Gabriele Pregadio on 2/8/17.
//  Copyright © 2017 Super Slo Brothers. All rights reserved.
//

import Foundation

enum StatusCode: Int {
    case ok = 200
    case punchSuccessful = 201
    case punchUnsuccessful = 400
    case invalidOfferID = 404
}
