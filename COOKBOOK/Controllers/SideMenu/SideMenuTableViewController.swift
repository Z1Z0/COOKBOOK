//
//  SideMenuTableViewController.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 2/26/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit
import Firebase

class SideMenuTableViewController: UIViewController {
    
    lazy var mainView: SideMenuTableView = {
        let view = SideMenuTableView(frame: self.view.frame)
        view.delegate = self
        return view
    }()
    
    override func loadView() {
        super.loadView()
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}

extension SideMenuTableViewController: LogoutDelegate {
    
    func logoutTapped() {
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
        let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { (action: UIAlertAction) in
            let newViewController = SplashViewController()
            
            self.dismiss(animated: true) { () -> Void in
                //Perform segue or push some view with your code
                self.show(newViewController, sender: nil)
                
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
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(logoutAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    
}
