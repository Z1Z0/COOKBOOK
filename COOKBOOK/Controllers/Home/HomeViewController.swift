//
//  RecipesViewController.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 1/30/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import SideMenu

class HomeViewController: UIViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
        
    lazy var mainView: HomeView = {
        let view = HomeView(frame: self.view.frame)
        view.backgroundColor = .white
        return view
    }()
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        DispatchQueue.main.async {
//            self.searchController.searchBar.becomeFirstResponder()
//        }
        setupNavigationWithLargeTitle()
    }
    
}

extension HomeViewController: UISearchControllerDelegate, UISearchBarDelegate {
    func setupNavigationWithLargeTitle() {
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchBar.barStyle = .default
        searchController.searchBar.searchTextField.backgroundColor = .white
        searchController.searchBar.searchTextField.textColor = .customDarkGray()
        searchController.searchBar.searchTextField.font = UIFont(name: "AvenirNext-Regular", size: 14)
        searchController.searchBar.tintColor = .white
        searchController.isActive = true
        self.navigationItem.searchController = searchController
        self.title = "Home"
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "AvenirNext-Heavy", size: 36)!]
        navBarAppearance.backgroundColor = .CustomGreen()
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "star"), style: .plain, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(menuButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    @objc func saveButtonTapped() {
        print("OK")
    }
    
    @objc func menuButtonTapped() {
        let leftMenuNavigationController = SideMenuNavigationController(rootViewController: SideMenuTableViewController())
        SideMenuManager.default.leftMenuNavigationController = leftMenuNavigationController
        leftMenuNavigationController.leftSide = true
        leftMenuNavigationController.statusBarEndAlpha = 0
        leftMenuNavigationController.presentationStyle = .viewSlideOut
        leftMenuNavigationController.allowPushOfSameClassTwice = false
        leftMenuNavigationController.menuWidth = view.frame.width * (3/4)
        leftMenuNavigationController.navigationBar.isHidden = true
        leftMenuNavigationController.navigationBar.prefersLargeTitles = true
        self.present(leftMenuNavigationController, animated: true, completion: nil)
    }
    
}
