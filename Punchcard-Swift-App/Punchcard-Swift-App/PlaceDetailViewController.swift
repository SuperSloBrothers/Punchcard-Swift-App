//
//  PlaceDetailViewController.swift
//  Punchcard-Swift-App
//
//  Created by Gabriele Pregadio on 2/2/17.
//  Copyright © 2017 Super Slo Brothers. All rights reserved.
//

import UIKit

class PlaceDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - IB outlets
    
    @IBOutlet weak var offersTableView: UITableView!
    
    
    // MARK: - Stored properties
    
    var place: Business!
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        offersTableView.rowHeight = UITableViewAutomaticDimension
        offersTableView.estimatedRowHeight = 44
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return place.offerSet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.offer.rawValue, for: indexPath)
        
        cell.textLabel?.text = place.offerSet[indexPath.row].description!
        cell.textLabel?.numberOfLines = 0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    // MARK: - Supporting functionality
    
    enum Cells: String {
        case offer
    }
    
}
