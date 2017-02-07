//
//  MyOfferInstancesTableViewController.swift
//  Punchcard-Swift-App
//
//  Created by Gabriele Pregadio on 2/2/17.
//  Copyright © 2017 Super Slo Brothers. All rights reserved.
//

import UIKit
import ReSwift
import MCSwipeTableViewCell
import DZNEmptyDataSet

class MyOfferInstancesTableViewController: UITableViewController, StoreSubscriber, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    // MARK: - IB outlets
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    // MARK: - Stored properties
    
    var myActiveOfferInstances = [OfferInstance]()
    var myRedeemedOfferInstances = [OfferInstance]()
    var myOffersDataSource = [OfferInstance]()
    var selectedSegmentIndex = 0 {
        didSet {
            if selectedSegmentIndex == 0 {
                myOffersDataSource = myActiveOfferInstances
            } else {
                myOffersDataSource = myRedeemedOfferInstances
            }
            tableView.reloadData()
        }
    }
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "My Places", style: .plain, target: nil, action: nil)
        
        tableView.backgroundColor = Colors.darkGrayBackground
        tableView.separatorColor = Colors.gold
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        // Removes cell separators when table view is empty.
        tableView.tableFooterView = UIView()
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged), for: .valueChanged)
        
        // Create some test offer instances - comment out this block to test empty data set.
        var anOfferInstance = OfferInstance()
        var aBusiness = Business()
        aBusiness.name = "Mike's Can"
        aBusiness.address = "123 Poop St."
        aBusiness.city = "Poop Land"
        aBusiness.state = "TX"
        aBusiness.zipcode = "80085"
        anOfferInstance.business = aBusiness
        anOfferInstance.hasBeenRedeemed = false
        anOfferInstance.totalPunches = 3
        anOfferInstance.totalPunchesRequired = 5
        myActiveOfferInstances = [anOfferInstance]
        
        myOffersDataSource = myActiveOfferInstances
        tableView.reloadData()
        
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
    
    
    // MARK: - Methods
    
    @objc private func segmentedControlChanged(sender: UISegmentedControl) {
        selectedSegmentIndex = sender.selectedSegmentIndex
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myOffersDataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.place.rawValue, for: indexPath) as! MCSwipeTableViewCell
        let myOfferInstance = myOffersDataSource[indexPath.row]
        cell.backgroundColor = Colors.darkGrayBackground
        cell.textLabel?.text = myOfferInstance.business.name
        cell.textLabel?.textColor = UIColor.white
        cell.detailTextLabel?.text = myOfferInstance.business.address
        cell.detailTextLabel?.textColor = Colors.cyan
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = storyboard!.instantiateViewController(withIdentifier: StoryboardIdentifiers.myOfferInstancesDetail.rawValue) as! MyOfferInstancesDetailViewController
        vc.myOfferInstance = myOffersDataSource[indexPath.row]
        navigationController!.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.rowHeigh
    }
    
    
    // MARK: - Empty data set data source
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        if selectedSegmentIndex == 0 {
            // Active
            return NSAttributedString(
                string: Constants.noActiveOfferInstancesMessage,
                attributes: [
                    NSFontAttributeName: UIFont.boldSystemFont(ofSize: 30.0),
                    NSForegroundColorAttributeName: UIColor.white
                ]
            )
        } else {
            // Redeemed
            return NSAttributedString(
                string: Constants.noRedeemedOfferInstancesMessage,
                attributes: [
                    NSFontAttributeName: UIFont.boldSystemFont(ofSize: 30.0),
                    NSForegroundColorAttributeName: UIColor.white
                ]
            )
        }
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        if selectedSegmentIndex == 0 {
            // Active
            return NSAttributedString(
                string: Constants.noActiveOfferInstancesDetailedMessage,
                attributes: [
                    NSFontAttributeName: UIFont.boldSystemFont(ofSize: 17.0),
                    NSForegroundColorAttributeName: UIColor.white
                ]
            )
        } else {
            // Redeemed
            return NSAttributedString(
                string: Constants.noRedeemedOfferInstancesDetailedMessage,
                attributes: [
                    NSFontAttributeName: UIFont.boldSystemFont(ofSize: 17.0),
                    NSForegroundColorAttributeName: UIColor.white
                ]
            )
        }
    }
    
    
    // MARK: - Supporting functionality
    
    enum Cells: String {
        case place
    }
    
    struct Constants {
        static let rowHeigh: CGFloat = 60
        static let noActiveOfferInstancesMessage = "No active offers."
        static let noActiveOfferInstancesDetailedMessage = "Go use this app you asshole."
        static let noRedeemedOfferInstancesMessage = "No redeemed offers."
        static let noRedeemedOfferInstancesDetailedMessage = "Go redeem some shit."
    }
    
}
