//
//  PunchcardDataState.swift
//  Punchcard-Swift-App
//
//  Created by Gabriele Pregadio on 1/31/17.
//  Copyright © 2017 Super Slo Brothers. All rights reserved.
//

import Foundation
import ReSwift

struct PunchcardDataState {
    var jwt: String?
    var offerInstances: [OfferInstance]
    var nearbyBusinesses: [Business]
}
