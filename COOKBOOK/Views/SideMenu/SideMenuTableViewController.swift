//
//  SideMenuTableViewController.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 2/26/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit
import SideMenu

class SideMenuTableViewController: UITableViewController {
    
    let viewControllers = ["Controller One", "Controller Two"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SideMenuTableViewCell.self, forCellReuseIdentifier: "SideMenuTableViewCell")
        tableView.reloadData()
        tableView.backgroundColor = .CustomGreen()
        tableView.separatorStyle = .none
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewControllers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell", for: indexPath) as! SideMenuTableViewCell
        cell.viewTitle.text = viewControllers[indexPath.row]

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.show(HomeViewController(), sender: nil)
        } else {
            self.show(HomeViewController(), sender: nil)
        }
    }

}
