//
//  BannerViewController.swift
//  GraviteRTBSampleApp
//
//  Created by Mohamed Matloub  on 07.05.24.
//

import UIKit
import RTBSDK

class BannerViewController: UIViewController {
    var bannerAdView: RTBBannerView?

    @IBOutlet weak var loadButton: UIButton!
    @IBOutlet weak var appIdTextField: UITextField!
    @IBOutlet weak var placementIdTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // [ADS] - Create `RTBBannerView` with desired size
        bannerAdView = RTBBannerView(size: .banner320x50)
        // [ADS] - add `RTBBannerView` to your view hierarchy.
        addBannerView(bannerAdView)
        // [ADS] - listen to delegate events if needed
        bannerAdView?.delegate = self
    }

    @IBAction func loadAction(_ sender: UIButton) {
        let placementId = Int(placementIdTextField.text ?? "14") ?? 14
        let iTunesId = appIdTextField.text ?? "449621749"
        // [ADS] - create `RTBBannerRequestConfiguration` object with your App iTunes ID and banner placement ID.
        let configuration = RTBBannerRequestConfiguration(placementId: placementId, iTunesAppId: iTunesId)
        // [ADS] - pass sellerId
        configuration.sellerId = "1234"

        // [ADS] - start loading
        bannerAdView?.load(configuration: configuration)
    }

    func addBannerView(_ bannerAdView: UIView?) {
        guard let bannerAdView = bannerAdView else {
            return
        }
        view.adjustSubView(view: bannerAdView)
    }
}

extension BannerViewController: RTBBannerViewDelegate {
    func bannerViewDidReceiveAd(_ bannerView: RTBBannerView, bidInfo: RTBBidInfo, networkName: String) {
        print("👉 \(#function)")
    }

    func bannerView(_ bannerView: RTBBannerView, didFailToRender errorMessage: String, networkName: String) {
        print("👉 \(#function) - Error: \(errorMessage)")
    }

    func bannerView(_ bannerView: RTBBannerView, didFailToReceiveAd error: String, networkName: String) {
        print("👉 \(#function) - Error: \(error)")
    }

    func bannerViewDidRecordClick(_ bannerView: RTBBannerView, networkName: String) {
        print("👉 \(#function)")
    }

    func bannerViewDidPauseForAd(_ bannerView: RTBBannerView, networkName: String) {
        print("👉 \(#function)")
    }

    func bannerViewDidResumeAfterAd(_ bannerView: RTBBannerView, networkName: String) {
        print("👉 \(#function)")
    }
}

