//
//  LoginViewController.swift
//  Punchcard-Swift-App
//
//  Created by Amir Saifi on 2/3/17.
//  Copyright © 2017 Super Slo Brothers. All rights reserved.
//

import UIKit
import ReSwift

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func requestApiTokenButtonPressed(_ sender: Any) {
        requestAPIToken { (isSuccess) in
            if isSuccess {
                store.dispatch(ResetUserState())
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                if let vc = storyboard.instantiateInitialViewController() {
                    self.present(vc, animated: true, completion: nil)
                } else {
                    print("problem initializing VC on main.storyboard")
                }
            } else {
                // failed
                print("Request for API Token Failed")
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
