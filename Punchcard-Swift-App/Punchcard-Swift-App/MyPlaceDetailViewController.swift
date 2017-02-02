//
//  MyPlaceDetailViewController.swift
//  Punchcard-Swift-App
//
//  Created by Gabriele Pregadio on 2/2/17.
//  Copyright © 2017 Super Slo Brothers. All rights reserved.
//

import UIKit

class MyPlaceDetailViewController: UIViewController {
    
    var myPlace: Business!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        label.center = view.center
        label.numberOfLines = 2
        label.text = "\(myPlace.name!)\n\(myPlace.address!)"
        label.textAlignment = .center
        view.addSubview(label)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
