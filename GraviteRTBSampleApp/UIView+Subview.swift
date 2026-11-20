//
//  UIView+Subview.swift
//  GraviteRTBSampleApp
//
//  Created by Mahmoud Amer on 19.08.24.
//

import UIKit

extension UIView {
    func adjustSubView(view: UIView) {
        view.frame = CGRect(x: 0, y: 0, width: 320, height: 50)
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 8).isActive = true
        view.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        view.widthAnchor.constraint(equalToConstant: 320).isActive = true
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
