//
//  AllPlacesTableViewController.swift
//  Punchcard-Swift-App
//
//  Created by Gabriele Pregadio on 2/2/17.
//  Copyright © 2017 Super Slo Brothers. All rights reserved.
//

import UIKit
import CoreLocation
import ReSwift
import MCSwipeTableViewCell
import DZNEmptyDataSet

class AllPlacesTableViewController: UITableViewController, StoreSubscriber, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource, CLLocationManagerDelegate {
    
    // MARK: - Stored properties
    
    var testPlaces = [Business]()
    private var locationManager: CLLocationManager!
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "All Places"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "All Places", style: .plain, target: nil, action: nil)
        
        tableView.backgroundColor = Colors.darkGrayBackground
        tableView.separatorColor = Colors.gold
        tableView.emptyDataSetDelegate = self
        tableView.emptyDataSetSource = self
        // Removes cell separators when table view is empty.
        tableView.tableFooterView = UIView()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.subscribe(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if CLLocationManager.authorizationStatus() == .denied {
//            presentRequestLocationServicesAlertController()
        }
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
        cell.backgroundColor = Colors.darkGrayBackground
        cell.textLabel?.text = business.name
        cell.textLabel?.textColor = UIColor.white
        cell.detailTextLabel?.text = business.address
        cell.detailTextLabel?.textColor = Colors.cyan
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = storyboard!.instantiateViewController(withIdentifier: StoryboardIdentifiers.placeDetail.rawValue) as! PlaceDetailViewController
        vc.place = testPlaces[indexPath.row]
        navigationController!.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Dimensions.cellRowHeigh
    }
    
    
    // MARK: - Empty data set data source
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(
            string: Constants.noNearbyPlacesMessage,
            attributes: [
                NSFontAttributeName: UIFont.boldSystemFont(ofSize: 30.0),
                NSForegroundColorAttributeName: UIColor.white
            ]
        )
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(
            string: Constants.noNearbyPlacesDetailedMessage,
            attributes: [
                NSFontAttributeName: UIFont.boldSystemFont(ofSize: 17.0),
                NSForegroundColorAttributeName: UIColor.white
            ]
        )
    }
    
    
    // MARK: - CLLocationManager delegate
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("locationManager(_:didChangeAuthorization:) called.")
        switch status {
        case .authorizedWhenInUse:
            locationManager.startMonitoringSignificantLocationChanges()
            createTestPlaces()
            tableView.reloadData()
        case .denied:
            testPlaces.removeAll()
            tableView.reloadData()
            presentRequestLocationServicesAlertController()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Location significantly changed.
        print("locationManager(_:didUpdateLocations:) called.")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Some shit went down.
        print("locationManager(_:didFailWithError:) called.")
    }
    
    
    // MARK: - Supporting functionality
    
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
        testPlaces = [aBusiness, anotherBusiness]
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
    
    enum Cells: String {
        case place
    }
    
    struct Dimensions {
        static let cellRowHeigh: CGFloat = 60
    }
    
    struct Constants {
        static let noNearbyPlacesMessage = "No places nearby."
        static let noNearbyPlacesDetailedMessage = "Our app sucks and nobody near you uses it... Or you didn't allow us to know your location"
    }
    
}
