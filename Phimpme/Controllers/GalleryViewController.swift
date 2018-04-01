//
//  ViewController.swift
//  Phimpme-iOS
//
//  Created by JOGENDRA on 14/03/18.
//  Copyright © 2018 Jogendra Singh. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func didTapSettingsMenu(_ sender: Any) {
        guard let settingsViewController = UIStoryboard.settingsVC() as? SettingsViewController else {
            return
        }
        if let navigation = navigationController {
            navigation.pushViewController(settingsViewController, animated: true)
        }
    }
}

