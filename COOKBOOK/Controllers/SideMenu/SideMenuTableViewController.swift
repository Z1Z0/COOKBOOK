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
    
    var uid = Auth.auth().currentUser?.uid
        
    lazy var mainView: SideMenuTableView = {
        let view = SideMenuTableView(frame: self.view.frame)
        view.delegate = self
        view.backgroundColor = .CustomGreen()
        return view
    }()
    
    override func loadView() {
        super.loadView()
        mainView.vc = self
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }

}

extension SideMenuTableViewController: SideMenuDelegate {
    
    func goToSignin() {
        let vc = UINavigationController(rootViewController: SignInViewController())
        self.sideMenuViewController?.setContentViewController(vc, animated: true)
        self.sideMenuViewController!.hideMenuViewController()
    }
    
    func goToHome() {
        let vc = UINavigationController(rootViewController: HomeViewController())
        self.sideMenuViewController?.setContentViewController(vc, animated: true)
        self.sideMenuViewController!.hideMenuViewController()
    }
    
    func goToSearchByIngredients() {
        let vc = UINavigationController(rootViewController: SearchByIngredientsViewController())
        self.sideMenuViewController?.setContentViewController(vc, animated: true)
        self.sideMenuViewController!.hideMenuViewController()
    }
    
    func goToFavouriteRecipes() {
        let vc = UINavigationController(rootViewController: SavedRecipesViewController())
        self.sideMenuViewController?.setContentViewController(vc, animated: true)
        self.sideMenuViewController!.hideMenuViewController()
    }
    
    func goToAppStore() {
        if let url = URL(string: "https://apps.apple.com/app/id1516564360") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    func goToContactUs() {
        let vc = UINavigationController(rootViewController: ContactUsViewController())
        self.sideMenuViewController?.setContentViewController(vc, animated: true)
        self.sideMenuViewController!.hideMenuViewController()
    }
    
    func goToAboutUs() {
        let vc = UINavigationController(rootViewController: AboutUsViewController())
        self.sideMenuViewController?.setContentViewController(vc, animated: true)
        self.sideMenuViewController!.hideMenuViewController()
    }
    
    func logoutTapped() {
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
        let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { (action: UIAlertAction) in
            
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                let vc = UINavigationController(rootViewController: SignInViewController())
                self.sideMenuViewController?.setContentViewController(vc, animated: true)
                self.sideMenuViewController!.hideMenuViewController()
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
