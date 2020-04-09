//
//  SearchViewController.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 4/7/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {
    
    var searchText: String?
    var recipes: SearchRecipesModel?
    let indicator = ActivityIndicator()
        
    lazy var mainView: SearchView = {
        let view = SearchView(frame: self.view.frame)
        view.vc = self
        view.delegate = self
        return view
    }()
    
    override func loadView() {
        super.loadView()
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        self.title = searchText
        setupNavigation()
    }
    
    func fetchData() {
        
        let newRecipe = searchText?.replacingOccurrences(of: " ", with: "+")
        
        indicator.setupIndicatorView(self.view, containerColor: .customDarkGray(), indicatorColor: .white)
        AF.request("https://api.spoonacular.com/recipes/search?apiKey=8f39671a836440e38af6f6dbd8507b1c&query=\(newRecipe ?? "Burger")&number=5").responseJSON { (response) in
            if let error = response.error {
                print(error.localizedDescription)
            }
            do {
                if let data = response.data {
                    self.recipes = try JSONDecoder().decode(SearchRecipesModel.self, from: data)
                    DispatchQueue.main.async {
                        self.mainView.searchTableView.reloadData()
                    }
                }
                
            } catch {
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                self.indicator.hideIndicatorView(self.view)
            }
        }
    }
}

extension SearchViewController: SearchDelegate {
    func searchRecipeDelegate(recipeID: Int, recipeTitle: String, recipeImage: String) {
        let vc = SearchedRecipesDetailsViewController()
        vc.recipeID = recipeID
        vc.recipeTitle = recipeTitle
        vc.recipeImage = recipeImage
        self.show(vc, sender: nil)
    }
}
