//
//  Business.swift
//  Punchcard-Swift-App
//
//  Created by Gabriele Pregadio on 1/31/17.
//  Copyright © 2017 Super Slo Brothers. All rights reserved.
//

import Foundation
import ObjectMapper

struct Business: Mappable {
    
    var id: Int!
    var url: String!
    var name: String!
    var phone: String!
    var link: String?
    var address: String!
    var city: String!
    var state: String!
    var zipcode: String!
    var latitude: String!
    var longitude: String!
    var createdOn: String!
    var updatedOn: String!
    var offerSet = [Offer]()
    
    // Init for testing purposes.
    init() { }
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        id          <- map["id"]
        url         <- map["url"]
        name        <- map["name"]
        phone       <- map["phone"]
        link        <- map["link"]
        address     <- map["address"]
        city        <- map["city"]
        state       <- map["state"]
        zipcode     <- map["zipcode"]
        latitude    <- map["latitude"]
        longitude   <- map["longitude"]
        createdOn   <- map["created_on"]
        updatedOn   <- map["updated_on"]
        offerSet    <- map["offer_set"]
    }
    
}
