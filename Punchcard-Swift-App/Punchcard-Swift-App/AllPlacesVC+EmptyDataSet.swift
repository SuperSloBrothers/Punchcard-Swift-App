//
//  AllPlacesVC+EmptyDataSet.swift
//  Punchcard-Swift-App
//
//  Created by Gabriele Pregadio on 2/8/17.
//  Copyright © 2017 Super Slo Brothers. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

extension AllPlacesTableViewController: DZNEmptyDataSetDelegate, DZNEmptyDataSetSource {
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        if let _ = loadingError {
            return NSAttributedString(
                string: Messages.errorLoading,
                attributes: [
                    NSFontAttributeName: UIFont.boldSystemFont(ofSize: 27.0),
                    NSForegroundColorAttributeName: UIColor.white
                ]
            )
        }
        if businessesAreLoading {
            return NSAttributedString(
                string: Messages.loadingBusinesses,
                attributes: [
                    NSFontAttributeName: UIFont.boldSystemFont(ofSize: 27.0),
                    NSForegroundColorAttributeName: UIColor.white
                ]
            )
        }
        if authorizationStatus == .denied {
            return NSAttributedString(
                string: Messages.locationServicesDisabled,
                attributes: [
                    NSFontAttributeName: UIFont.boldSystemFont(ofSize: 27.0),
                    NSForegroundColorAttributeName: UIColor.white
                ]
            )
        } else {
            return NSAttributedString(
                string: Messages.noNearbyPlaces,
                attributes: [
                    NSFontAttributeName: UIFont.boldSystemFont(ofSize: 27.0),
                    NSForegroundColorAttributeName: UIColor.white
                ]
            )
        }
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        if let error = loadingError {
            return NSAttributedString(
                string: error.localizedDescription,
                attributes: [
                    NSFontAttributeName: UIFont.boldSystemFont(ofSize: 15.0),
                    NSForegroundColorAttributeName: UIColor.white
                ]
            )
        }
        if businessesAreLoading {
            return nil
        }
        if authorizationStatus == .denied {
            return NSAttributedString(
                string: Messages.locationServicesDisabledDetailed,
                attributes: [
                    NSFontAttributeName: UIFont.boldSystemFont(ofSize: 15.0),
                    NSForegroundColorAttributeName: UIColor.white
                ]
            )
        } else {
            return NSAttributedString(
                string: Messages.noNearbyPlacesDetailed,
                attributes: [
                    NSFontAttributeName: UIFont.boldSystemFont(ofSize: 15.0),
                    NSForegroundColorAttributeName: UIColor.white
                ]
            )
        }
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControlState) -> NSAttributedString! {
        guard authorizationStatus == .denied else { return nil }
        
        return NSAttributedString(
            string: Messages.settingsButtonTitle,
            attributes: [
                NSFontAttributeName: UIFont.boldSystemFont(ofSize: 15.0),
                NSForegroundColorAttributeName: state == .normal ? Colors.buttonNormal : Colors.buttonSelected
            ]
        )
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        guard authorizationStatus == .denied else { return }
        guard button.titleLabel?.text == Messages.settingsButtonTitle else { return }
        guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else { return }
        guard UIApplication.shared.canOpenURL(settingsUrl) else { return }
        UIApplication.shared.open(settingsUrl)
    }

}
