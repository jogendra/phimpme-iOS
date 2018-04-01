//
//  AccountsTableViewController.swift
//  Phimpme
//
//  Created by JOGENDRA on 20/03/18.
//  Copyright © 2018 Jogendra Singh. All rights reserved.
//

import UIKit

class AccountsTableViewController: UITableViewController {

    var accountsName: [String] = [ControllerConstants.Accounts.facebook, ControllerConstants.Accounts.twitter, ControllerConstants.Accounts.instagram, ControllerConstants.Accounts.nextCloud, ControllerConstants.Accounts.pinterest, ControllerConstants.Accounts.flickr, ControllerConstants.Accounts.dropBox, ControllerConstants.Accounts.owncloud, ControllerConstants.Accounts.box, ControllerConstants.Accounts.tumblr]
    var accountsImages: [UIImage?] = [ControllerConstants.Images.facebookCircledIcon, ControllerConstants.Images.twitterIcon, ControllerConstants.Images.instagramIcon, ControllerConstants.Images.nextCloudIcon, ControllerConstants.Images.pinterestIcon, ControllerConstants.Images.flickrFilledIcon, ControllerConstants.Images.dropBoxIcon, ControllerConstants.Images.owncloudIcon, ControllerConstants.Images.boxIcon, ControllerConstants.Images.tumblrIcon]

    override func viewDidLoad() {
        super.viewDidLoad()

         self.clearsSelectionOnViewWillAppear = true

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountsName.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ControllerConstants.accountsCellIdentifier, for: indexPath)
        cell.textLabel?.text = accountsName[indexPath.row]
        cell.imageView?.image = accountsImages[indexPath.row]

        let switchView = UISwitch(frame: .zero)
        switchView.setOn(false, animated: true)
        switchView.tag = indexPath.row // for detect which row switch Changed
        switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        cell.accessoryView = switchView

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }

    @objc func switchChanged(_ sender: UISwitch!) {
        print("table row switch Changed \(sender.tag)")
        print("The switch is \(sender.isOn ? "ON" : "OFF")")
    }

}
