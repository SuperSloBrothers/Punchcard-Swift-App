//
//  PunchcardDataActions.swift
//  Punchcard-Swift-App
//
//  Created by Gabriele Pregadio on 2/1/17.
//  Copyright © 2017 Super Slo Brothers. All rights reserved.
//

import Foundation
import ReSwift

// this file should not exist once all the following actions are in their respective files

struct RedeemOfferInstance: Action {
    var offerId: Int
    var offerInstanceId: Int
}

struct UpdateParticipatingLocations: Action { }

struct UpdateUserInfo: Action {
    var updatedEmailAddress: String
}
