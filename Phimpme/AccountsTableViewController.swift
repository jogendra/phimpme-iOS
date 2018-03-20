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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return accountsName.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "accountsCell", for: indexPath)
        cell.textLabel?.text = accountsName[indexPath.row]
        cell.imageView?.image = UIImage(named: accountsImagesName[indexPath.row])

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }

}
