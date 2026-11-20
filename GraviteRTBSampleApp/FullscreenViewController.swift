//
//  FullscreenViewController.swift
//  GraviteRTBSampleApp
//
//  Created by Mohamed Matloub  on 07.05.24.
//

import UIKit
import RTBSDK

enum FullScreenAdState {
    case idle, loading, loaded, failed
}

class FullscreenViewController: UIViewController {
    var fullscreenAd = RTBFullscreenAd()

    @IBOutlet weak var loadButton: UIButton!
    @IBOutlet weak var appIdTextField: UITextField!
    @IBOutlet weak var placementIdTextField: UITextField!

    var fullScreenAdState: FullScreenAdState = .idle {
        didSet {
            switch fullScreenAdState {
            case .idle:
                loadButton.setTitle("Start loading Fullscreen Ads", for: .normal)
            case .loading:
                loadButton.setTitle("Loading", for: .normal)
            case .loaded:
                loadButton.setTitle("Show Fullscreen Ads", for: .normal)
            case .failed:
                loadButton.setTitle("Failed to load ad, click to try again", for: .normal)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // [ADS] - Create `RTBFullscreenAd`
        fullscreenAd = RTBFullscreenAd()
        // [ADS] - listen to delegate events
        fullscreenAd.delegate = self
    }

    @IBAction func loadTapped(_ sender: UIButton) {
        switch fullScreenAdState {
        case .idle, .failed:
            // [ADS] - create `RTBFullscreenRequestConfiguration` object with your App iTunes ID and banner placement ID.
            let placementId = Int(placementIdTextField.text ?? "15") ?? 15
            let iTunesId = appIdTextField.text ?? "449621749"
            let configuration = RTBFullscreenRequestConfiguration(placementId: placementId, iTunesAppId: iTunesId)
            // [ADS] - pass sellerId
            configuration.sellerId = "1234"
            // [ADS] - start loading
            fullscreenAd.load(configuration: configuration)

            self.fullScreenAdState = .loading
        case .loading:
            print("Ad is loading")
        case .loaded:
            // [ADS] displaying loaded FullScreen Ad
            fullscreenAd.show(viewController: self)
            self.fullScreenAdState = .idle
        }
    }
}

extension FullscreenViewController: RTBFullscreenDelegate {
    func fullscreenAdDidReceiveAd(_ fullscreenAd: RTBFullscreenAd, bidInfo adInfo: RTBBidInfo, networkName: String) {
        print("RTBFullscreenDelegate 👉 \(#function)")
        // [ADS] - RTBSDK got an Ad and can be shown.
        fullScreenAdState = .loaded
    }

    func fullscreenAd(_ fullscreenAd: RTBFullscreenAd, didFailToReceiveAd errorMessage: String, networkName: String) {
        print("RTBFullscreenDelegate 👉 \(#function), Error: \(errorMessage)")
        fullScreenAdState = .failed
    }

    func fullscreenAdDidRecordClick(_ fullscreenAd: RTBFullscreenAd, networkName: String) {
        print("RTBFullscreenDelegate 👉 \(#function)")
    }

    func fullscreenAdDidPauseForAd(_ fullscreenAd: RTBFullscreenAd, networkName: String) {
        print("RTBFullscreenDelegate 👉 \(#function)")
    }

    func fullscreenAdDidResumeAfterAd(_ fullscreenAd: RTBFullscreenAd, networkName: String) {
        print("RTBFullscreenDelegate 👉 \(#function)")
    }
}
