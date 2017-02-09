//
//  MyOfferInstancesVC+EmptyDataSet.swift
//  Punchcard-Swift-App
//
//  Created by Gabriele Pregadio on 2/8/17.
//  Copyright © 2017 Super Slo Brothers. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

extension MyOfferInstancesTableViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        if let _ = loadingError {
            return NSAttributedString(
                string: Messages.errorLoading,
                attributes: [
                    NSFontAttributeName: UIFont.systemFont(ofSize: 27.0),
                    NSForegroundColorAttributeName: UIColor.white
                ]
            )
        }
        if offerInstancesAreLoading {
            return NSAttributedString(
                string: Messages.loadingOfferInstances,
                attributes: [
                    NSFontAttributeName: UIFont.boldSystemFont(ofSize: 27.0),
                    NSForegroundColorAttributeName: UIColor.white
                ]
            )
        }
        if selectedSegmentIndex == 0 {
            // Active
            return NSAttributedString(
                string: Messages.noActiveOfferInstancesMessage,
                attributes: [
                    NSFontAttributeName: UIFont.boldSystemFont(ofSize: 27.0),
                    NSForegroundColorAttributeName: UIColor.white
                ]
            )
        } else {
            // Redeemed
            return NSAttributedString(
                string: Messages.noRedeemedOfferInstancesMessage,
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
                    NSFontAttributeName: UIFont.systemFont(ofSize: 15.0),
                    NSForegroundColorAttributeName: UIColor.lightGray
                ]
            )
        }
        if offerInstancesAreLoading {
            return nil
        }
        if selectedSegmentIndex == 0 {
            // Active
            return NSAttributedString(
                string: Messages.noActiveOfferInstancesDetailedMessage,
                attributes: [
                    NSFontAttributeName: UIFont.boldSystemFont(ofSize: 15.0),
                    NSForegroundColorAttributeName: UIColor.white
                ]
            )
        } else {
            // Redeemed
            return NSAttributedString(
                string: Messages.noRedeemedOfferInstancesDetailedMessage,
                attributes: [
                    NSFontAttributeName: UIFont.boldSystemFont(ofSize: 15.0),
                    NSForegroundColorAttributeName: UIColor.white
                ]
            )
        }
    }
    
}
