//
//  AllPlacesVC+Tests.swift
//  Punchcard-Swift-App
//
//  Created by Gabriele Pregadio on 2/8/17.
//  Copyright © 2017 Super Slo Brothers. All rights reserved.
//

import UIKit

extension AllPlacesTableViewController {
    
    func createTestPlaces() {
        var aBusiness = Business()
        aBusiness.name = "Tyrone's Pizza Shack"
        aBusiness.address = "69 Street"
        aBusiness.city = "Mountain View"
        aBusiness.state = "CA"
        aBusiness.zipcode = "94040"
        aBusiness.latitude = "37.3861"
        aBusiness.longitude = "-122.0839"
        aBusiness.offerSet = [
            Offer(withDescription: "Buy 69 pizzas and get kicked out of the store", punchesRequired: 6),
            Offer(withDescription: "Buy one pizza, get ten free", punchesRequired: 4)
        ]
        var anotherBusiness = Business()
        anotherBusiness.name = "Krusty Krab"
        anotherBusiness.address = "1234 Ocean Avenue"
        anotherBusiness.city = "Bikini Bottom"
        anotherBusiness.state = "TX"
        anotherBusiness.zipcode = "69696"
        anotherBusiness.latitude = "34.0522"
        anotherBusiness.longitude = "-118.2437"
        anotherBusiness.offerSet = [
            Offer(withDescription: "Buy ten krabby patties, get one free", punchesRequired: 10)
        ]
        businesses = [aBusiness, anotherBusiness]
    }
    
    func presentRequestLocationServicesAlertController() {
        let ac = UIAlertController(title: "Location services disabled", message: "In order to look for nearby places using our app, you must re-enable location services.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "Settings", style: .default) { _ in
            guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else { return }
            guard UIApplication.shared.canOpenURL(settingsUrl) else { return }
            UIApplication.shared.open(settingsUrl)
        })
        present(ac, animated: true)
    }

}
