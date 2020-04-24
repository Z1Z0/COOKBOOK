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
        view.searchByIngredientsDelegate = self
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
            
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                let vc = SignInViewController()
                self.show(vc, sender: nil)
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

extension SideMenuTableViewController: GoToSearchByIngredientsDelegate {
    
    func GoToSearchByIngredients() {
        let vc = SearchByIngredientsViewController()
        self.show(vc, sender: nil)
    }
    
    
}
