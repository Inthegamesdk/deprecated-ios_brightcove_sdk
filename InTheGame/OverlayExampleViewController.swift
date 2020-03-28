//
//  OverlayExampleViewController.swift
//  InTheGameBCDemo
//
//  Created by Tiago Lira Pereira on 27/03/2020.
//  Copyright © 2020 In The Game. All rights reserved.
//

import UIKit
import BrightcovePlayerSDK
import InTheGameBC

class OverlayExampleViewController: UIViewController {

    @IBOutlet weak var playerContainer: UIView!
    
    var videoController: BCOVPlaybackController!
    var overlay: ITGOverlayView!
    weak var currentPlayer: AVPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        loadVideoPlayer()
        loadOverlay()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        videoController.remove(self)
    }
    
    func loadVideoPlayer() {
        let manager = BCOVPlayerSDKManager.shared()
        videoController = manager?.createPlaybackController()

        let view = videoController.view!
        view.frame = playerContainer.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true

        playerContainer.addSubview(view)
        
        videoController.add(self)
        
        let service = BCOVPlaybackService(accountId: bcAccountID, policyKey: bcPolicyKey)
        service?.findVideo(withVideoID: bcVideoID, parameters: nil, completion: { (video, response, error) in
            if let video = video {
                self.videoController.setVideos([video] as NSFastEnumeration)
                self.videoController.play()
            }
        })
    }
    
    func loadOverlay() {
        let view = ITGOverlayView(videoID: bcVideoID, broadcasterName: "demos")
        view.frame = playerContainer.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        playerContainer.addSubview(view)
        overlay = view

        //add the ITG overlay as consumer of video playback events
        videoController.add(view)
    }
    
    deinit {
        videoController.remove(overlay)
        videoController.setVideos([] as NSFastEnumeration)
        videoController.view.removeFromSuperview()
        videoController = nil
        currentPlayer = nil
        overlay = nil
    }
    
    @IBAction func actionPlay(_ sender: Any) {
        videoController.play()
    }
    
    @IBAction func actionPause(_ sender: Any) {
        videoController.pause()
    }
    
    @IBAction func actionForward(_ sender: Any) {
        let time = currentPlayer?.currentTime().seconds ?? 100
        videoController.seek(to: CMTime(seconds: time + 20, preferredTimescale: 1), completionHandler: { (success) in
        })
    }
}

extension OverlayExampleViewController: BCOVPlaybackSessionConsumer {
    
    public func didAdvance(to session: BCOVPlaybackSession!) {
        currentPlayer = session.player
    }
}
