//
//  BannerProviderViewController.swift
//  GraviteRTBSampleApp
//
//  Created by Mahmoud Amer on 19.08.24.
//

import UIKit
import RTBSDK
import WebKit

class BannerProviderViewController: UIViewController {

    @IBOutlet weak var loadButton: UIButton!
    @IBOutlet weak var appIdTextField: UITextField!
    @IBOutlet weak var placementIdTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loadAction(_ sender: UIButton) {
        let placementId = Int(placementIdTextField.text ?? "14") ?? 14
        let iTunesId = appIdTextField.text ?? "449621749"
        // [ADS] - create `RTBBannerRequestConfiguration` object with your App iTunes ID and banner placement ID.
        let configuration = RTBBannerRequestConfiguration(placementId: placementId, iTunesAppId: iTunesId)
        // [ADS] - pass sellerId
        configuration.sellerId = "1234"

        let userAgent = (WKWebView().value(forKey: "userAgent") as? String) ?? ""
        // [ADS] - start loading
        RTBBannerAdProvider.load(configuration: configuration, size: .banner320x50, userAgent: userAgent, loadDelegate: self)
    }
}

extension BannerProviderViewController: RTBBannerAdLoadDelegate {
    func bannerAdDidReceiveAd(bannerBid: RTBSDK.RTBBannerBid) {
        print("\(#function)")
        DispatchQueue.main.async {
            guard let bannerView = RTBBannerAdProvider.getBannerView(bannerBid: bannerBid, delegate: self) else {
                return
            }
            self.view.adjustSubView(view: bannerView)
        }
    }
    
    func bannerAdDidFailToReceiveAd(errorMessage: String) {
        print("\(#function) with error: \(errorMessage)")
    }
}

extension BannerProviderViewController: RTBBannerAdInteractionDelegate {
    func bannerAdDidRecordClick() {
        print("👉 \(#function)")
    }
    
    func bannerAdDidPauseForAd() {
        print("👉 \(#function)")
    }
    
    func bannerAdDidResumeAfterAd() {
        print("👉 \(#function)")
    }
    
    func bannerAdDidFailToRender(error: String) {
        print("👉 \(#function) with error: \(error)")
    }
}
