//
//  PunchcardDataActions.swift
//  Punchcard-Swift-App
//
//  Created by Gabriele Pregadio on 2/1/17.
//  Copyright © 2017 Super Slo Brothers. All rights reserved.
//

import Foundation
import ReSwift

struct SubmitPunch: Action {
    var userId: Int
    // TODO: - is "id" field of api/punches connected to the QR code? if not, how to get/generate it?
    var qrCode: String
    var timestamp: String
    var offerId: Int
    var offerInstanceId: Int
}

struct RedeemOffer: Action {
    var offerId: Int
    var offerInstanceId: Int
}

struct UpdateParticipatingLocations: Action { }

struct UpdateUserInfo: Action {
    var updatedEmailAddress: String
}
