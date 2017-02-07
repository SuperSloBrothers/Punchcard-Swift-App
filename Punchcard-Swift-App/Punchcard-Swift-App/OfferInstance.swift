//
//  OfferInstance.swift
//  Punchcard-Swift-App
//
//  Created by Gabriele Pregadio on 1/31/17.
//  Copyright © 2017 Super Slo Brothers. All rights reserved.
//

import Foundation
import ObjectMapper

struct OfferInstance: Mappable {
    
    var id: Int!
    var url: String!
    var name: String!
    var offerId: Int!
    var business: Business!
    var user: String!
    var totalPunches: Int!
    var totalPunchesRequired: Int!
    var canBeRedeemed: Bool!
    var hasBeenRedeemed: Bool!
    var redeemedDate: String?
    var createdOn: String!
    var updatedOn: String!
    
    // Init for testing purposes.
    init() { }
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        id                      <- map["id"]
        url                     <- map["url"]
        name                    <- map["name"]
        offerId                 <- map["offer_id"]
        business                <- map["business"]
        user                    <- map["user"]
        totalPunches            <- map["punch_total"]
        totalPunchesRequired    <- map["punch_total_required"]
        canBeRedeemed           <- map["can_redeem"]
        hasBeenRedeemed         <- map["redeemed"]
        redeemedDate            <- map["redeemed_on"]
        createdOn               <- map["created_on"]
        updatedOn               <- map["updated_on"]
    }
    
}
