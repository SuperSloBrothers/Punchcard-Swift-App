//
//  PlaceDetailViewController.swift
//  Punchcard-Swift-App
//
//  Created by Gabriele Pregadio on 2/2/17.
//  Copyright © 2017 Super Slo Brothers. All rights reserved.
//

import UIKit
import MapKit
import ReSwift

class PlaceDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate, StoreSubscriber {
    
    // MARK: - IB outlets
    
    @IBOutlet weak var offersTableView: UITableView! {
        didSet {
            offersTableView.backgroundColor = Colors.lightGrayBackground
            offersTableView.rowHeight = UITableViewAutomaticDimension
            offersTableView.separatorInset = UIEdgeInsets.zero
            offersTableView.estimatedRowHeight = Dimensions.cellRowMinimumHeight
            offersTableView.separatorColor = UIColor.white
        }
    }
    
    @IBOutlet weak var placeNameLabel: UILabel! {
        didSet {
            placeNameLabel.backgroundColor = Colors.gold
            placeNameLabel.numberOfLines = 1
            placeNameLabel.textColor = UIColor.white
            placeNameLabel.font = Fonts.placeName
        }
    }
    
    @IBOutlet weak var placeAddressLabel: UILabel! {
        didSet {
            placeAddressLabel.numberOfLines = 2
            placeAddressLabel.textColor = Colors.cyan
            placeAddressLabel.font = Fonts.placeAddress
        }
    }
    
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.showsUserLocation = true
        }
    }
    
    
    // MARK: - Stored properties
    
    var place: Business!
    private var myActiveOfferInstances = [OfferInstance]()
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.darkGrayBackground
        
        placeNameLabel.text = " \(place.name!)"
        placeAddressLabel.text = " \(place.address!)\n \(place.city!), \(place.state!) \(place.zipcode!)"
        
        formatMap()
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
    
    
    // MARK: - StoreSubscriber
    
    func newState(state: RootState) {
        if let myActiveOfferInstances = state.punchcardData.offerInstances?.value {
            self.myActiveOfferInstances = myActiveOfferInstances
            offersTableView.reloadData()
        }
    }
    
    
    // MARK: - Helper methods
    
    func formatMap() {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(
            place.location.coordinate,
            MapDimensions.initialRegionRadius,
            MapDimensions.initialRegionRadius
        )
        mapView.setRegion(coordinateRegion, animated: false)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = place.location.coordinate
        mapView.addAnnotation(annotation)
    }
    
    func createAttributedString(forPunchTotal punchCount: Int) -> NSAttributedString {
        let attributedPunchText = NSMutableAttributedString(
            string: "\(punchCount)",
            attributes: [
                NSFontAttributeName: Fonts.punchCount,
                NSForegroundColorAttributeName: UIColor.white
            ]
        )
        attributedPunchText.append(NSAttributedString(
            string: "\npunches",
            attributes: [
                NSFontAttributeName: Fonts.punches,
                NSForegroundColorAttributeName: UIColor.white
            ]
        ))
        return attributedPunchText
    }
    
    
    // MARK: Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return place.offerSet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: - Find a better way to know if you're currently participating in one of this place's offers... use reswift duh
        // TODO: - Why are some offer's names empty on here but not on the server?
        let offer = place.offerSet[indexPath.row]
        if myActiveOfferInstances.contains(where: { $0.name == offer.name }) {
            let cell = tableView.dequeueReusableCell(withIdentifier: Cells.matchingOffer.rawValue, for: indexPath) as! MatchingOfferTableViewCell
            
            cell.accessoryType = .disclosureIndicator
            cell.backgroundColor = Colors.lightGrayBackground
            
            cell.descriptionLabel.text = offer.name!
            cell.descriptionLabel.font = Fonts.offerDescription
            cell.descriptionLabel.textColor = UIColor.white
            cell.descriptionLabel.numberOfLines = 0
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Cells.currentOffer.rawValue, for: indexPath) as! CurrentOfferTableViewCell
            
            cell.isUserInteractionEnabled = false
            cell.backgroundColor = Colors.lightGrayBackground
            
            cell.punchCountLabel.attributedText = createAttributedString(forPunchTotal: offer.totalPunchesRequired)
            cell.punchCountLabel.textAlignment = .center
            cell.punchCountLabel.backgroundColor = Colors.gold
            cell.punchCountLabel.numberOfLines = 0
            
            cell.descriptionLabel.text = offer.name!
            cell.descriptionLabel.font = Fonts.offerDescription
            cell.descriptionLabel.textColor = UIColor.white
            cell.descriptionLabel.numberOfLines = 0
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // do something
    }
    
    
    // MARK: - Supporting functionality
    
    enum Cells: String {
        case currentOffer, matchingOffer
    }
    
    struct Dimensions {
        static let cellRowMinimumHeight: CGFloat = 80
    }
    
    struct Fonts {
        static let placeName = UIFont.boldSystemFont(ofSize: 25.0)
        static let placeAddress = UIFont.boldSystemFont(ofSize: 15.0)
        static let offerDescription = UIFont.boldSystemFont(ofSize: 17.0)
        static let punchCount = UIFont.boldSystemFont(ofSize: 17.0)
        static let punches = UIFont.boldSystemFont(ofSize: 8.0)
    }
    
    struct MapDimensions {
        static let initialRegionRadius: CLLocationDistance = 1000
    }
    
}
