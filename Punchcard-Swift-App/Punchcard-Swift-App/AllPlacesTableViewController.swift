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

class AllPlacesTableViewController: UITableViewController, StoreSubscriber, CLLocationManagerDelegate {
    
    // MARK: - Stored properties
    
    var businesses = [Business]()
    var locationManager: CLLocationManager!
    var authorizationStatus: CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    var businessesAreLoading = false
    var loadingError: Error?
    
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Store subscriber
    
    func newState(state: RootState) {
        guard authorizationStatus != .denied else { return }
        
        if let businessResult = state.punchcardData.nearbyBusinesses {
            switch businessResult {
            case .Success(let businesses):
                businessesAreLoading = false
                loadingError = nil
                self.businesses = businesses
                tableView.reloadData()
            case .Failure(let error):
                businessesAreLoading = false
                loadingError = error
                tableView.reloadEmptyDataSet()
            case .Loading():
                businessesAreLoading = true
                loadingError = nil
                tableView.reloadEmptyDataSet()
            }
        }
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.place.rawValue, for: indexPath) as! MCSwipeTableViewCell
        let business = businesses[indexPath.row]
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
        vc.place = businesses[indexPath.row]
        navigationController!.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Dimensions.cellRowHeigh
    }
    
    
    // MARK: - CLLocationManager delegate
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            locationManager.startMonitoringSignificantLocationChanges()
            store.dispatch(getBusinesses())
        case .denied:
            businesses.removeAll()
            tableView.reloadData()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locationManager(_:didUpdateLocations:) called.")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("locationManager(_:didFailWithError:) called.")
        if let clError = error as? CLError {
            if clError.code == .denied {
                manager.stopMonitoringSignificantLocationChanges()
            }
        }
    }
    
    
    // MARK: - Supporting functionality
    
    enum Cells: String {
        case place
    }
    
    struct Dimensions {
        static let cellRowHeigh: CGFloat = 60
    }
    
    struct Messages {
        static let loadingBusinesses = "Loading nearby businesses..."
        static let errorLoading = "Loading Error"
        static let noNearbyPlaces = "No places nearby."
        static let noNearbyPlacesDetailed = "Our app sucks and nobody near you uses it."
        static let locationServicesDisabled = "Location services are disabled."
        static let locationServicesDisabledDetailed = "We need to know your location to show you nearby places with offers available."
        static let settingsButtonTitle = "Go to Settings"
    }
    
}
