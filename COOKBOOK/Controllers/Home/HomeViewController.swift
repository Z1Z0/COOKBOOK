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
import Firebase

class HomeViewController: UIViewController {
    

    let searchController = UISearchController(searchResultsController: nil)
    let db = Firestore.firestore()
        
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
        mainView.banner.rootViewController = self
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
        preferedLargeTitle()
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchBar.searchTextField.backgroundColor = .white
        searchController.searchBar.searchTextField.textColor = .customDarkGray()
        searchController.searchBar.searchTextField.font = UIFont(name: "AvenirNext-Regular", size: 14)
        searchController.searchBar.tintColor = UIColor.CustomGreen()
        searchController.searchBar.becomeFirstResponder()
        self.navigationItem.searchController = searchController
        self.title = "Home"
        navigationController?.navigationBar.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.CustomGreen()
    }
    
    @objc func saveButtonTapped() {
        let vc = SavedRecipesViewController()
        self.show(vc, sender: nil)
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
    func recipeDetails(recipeTitle: String, recipeImage: String, recipeTime: String, recipeSummary: String, recipeInstructions: String, ingredientsNumber: String, ingredientsNumbersInt: Int, ingredientsName: [String], ingredientsWeight: [Double], ingredientsAmount: [String], instructionsNumber: String, instructionsSteps: [String], recipeID: String) {
        let vc = RecipesDetailsViewController()
        vc.recipeTitle = recipeTitle
        vc.recipeImage = recipeImage
        vc.recipeTime = recipeTime
        vc.recipeInstructions = recipeInstructions
        vc.recipeSummary = recipeSummary
        vc.ingredientsNumber = ingredientsNumber
        vc.ingredientsNumberInt = ingredientsNumbersInt
        vc.ingredientsName = ingredientsName
        vc.ingredientsWeight = ingredientsWeight
        vc.ingredientsAmount = ingredientsAmount
        vc.instructionsNumber = instructionsNumber
        vc.instructionsSteps = instructionsSteps
        vc.recipeID = recipeID
        self.show(vc, sender: nil)
    }
}

extension HomeViewController: PopularRecipesSelectActionDelegate {
    func popularRecipes(_ view: HomeView, recipeTitle: String, recipeImage: String, recipeTime: String, recipeSummary: String, recipeInstructions: String, ingredientsNumber: String, ingredientsNumbersInt: Int, ingredientsName: [String], ingredientsWeight: [Double], ingredientsAmount: [String], instructionsNumber: String, instructionsSteps: [String], recipeID: String) {
        let vc = RecipesDetailsViewController()
        vc.recipeTitle = recipeTitle
        vc.recipeImage = recipeImage
        vc.recipeTime = recipeTime
        vc.recipeSummary = recipeSummary
        vc.recipeInstructions = recipeInstructions
        vc.ingredientsNumber = ingredientsNumber
        vc.ingredientsNumberInt = ingredientsNumbersInt
        vc.ingredientsName = ingredientsName
        vc.ingredientsWeight = ingredientsWeight
        vc.ingredientsAmount = ingredientsAmount
        vc.ingredientsNumber = ingredientsNumber
        vc.instructionsSteps = instructionsSteps
        vc.recipeID = recipeID
        self.show(vc, sender: nil)
    }
}
