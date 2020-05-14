//
//  RecipesTableViewDetails.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 3/9/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class RecipesTableViewDetails: UIViewController {
    
    
    var categoryTitle: String?
    var VCTitle: String?
    var recipes: Recipes?
    var recipesDetails = [Recipe]()
    let indicator = ActivityIndicator()
    var recipeID: [String]?
    var recipeIDs: String?
    var recipesID: [String] = []
    let defaults = UserDefaults.standard
    
    lazy var mainView: RecipesTableViewDetailsView = {
        let view = RecipesTableViewDetailsView(frame: self.view.frame)
        view.recipesTVDetailsSelectActionDelegate = self
        view.backgroundColor = .white
        return view
    }()
    
    override func loadView() {
        super.loadView()
        mainView.recipesTableVC = self
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        defaults.set(recipesID, forKey: "array")
        print(recipesID)
        if let categoryTitle = categoryTitle {
            fetchData(categoryTitle)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        self.title = VCTitle
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.CustomGreen()]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.CustomGreen(), .font: UIFont(name: "AvenirNext-Heavy", size: 36)!]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.CustomGreen()
        setupNavigation()
    }
    
    @objc func saveButtonTapped() {
        let vc = SavedRecipesViewController()
        self.show(vc, sender: nil)
    }
    
    func fetchData(_ category: String) {
        indicator.setupIndicatorView(view, containerColor: .customDarkGray(), indicatorColor: .white)
        let urlString = "https://api.spoonacular.com/recipes/random?number=25&apiKey=8f39671a836440e38af6f6dbd8507b1c&tags=\(category)"
        print("urlString:", urlString)
        print()
        AF.request(urlString).responseJSON { (response) in
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

extension RecipesTableViewDetails: RecipesTVDetailsSelectActionDelegate {
    func recipeDetails(recipeTitle: String, recipeImage: String, recipeTime: String, recipeInstructions: String, ingredientsNumber: String, ingredientsNumbersInt: Int, ingredientsName: [String], ingredientsWeight: [Double], ingredientsAmount: [String], instructionsNumber: String, instructionsSteps: [String], recipeID: String) {
        
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
        vc.recipeID = recipeID
        self.show(vc, sender: nil)
    }
}
