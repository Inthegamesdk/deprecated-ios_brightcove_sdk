//
//  ExampleViewController.swift
//  InTheGameDemo
//
//  Created by Tiago Lira on 25/11/2019.
//  Copyright © 2019 inthegame. All rights reserved.
//


import UIKit
import InTheGameBC

class ExampleViewController: UIViewController {

    let bcPolicyKey = "BCpkADawqM0lLx5gn3W7EH_Y_RhGkfNIu7gyMs4KcHq93vjZlPOPpbk_y1jTZnrUuWFxrK5D9dQx2l9_mzvuCbZLvsWs8TFhCQ0_QSd6CclMcvUu5i8YzaKXBaRL6COFKQt7hAbo5fO4Al1e"
    let bcAccountID = "6123004948001"
    let bcVideoID = "6123257480001"

    @IBOutlet weak var videoContainer: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        //instantiate the ITGPlayerView
        let playerView = ITGBCPlayerView.instantiate(videoID: bcVideoID, accountID: bcAccountID, policyKey: bcPolicyKey)

        //set up the frame or contraints
        playerView.frame = videoContainer.bounds
        playerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        playerView.translatesAutoresizingMaskIntoConstraints = true
        //add as subview
        videoContainer.addSubview(playerView)

        adjustNavigationBar()
        NotificationCenter.default.addObserver(self, selector: #selector(adjustNavigationBar), name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @objc func adjustNavigationBar() {
        let isLandscape = UIDevice.current.orientation.isLandscape
        navigationController?.setNavigationBarHidden(isLandscape, animated: true)
    }
}
