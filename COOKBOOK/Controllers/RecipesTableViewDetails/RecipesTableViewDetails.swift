//
//  RecipesTableViewDetails.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 3/9/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit
import Alamofire

class RecipesTableViewDetails: UIViewController {
    
    
    var categoryTitle: String?
    var recipes: Recipes?
    var recipesDetails = [Recipe]()
    let indicator = ActivityIndicator()
    
    lazy var mainView: RecipesTableViewDetailsView = {
        let view = RecipesTableViewDetailsView(frame: self.view.frame)
        view.backgroundColor = .white
        return view
    }()
    
    override func loadView() {
        super.loadView()
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let categoryTitle = categoryTitle {
            fetchData(categoryTitle)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
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
