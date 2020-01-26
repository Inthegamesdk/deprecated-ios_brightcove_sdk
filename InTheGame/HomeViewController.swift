//
//  HomeViewController.swift
//  InTheGameDemo
//
//  Created by Tiago Lira on 02/12/2019.
//  Copyright © 2019 inthegame. All rights reserved.
//

import UIKit
import InTheGameBC

let bcPolicyKey = "xxxxxx"
let bcAccountID = "xxxxxx"
let bcVideoID = "xxxxxx"

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func openFullscreenVideo(_ sender: Any) {
        let controller = ITGBCPlayerViewController.instantiate(videoID: bcVideoID, accountID: bcAccountID, policyKey: bcPolicyKey, broadcasterName: "demos")
        present(controller, animated: true, completion: nil)
    }
}
