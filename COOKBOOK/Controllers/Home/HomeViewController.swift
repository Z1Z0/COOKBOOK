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

class HomeViewController: UIViewController {

    let searchController = UISearchController(searchResultsController: nil)
        
    lazy var mainView: HomeView = {
        let view = HomeView(frame: self.view.frame)
        view.homeViewDidSelectActionDelegate = self
        view.recipeDetailsViewSelectActionDelegate = self
        view.popularRecipesDidselectActionDelegate = self
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
        .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        setNeedsStatusBarAppearanceUpdate()
        setupNavigationWithLargeTitle()
        setupNavigation()
        setupSideMenu()
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
        searchController.searchBar.becomeFirstResponder()
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
    }
    
    @objc func saveButtonTapped() {
        print("OK")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let vc = SearchViewController()
        if let searchTxt = searchBar.text {
            vc.searchText = searchTxt
        }
        self.show(vc, sender: nil)
    }
}

extension HomeViewController: HomeViewDidSelectActionDelegate {
    func homeView(_ view: HomeView, didSelectCategoryWithTitle title: String, VCTitle: String) {
        let vc = RecipesTableViewDetails()
        vc.categoryTitle = title
        vc.VCTitle = VCTitle
        self.show(vc, sender: nil)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
    
    
}

extension HomeViewController: RecipesDetailsSelectActionDelegate {
    func recipeDetails(recipeTitle: String, recipeImage: String, recipeTime: String, recipeInstructions: String, ingredientsNumber: String, ingredientsNumbersInt: Int, ingredientsName: [String], ingredientsWeight: [Double], ingredientsAmount: [String], instructionsNumber: String, instructionsSteps: [String]) {
        
        let vc = RecipesDetailsViewController()
        vc.recipeTitle = recipeTitle
        vc.recipeImage = recipeImage
        vc.recipeTime = recipeTime
        vc.recipeInstructions = recipeInstructions
        vc.ingredientsNumber = ingredientsNumber
        vc.ingredientsNumberInt = ingredientsNumbersInt
        vc.ingredientsName = ingredientsName
        vc.ingredientsWeight = ingredientsWeight
        vc.ingredientsAmount = ingredientsAmount
        vc.instructionsNumber = instructionsNumber
        vc.instructionsSteps = instructionsSteps
        self.show(vc, sender: nil)
        
    }
}

extension HomeViewController: PopularRecipesSelectActionDelegate {
    func popularRecipes(_ view: HomeView, recipeTitle: String, recipeImage: String, recipeTime: String, recipeInstructions: String, ingredientsNumber: String, ingredientsNumbersInt: Int, ingredientsName: [String], ingredientsWeight: [Double],
    ingredientsAmount: [String], instructionsNumber: String, instructionsSteps: [String]) {
        
        let vc = RecipesDetailsViewController()
        vc.recipeTitle = recipeTitle
        vc.recipeImage = recipeImage
        vc.recipeTime = recipeTime
        vc.recipeInstructions = recipeInstructions
        vc.ingredientsNumber = ingredientsNumber
        vc.ingredientsNumberInt = ingredientsNumbersInt
        vc.ingredientsName = ingredientsName
        vc.ingredientsWeight = ingredientsWeight
        vc.ingredientsAmount = ingredientsAmount
        vc.ingredientsNumber = ingredientsNumber
        vc.instructionsSteps = instructionsSteps
        self.show(vc, sender: nil)
        
    }
}
