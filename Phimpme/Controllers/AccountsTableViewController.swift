//
//  AccountsTableViewController.swift
//  Phimpme
//
//  Created by JOGENDRA on 20/03/18.
//  Copyright © 2018 Jogendra Singh. All rights reserved.
//

import UIKit

class AccountsTableViewController: UITableViewController {

    var accountsName: [String] = ["Facebook", "Twitter", "Instagram", "NextCloud", "Pinterest", "Flickr", "Dropbox", "Owncloud", "Box", "Tumblr"]
    var accountsImagesName: [String] = ["facebook-circled-icon", "twitter-icon", "instagram-icon", "nextcloud-icon", "pinterest-icon", "flickr-filled-icon", "dropbox-icon", "owncloud-icon", "box-icon", "tumblr-icon"]

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
        cell.imageView?.image = UIImage(named: accountsImagesName[indexPath.row])

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

    @objc func switchChanged(_ sender : UISwitch!){
        print("table row switch Changed \(sender.tag)")
        print("The switch is \(sender.isOn ? "ON" : "OFF")")
    }

}
