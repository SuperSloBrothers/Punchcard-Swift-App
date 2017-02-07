//
//  PlaceDetailViewController.swift
//  Punchcard-Swift-App
//
//  Created by Gabriele Pregadio on 2/2/17.
//  Copyright © 2017 Super Slo Brothers. All rights reserved.
//

import UIKit
import MapKit

class PlaceDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate {
    
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
    @IBOutlet weak var mapView: MKMapView!
    
    
    // MARK: - Stored properties
    
    var place: Business!
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.darkGrayBackground
        
        placeNameLabel.text = " \(place.name!)"
        placeAddressLabel.text = " \(place.address!)\n \(place.city!), \(place.state!) \(place.zipcode!)"
        
        formatMap()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.currentOffer.rawValue, for: indexPath) as! CurrentOfferTableViewCell
        let offer = place.offerSet[indexPath.row]
        
        cell.backgroundColor = Colors.lightGrayBackground
        
        cell.punchCountLabel.attributedText = createAttributedString(forPunchTotal: offer.totalPunchesRequired)
        cell.punchCountLabel.textAlignment = .center
        cell.punchCountLabel.backgroundColor = Colors.gold
        cell.punchCountLabel.numberOfLines = 0
        
        cell.descriptionLabel.text = offer.description!
        cell.descriptionLabel.font = Fonts.offerDescription
        cell.descriptionLabel.textColor = UIColor.white
        cell.descriptionLabel.numberOfLines = 0
        
        return cell
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
        case currentOffer
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
