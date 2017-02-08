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
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return UIColor.white
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        if let _ = loadingError {
            return NSAttributedString(
                string: Messages.errorLoading,
                attributes: [
                    NSFontAttributeName: UIFont.systemFont(ofSize: 25.0),
                    NSForegroundColorAttributeName: UIColor.lightGray
                ]
            )
        }
        if businessesAreLoading {
            return NSAttributedString(
                string: Messages.loadingBusinesses,
                attributes: [
                    NSFontAttributeName: UIFont.systemFont(ofSize: 25.0),
                    NSForegroundColorAttributeName: UIColor.lightGray
                ]
            )
        }
        if authorizationStatus == .denied {
            return NSAttributedString(
                string: Messages.locationServicesDisabled,
                attributes: [
                    NSFontAttributeName: UIFont.systemFont(ofSize: 25.0),
                    NSForegroundColorAttributeName: UIColor.lightGray
                ]
            )
        } else {
            return NSAttributedString(
                string: Messages.noNearbyPlaces,
                attributes: [
                    NSFontAttributeName: UIFont.systemFont(ofSize: 25.0),
                    NSForegroundColorAttributeName: UIColor.lightGray
                ]
            )
        }
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        if let error = loadingError {
            return NSAttributedString(
                string: error.localizedDescription,
                attributes: [
                    NSFontAttributeName: UIFont.systemFont(ofSize: 25.0),
                    NSForegroundColorAttributeName: UIColor.lightGray
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
                    NSFontAttributeName: UIFont.systemFont(ofSize: 12.0),
                    NSForegroundColorAttributeName: UIColor.lightGray
                ]
            )
        } else {
            return NSAttributedString(
                string: Messages.noNearbyPlacesDetailed,
                attributes: [
                    NSFontAttributeName: UIFont.systemFont(ofSize: 12.0),
                    NSForegroundColorAttributeName: UIColor.lightGray
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
