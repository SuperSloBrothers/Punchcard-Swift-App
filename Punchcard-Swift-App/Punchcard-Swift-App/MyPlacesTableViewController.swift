//
//  MyPlacesTableViewController.swift
//  Punchcard-Swift-App
//
//  Created by Gabriele Pregadio on 2/2/17.
//  Copyright © 2017 Super Slo Brothers. All rights reserved.
//

import UIKit
import ReSwift
import MCSwipeTableViewCell

class MyPlacesTableViewController: UITableViewController, StoreSubscriber {
    
    // MARK: - IB outlets
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    // MARK: - Stored properties
    
    var myActivePlaces = [Business]()
    var myRedeemedPlaces = [Business]()
    lazy var myPlacesDataSource: [Business] = {
        return self.myActivePlaces
    }()
    var selectedSegmentIndex = 0 {
        didSet {
            if selectedSegmentIndex == 0 {
                myPlacesDataSource = myActivePlaces
            } else {
                myPlacesDataSource = myRedeemedPlaces
            }
            tableView.reloadData()
        }
    }
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged), for: .valueChanged)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "My Places", style: .plain, target: nil, action: nil)
        
        // Create some test places.
        var aBusiness = Business()
        aBusiness.name = "Starbucks"
        aBusiness.address = "Seattle Street"
        var anotherBusiness = Business()
        anotherBusiness.name = "Doki Doki"
        anotherBusiness.address = "1 Grand Ave."
        myActivePlaces = [aBusiness, anotherBusiness]
        var aRedeemedPlace = Business()
        aRedeemedPlace.name = "Apple"
        aRedeemedPlace.address = "Sweat shop in Asia"
        myRedeemedPlaces = [aRedeemedPlace]
        
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
        return myPlacesDataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.place.rawValue, for: indexPath) as! MCSwipeTableViewCell
        let myPlace = myPlacesDataSource[indexPath.row]
        cell.textLabel?.text = myPlace.name
        cell.textLabel?.textColor = UIColor.white
        cell.detailTextLabel?.text = myPlace.address
        cell.detailTextLabel?.textColor = Colors.cyan
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = storyboard!.instantiateViewController(withIdentifier: StoryboardIdentifiers.myPlaceDetail.rawValue) as! MyPlaceDetailViewController
        vc.myPlace = myPlacesDataSource[indexPath.row]
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
    
}
