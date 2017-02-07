//
//  MyOfferInstanceseDetailViewController.swift
//  Punchcard-Swift-App
//
//  Created by Gabriele Pregadio on 2/2/17.
//  Copyright © 2017 Super Slo Brothers. All rights reserved.
//

import UIKit
import ReSwift

class MyOfferInstancesDetailViewController: UIViewController, StoreSubscriber {
    
    // MARK: - IB outlets
    
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
    
    @IBOutlet weak var offerDescriptionLabel: UILabel! {
        didSet {
            offerDescriptionLabel.numberOfLines = 0
            offerDescriptionLabel.textColor = UIColor.white
            offerDescriptionLabel.font = Fonts.offerDescription
        }
    }
    
    
    // MARK: - IB actions
    
    @IBAction func redeemButtonTapped(_ sender: UIButton) {
    
    }
    
    
    // MARK: - Stored properties
    
    var myOfferInstance: OfferInstance!
    private lazy var business: Business = {
        return self.myOfferInstance.business
    }()
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.darkGrayBackground
        
        placeNameLabel.text = " \(myOfferInstance.business.name!)"
        placeAddressLabel.text = " \(business.address!)\n \(business.city!), \(business.state!) \(business.zipcode!)"
        offerDescriptionLabel.text = "This offerInstance's corresponding offer description would be displayed here..."
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
    
    func newState(state: RootState) {
        
    }
    
    
    // MARK: - Supporting functionality
    
    struct Fonts {
        static let placeName = UIFont.boldSystemFont(ofSize: 25.0)
        static let placeAddress = UIFont.boldSystemFont(ofSize: 15.0)
        static let offerDescription = UIFont.boldSystemFont(ofSize: 17.0)
        static let punchCount = UIFont.boldSystemFont(ofSize: 17.0)
        static let punches = UIFont.boldSystemFont(ofSize: 8.0)
    }
    
}