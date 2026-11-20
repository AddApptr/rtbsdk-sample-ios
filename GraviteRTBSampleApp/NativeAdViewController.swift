//
//  NativeAdViewController.swift
//  GraviteRTBSampleApp
//
//  Created by Mahmoud Amer on 11.07.24.
//

import UIKit
import RTBSDK

class NativeAdViewController: UIViewController {

    private let placementId = 1854
    private let iTunesAppId = "449621749"
    private let retryDelay: TimeInterval = 10

    var nativeAdLoader: RTBNativeAdLoader? = RTBNativeAdLoader()
    var nativeAdData: RTBNativeAd?
    private var retryWorkItem: DispatchWorkItem?
    private var isLoadingStopped = false

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var sponseredLabel: UILabel!
    @IBOutlet weak var ctaLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        nativeAdLoader?.delegate = self
        loadAd()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // Stop loading only when the screen is closed, not when something is shown on top of it.
        if isMovingFromParent || isBeingDismissed {
            stopLoading()
        }
    }

    func stopLoading() {
        isLoadingStopped = true
        retryWorkItem?.cancel()
        retryWorkItem = nil
    }

    // `load(configuration:)` must be called on the main thread.
    // To load from a background thread, use `load(configuration:userAgent:)` instead.
    func loadAd() {
        let requestConfiguration = RTBNativeAdRequestConfiguration(placementId: placementId, iTunesAppId: iTunesAppId)
        nativeAdLoader?.load(configuration: requestConfiguration)
    }

    func render() {
        guard let nativeAdData = nativeAdData else {
            return
        }
        nativeAdData.delegate = self
        // Starts impression tracking and makes the container view clickable.
        nativeAdData.trackImpression(view: containerView)
        titleLabel.text = nativeAdData.title
        bodyLabel.text = nativeAdData.body
        sponseredLabel.text = nativeAdData.sponsered
        ctaLabel.text = nativeAdData.callToAction
        if let rating = nativeAdData.rating {
            ratingLabel.text = "\(rating)"
        } else {
            ratingLabel.text = nil
        }

        if let iconUrl = nativeAdData.icon {
            loadImage(from: iconUrl) { [weak self] image in
                self?.iconImageView.image = image
            }
        }
        if let mainImageUrl = nativeAdData.image {
            loadImage(from: mainImageUrl) { [weak self] image in
                self?.mainImageView.image = image
            }
        }
    }

    // Downloads an image and always calls the completion on the main thread.
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            var image: UIImage?
            if let error = error {
                print("Failed to load image: \(error.localizedDescription)")
            } else if let data = data {
                image = UIImage(data: data)
            }
            if image == nil {
                print("No data or failed to convert data to image")
            }

            DispatchQueue.main.async {
                completion(image)
            }
        }

        task.resume()
    }
}

extension NativeAdViewController: RTBNativeAdLoaderDelegate {
    func nativeAdDidReceiveAd(_ nativeAdLoader: RTBSDK.RTBNativeAdLoader, bidInfo: RTBSDK.RTBBidInfo, networkName: String) {
        print("RTBNativeAdDelegate 👉 \(#function)")
        nativeAdData = nativeAdLoader.getNativeAd()
        render()
    }

    func nativeAdView(_ nativeAd: RTBSDK.RTBNativeAdLoader, didFailToReceiveAd errorMessage: String, networkName: String) {
        print("RTBNativeAdDelegate 👉 \(#function): \(errorMessage)")
        // A request may still finish after the screen was closed - don't schedule a new one then.
        guard !isLoadingStopped else {
            return
        }
        let workItem = DispatchWorkItem { [weak self] in
            self?.loadAd()
        }
        retryWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + retryDelay, execute: workItem)
    }
}

extension NativeAdViewController: RTBNativeAdInteractionDelegate {
    func nativeAdView(_ nativeAd: RTBSDK.RTBNativeAd, didFailToRender errorMessage: String, networkName: String) {
        print("RTBNativeAdDelegate 👉 \(#function)")
    }

    func nativeAdDidRecordClick(_ nativeAd: RTBSDK.RTBNativeAd, networkName: String) {
        print("RTBNativeAdDelegate 👉 \(#function)")
    }

    func nativeAdDidPauseForAd(_ nativeAd: RTBSDK.RTBNativeAd, networkName: String) {
        print("RTBNativeAdDelegate 👉 \(#function)")
    }

    func nativeAdDidResumeAfterAd(_ nativeAd: RTBSDK.RTBNativeAd, networkName: String) {
        print("RTBNativeAdDelegate 👉 \(#function)")
    }
}
