//
//  MenuViewController.swift
//  Phimpme
//
//  Created by JOGENDRA on 21/03/18.
//  Copyright © 2018 Jogendra Singh. All rights reserved.
//

import UIKit

fileprivate struct DefaultConstants {
    static let menuViewsCornerRadius: CGFloat = 8.0
}

class MenuViewController: UIViewController {

    @IBOutlet weak var shareFolderView: UIView!

    @IBOutlet weak var hiddenFolderView: UIView!

    @IBOutlet weak var settingsView: UIView!

    @IBOutlet weak var rateUsView: UIView!

    @IBOutlet weak var uploadHistoryView: UIView!

    @IBOutlet weak var sharePhimpmeView: UIView!

    @IBOutlet weak var aboutPhimpmeView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        initialUISetups()
    }

    private func initialUISetups() {
        // Set corner radius
        shareFolderView.layer.cornerRadius = DefaultConstants.menuViewsCornerRadius
        hiddenFolderView.layer.cornerRadius = DefaultConstants.menuViewsCornerRadius
        settingsView.layer.cornerRadius = DefaultConstants.menuViewsCornerRadius
        rateUsView.layer.cornerRadius = DefaultConstants.menuViewsCornerRadius
        uploadHistoryView.layer.cornerRadius = DefaultConstants.menuViewsCornerRadius
        sharePhimpmeView.layer.cornerRadius = DefaultConstants.menuViewsCornerRadius
        aboutPhimpmeView.layer.cornerRadius = DefaultConstants.menuViewsCornerRadius
    }

    @IBAction func didTapBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
