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
    
    var recipes: Recipes?
    var recipesDetails = [Recipe]()
    let indicator = ActivityIndicator()
    
    let searchController = UISearchController(searchResultsController: nil)
    let leftMenuNavigationController = SideMenuNavigationController(rootViewController: SideMenuTableViewController())
        
    lazy var mainView: HomeView = {
        let view = HomeView(frame: self.view.frame)
        view.homeViewDidSelectActionDelegate = self
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
        .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        setNeedsStatusBarAppearanceUpdate()
        setupNavigationWithLargeTitle()
        setupLeftSideMenu()
        setupNavigation()
    }
    
    func setupLeftSideMenu() {
        SideMenuManager.default.leftMenuNavigationController = leftMenuNavigationController
        leftMenuNavigationController.leftSide = true
        leftMenuNavigationController.statusBarEndAlpha = 0
        leftMenuNavigationController.presentationStyle = .viewSlideOut
        leftMenuNavigationController.allowPushOfSameClassTwice = false
        leftMenuNavigationController.menuWidth = view.frame.width * (3/4)
        leftMenuNavigationController.navigationBar.isHidden = true
    }
    
}

extension HomeViewController: UISearchControllerDelegate, UISearchBarDelegate {
    func setupNavigationWithLargeTitle() {
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchBar.searchTextField.backgroundColor = .white
        searchController.searchBar.searchTextField.textColor = .customDarkGray()
        searchController.searchBar.searchTextField.font = UIFont(name: "AvenirNext-Regular", size: 14)
        searchController.searchBar.tintColor = UIColor.CustomGreen()
        self.navigationItem.searchController = searchController
        self.title = "Home"
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.CustomGreen()]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.CustomGreen(), .font: UIFont(name: "AvenirNext-Heavy", size: 36)!]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.CustomGreen()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(menuButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.CustomGreen()
    }
    
    @objc func saveButtonTapped() {
        print("OK")
    }
    
    @objc func menuButtonTapped() {
        self.present(leftMenuNavigationController, animated: true, completion: nil)
    }
    
    func fetchData(_ category: String) {
        indicator.setupIndicatorView(view, containerColor: .customDarkGray(), indicatorColor: .white)
        AF.request("https://api.spoonacular.com/recipes/random?apiKey=e8d1d8ab81044fe491a35c7d370eb5ce&number=25&tags=\(category)").responseJSON { (response) in
            if let error = response.error {
                print(error)
            }
            do {
                if let data = response.data {
                    self.recipes = try JSONDecoder().decode(Recipes.self, from: data)
                    self.recipesDetails = self.recipes?.recipes ?? []
                    DispatchQueue.main.async {
                        self.mainView.foodTableView.reloadData()
                    }
                }
                
            } catch {
                print(error)
            }
            self.indicator.hideIndicatorView(self.view)
        }
    }
    
}

extension HomeViewController: HomeViewDidSelectActionDelegate {
    
    func recipesSelectionAction(indexPath: IndexPath) {
        let vc = RecipesTableViewDetails()
//        vc.mainView.fetchData(category)
//        fetchData(category)
//        vc.mainView.foodTableView.reloadData()
        self.show(vc, sender: nil)
    }

}
