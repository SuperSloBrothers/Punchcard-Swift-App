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

class MyOfferInstancesTableViewController: UITableViewController, StoreSubscriber {
    
    // MARK: - IB outlets
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    // MARK: - Stored properties
    
    var myActiveOfferInstances = [OfferInstance]()
    var myRedeemedOfferInstances = [OfferInstance]()
    var myOffersDataSource = [OfferInstance]()
    var selectedSegmentIndex = 0 {
        didSet {
            myOffersDataSource = (selectedSegmentIndex == 0) ? myActiveOfferInstances : myRedeemedOfferInstances
            tableView.reloadData()
        }
    }
    var offerInstancesAreLoading = false
    var loadingError: Error?
    
    
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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.subscribe(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // TODO: - Find a better place to call this. It's getting called an unnecessary amount of times.
        store.dispatch(getOfferInstances())
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
        if let offerInstancesResult = state.punchcardData.offerInstances {
            switch offerInstancesResult {
            case .Success(let offerInstances):
                offerInstancesAreLoading = false
                loadingError = nil
                // TODO: - Following two lines should be done via parameters in the request (I think).
                myRedeemedOfferInstances = offerInstances.filter { $0.redeemedDate != nil }
                myActiveOfferInstances = offerInstances.filter { $0.redeemedDate == nil }
                myOffersDataSource = (selectedSegmentIndex == 0) ? myActiveOfferInstances : myRedeemedOfferInstances
                tableView.reloadData()
            case .Failure(let error):
                offerInstancesAreLoading = false
                loadingError = error
                tableView.reloadEmptyDataSet()
            case .Loading():
                offerInstancesAreLoading = true
                loadingError = nil
                tableView.reloadEmptyDataSet()
            }
        }
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
    
    
    // MARK: - Supporting functionality
    
    enum Cells: String {
        case place
    }
    
    struct Constants {
        static let rowHeigh: CGFloat = 60
    }
    
    struct Messages {
        static let errorLoading = "Loading Error"
        static let loadingOfferInstances = "Loading your offer instances..."
        static let noActiveOfferInstancesMessage = "No active offers."
        static let noActiveOfferInstancesDetailedMessage = "Go use this app."
        static let noRedeemedOfferInstancesMessage = "No redeemed offers."
        static let noRedeemedOfferInstancesDetailedMessage = "Go redeem something."
    }
    
}
