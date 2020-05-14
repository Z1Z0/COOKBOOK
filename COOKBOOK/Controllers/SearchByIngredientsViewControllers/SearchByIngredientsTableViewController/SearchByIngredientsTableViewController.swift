//
//  SearchByIngredientsTableViewController.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 4/22/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit
import Alamofire

class SearchByIngredientsTableViewController: UIViewController {
    
    var ingredientsString: String?
    let indicator = ActivityIndicator()
    var recipes: [SearchWithIngredient]?
    
    lazy var mainView: SearchByIngredientsTableView = {
        let view = SearchByIngredientsTableView(frame: self.view.frame)
        view.backgroundColor = .white
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
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Recipes"
        preferedLargeTitle()
        setupNavigation()
    }
    

    func fetchData() {

        indicator.setupIndicatorView(self.view, containerColor: .customDarkGray(), indicatorColor: .white)
        AF.request("https://api.spoonacular.com/recipes/findByIngredients?ingredients=\(ingredientsString ?? "Error")&number=5&apiKey=8f39671a836440e38af6f6dbd8507b1c").responseJSON { (response) in
            if let error = response.error {
                print(error.localizedDescription)
            }
            do {
                if let data = response.data {
                    self.recipes = try JSONDecoder().decode([SearchWithIngredient].self, from: data)
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

extension SearchByIngredientsTableViewController: SearchDelegate {
    
    func searchRecipeDelegate(recipeID: Int, recipeTitle: String, recipeImage: String) {
        let vc = SearchByIngredientsDetailsViewController()
        vc.recipeID = recipeID
        vc.recipeTitle = recipeTitle
        vc.recipeImage = recipeImage
        self.show(vc, sender: nil)
    }
    
}
