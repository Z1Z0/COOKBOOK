//
//  SideMenuTableViewController.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 2/26/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit
import SideMenu
import Firebase

class SideMenuTableViewController: UITableViewController {
    
    let viewControllers = ["Controller One", "Logout"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: "UserTableViewCell")
        tableView.register(SideMenuTableViewCell.self, forCellReuseIdentifier: "SideMenuTableViewCell")
        tableView.reloadData()
        tableView.backgroundColor = .CustomGreen()
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 100
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return section == 0 ? 1 : viewControllers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
            cell.userPhoto.image = UIImage(named: "ahmed")
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell", for: indexPath) as! SideMenuTableViewCell
            cell.viewTitle.text = viewControllers[indexPath.row]
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            if indexPath.row == 1 {
                let newViewController = SplashViewController()
                
                self.dismiss(animated: true) { () -> Void in
                    //Perform segue or push some view with your code
                    UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: newViewController)
                }
                let firebaseAuth = Auth.auth()
                do {
                    try firebaseAuth.signOut()
                    print ("signing out successfully")
                    self.show(SplashViewController(), sender: nil)
                } catch let signOutError as NSError {
                    print ("Error signing out: %@", signOutError)
                    
                }
            }
        }
    }

}
