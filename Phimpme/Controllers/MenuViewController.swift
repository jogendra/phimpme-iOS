//
//  MenuViewController.swift
//  Phimpme
//
//  Created by JOGENDRA on 21/03/18.
//  Copyright © 2018 Jogendra Singh. All rights reserved.
//

import UIKit

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
        shareFolderView.layer.cornerRadius = 8.0
        hiddenFolderView.layer.cornerRadius = 8.0
        settingsView.layer.cornerRadius = 8.0
        rateUsView.layer.cornerRadius = 8.0
        uploadHistoryView.layer.cornerRadius = 8.0
        sharePhimpmeView.layer.cornerRadius = 8.0
        aboutPhimpmeView.layer.cornerRadius = 8.0
    }

    @IBAction func didTapBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
