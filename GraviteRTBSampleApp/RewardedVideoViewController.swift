//
//  RewardedVideoViewController.swift
//  GraviteRTBSampleApp
//
//  Created by Michał Kapuściński on 21.01.26.
//

import UIKit
import RTBSDK

enum RVAdState {
    case idle, loading, loaded, failed
}

class RewardedVideoViewController: UIViewController {
    var rewardedVideo = RTBRewardedVideoAd()

    @IBOutlet weak var loadButton: UIButton!
    @IBOutlet weak var appIdTextField: UITextField!
    @IBOutlet weak var placementIdTextField: UITextField!

    var rewardedAdState: RVAdState = .idle {
        didSet {
            switch rewardedAdState {
            case .idle:
                loadButton.setTitle("Start loading Rewarded Video", for: .normal)
            case .loading:
                loadButton.setTitle("Loading", for: .normal)
            case .loaded:
                loadButton.setTitle("Show RewardedVideo", for: .normal)
            case .failed:
                loadButton.setTitle("Failed to load ad, click to try again", for: .normal)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // [ADS] - Create `RTBRewardedVideoAd`
        rewardedVideo = RTBRewardedVideoAd()
        // [ADS] - listen to delegate events
        rewardedVideo.delegate = self
    }

    @IBAction func loadTapped(_ sender: UIButton) {
        switch rewardedAdState {
        case .idle, .failed:
            // [ADS] - create `RTBRewardedVideoRequestConfiguration` object with your App iTunes ID and banner placement ID.
            let placementId = Int(placementIdTextField.text ?? "3382") ?? 3382
            let iTunesId = appIdTextField.text ?? "449621749"
            let configuration = RTBRewardedVideoRequestConfiguration(placementId: placementId, iTunesAppId: iTunesId)
            // [ADS] - pass sellerId
            configuration.sellerId = "1234"
            // [ADS] - start loading
            rewardedVideo.load(configuration: configuration)

            self.rewardedAdState = .loading
        case .loading:
            print("Ad is loading")
        case .loaded:
            // [ADS] displaying loaded RewardedVideo Ad
            rewardedVideo.show(viewController: self)
            self.rewardedAdState = .idle
        }
    }
}

extension RewardedVideoViewController: RTBRewardedVideoAdDelegate {
    func rewardedVideoAdDidReceiveAd(_ rewardedVideoAd: RTBRewardedVideoAd, bidInfo: RTBSDK.RTBBidInfo, networkName: String) {
        print("RTBRewardedVideoAdDelegate 👉 \(#function)")
        // [ADS] - RTBSDK got an Ad and can be shown.
        rewardedAdState = .loaded
    }
    
    func rewardedVideoAd(_ rewardedVideoAd: RTBRewardedVideoAd, didFailToReceiveAd errorMessage: String, networkName: String) {
        print("RTBRewardedVideoAdDelegate 👉 \(#function), Error: \(errorMessage)")
        rewardedAdState = .failed
    }
    
    func rewardedVideoAdDidRecordClick(_ rewardedVideoAd: RTBRewardedVideoAd, networkName: String) {
        print("RTBRewardedVideoAdDelegate 👉 \(#function)")
    }
    
    func rewardedVideoAdDidPauseForAd(_ rewardedVideoAd: RTBRewardedVideoAd, networkName: String) {
        print("RTBRewardedVideoAdDelegate 👉 \(#function)")
    }
    
    func rewardedVideoAdDidResumeAfterAd(_ rewardedVideoAd: RTBRewardedVideoAd, networkName: String) {
        print("RTBRewardedVideoAdDelegate 👉 \(#function)")
    }
    
    func rewardedVideoAdDidReceiveReward(_ rewardedVideoAd: RTBRewardedVideoAd, networkName: String) {
        print("RTBRewardedVideoAdDelegate 👉 \(#function)")
    }
    
}
