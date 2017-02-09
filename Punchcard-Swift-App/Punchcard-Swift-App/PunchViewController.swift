//
//  PunchViewController.swift
//  Punchcard-Swift-App
//
//  Created by Gabriele Pregadio on 2/2/17.
//  Copyright © 2017 Super Slo Brothers. All rights reserved.
//

import UIKit
import ReSwift

class PunchViewController: UIViewController, StoreSubscriber {
    
    // MARK: - IB outlets
    
    @IBOutlet weak var tapToPunchLabel: UILabel! {
        didSet {
            tapToPunchLabel.backgroundColor = Colors.cyan
            tapToPunchLabel.textColor = UIColor.white
            tapToPunchLabel.font = Fonts.tapToPunch
            tapToPunchLabel.isUserInteractionEnabled = true
        }
    }
    
    @IBOutlet weak var qrCodeResultLabel: UILabel! {
        didSet {
            qrCodeResultLabel.textColor = UIColor.white
            qrCodeResultLabel.font = Fonts.qrCodeResult
            qrCodeResultLabel.numberOfLines = 1
        }
    }
    
    @IBOutlet weak var placeNameLabel: UILabel! {
        didSet {
            placeNameLabel.textColor = Colors.cyan
            placeNameLabel.font = Fonts.placeName
            placeNameLabel.numberOfLines = 1
        }
    }
    
    @IBOutlet weak var offerDescriptionLabel: UILabel! {
        didSet {
            offerDescriptionLabel.textColor = Colors.gold
            offerDescriptionLabel.font = Fonts.offerDescription
            offerDescriptionLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet weak var progressLabel: UILabel! {
        didSet {
            progressLabel.textColor = Colors.cyan
            progressLabel.font = Fonts.progress
            progressLabel.numberOfLines = 1
        }
    }
    
    
    @IBOutlet weak var progressView: UIProgressView! {
        didSet {
            progressView.trackTintColor = Colors.cyan
            progressView.progressTintColor = Colors.gold
        }
    }
    
    
    // MARK: - Stored properties
    
    var testCurrentTotal = 0 {
        didSet {
            if testCurrentTotal > testRequiredTotal {
                testCurrentTotal = 0
                progressView.setProgress(testProgress, animated: false)
            } else {
                progressView.setProgress(testProgress, animated: true)
            }
            progressLabel.text = "\(testCurrentTotal)/\(testRequiredTotal)"
        }
    }
    var testRequiredTotal = 6
    
    var testProgress: Float {
        return Float(testCurrentTotal) / Float(testRequiredTotal)
    }
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.lightGrayBackground
        
        progressLabel.text = "\(testCurrentTotal)/\(testRequiredTotal)"
        progressView.setProgress(testProgress, animated: false)
        
        // TODO: - Add a glowing animation to the label while it's waiting for your tap maybe? Lots of potential for all that space to draw in.
        tapToPunchLabel.text = "Tap to punch!"
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedToPunch))
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapToPunchLabel.addGestureRecognizer(tapGestureRecognizer)
        
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
    
    
    // MARK: - Other methods
    
    @objc private func tappedToPunch(_ sender: UITapGestureRecognizer) {
        // TODO: - Add a cool animation
        
//        store.dispatch(postPunch(
//            parameters: [
//                "key" : "" as AnyObject,
//                "punch_method": "api" as AnyObject
//            ]
//        ))
        
//        store.dispatch(postOffer(parameters:
//            [
//                "name": "Test Offer" as AnyObject,
//                "description": "This is a cool description of this offer boi" as AnyObject,
//                "business": "what the fuck do i put here" as AnyObject,
//                "punch_total_required": 10 as AnyObject
//            ]
//        ))
        
        testCurrentTotal += 1
    }
    
    
    // MARK: - Supporting functionality
    
    struct Fonts {
        static let tapToPunch = UIFont.boldSystemFont(ofSize: 30.0)
        static let qrCodeResult = UIFont.systemFont(ofSize: 17.0)
        static let placeName = UIFont.italicSystemFont(ofSize: 17.0)
        static let progress = UIFont.boldSystemFont(ofSize: 17.0)
        static let offerDescription = UIFont.systemFont(ofSize: 15.0)
    }
    
}
