//
//  AllPlacesTableViewController.swift
//  Punchcard-Swift-App
//
//  Created by Gabriele Pregadio on 2/2/17.
//  Copyright © 2017 Super Slo Brothers. All rights reserved.
//

import UIKit
import ReSwift
import MCSwipeTableViewCell

class AllPlacesTableViewController: UITableViewController, StoreSubscriber {
    
    // MARK: - Stored properties
    
    var testPlaces = [Business]()
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "All Places", style: .plain, target: nil, action: nil)
        
        // Create some test places.
        var aBusiness = Business()
        aBusiness.name = "Tyrone's Pizza Shack"
        aBusiness.address = "69 Street"
        aBusiness.offerSet = [
            Offer(withDescription: "Buy 69 pizzas and get kicked out of the store"),
            Offer(withDescription: "Buy one pizza, get ten free")
        ]
        var anotherBusiness = Business()
        anotherBusiness.name = "Krusty Krab"
        anotherBusiness.address = "Bikini Bottom"
        anotherBusiness.offerSet = [
            Offer(withDescription: "Buy ten krabby patties, get one free")
        ]
        testPlaces = [aBusiness, anotherBusiness]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.subscribe(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Store subscriber
    
    func newState(state: RootState) {
        
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testPlaces.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.place.rawValue, for: indexPath) as! MCSwipeTableViewCell
        let business = testPlaces[indexPath.row]
        cell.textLabel?.text = business.name
        cell.detailTextLabel?.text = business.address
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = storyboard!.instantiateViewController(withIdentifier: StoryboardIdentifiers.placeDetail.rawValue) as! PlaceDetailViewController
        vc.place = testPlaces[indexPath.row]
        navigationController!.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.rowHeigh
    }
    
    
    // MARK: - Supporting functionality
    
    enum Cells: String {
        case place
    }
    
    struct Constants {
        static let rowHeigh: CGFloat = 60
    }
    
}
