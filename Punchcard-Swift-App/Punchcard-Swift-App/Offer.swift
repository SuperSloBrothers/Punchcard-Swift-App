//
//  Offer.swift
//  Punchcard-Swift-App
//
//  Created by Gabriele Pregadio on 2/1/17.
//  Copyright © 2017 Super Slo Brothers. All rights reserved.
//

import Foundation
import ObjectMapper

struct Offer: Mappable {
    
    var id: Int!
    var url: String!
    var description: String!
    var business: String!
    var totalPunchesRequired: Int!
    var maxInstancesAllowed: Int!
    var isActive: Bool!
    var createdOn: String!
    var updatedOn: String!
    
    // Init for testing purposes.
    init(withDescription description: String, punchesRequired: Int) {
        self.description = description
        self.totalPunchesRequired = punchesRequired
    }
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        id                      <- map["id"]
        url                     <- map["url"]
        description             <- map["description"]
        business                <- map["business"]
        totalPunchesRequired    <- map["punch_total_required"]
        maxInstancesAllowed     <- map["max_instances"]
        isActive                <- map["active"]
        createdOn               <- map["created_on"]
        updatedOn               <- map["updated_on"]
    }
    
}
