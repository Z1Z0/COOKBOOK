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
        mainView.recipesTableVC = self
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
        self.title = categoryTitle
    }
    
    func fetchData(_ category: String) {
        indicator.setupIndicatorView(view, containerColor: .customDarkGray(), indicatorColor: .white)
        let urlString = "https://api.spoonacular.com/recipes/random?number=25&apiKey=db696760ce1043b08fc01d61d1ed0d35&tags=\(category)"
        print("urlString:", urlString)
        print()
        AF.request(urlString).responseJSON { (response) in
            if let error = response.error {
                print(error)
            }
            do {
                if let data = response.data {
                    print("received response data")
                    print()
                    self.recipes = try JSONDecoder().decode(Recipes.self, from: data)
                    print("self.recipes:", self.recipes)
                    print()
                    self.recipesDetails = self.recipes?.recipes ?? []
                    print("self.recipesDetails count:", self.recipesDetails.count)
                    print()
                    print("self.recipesDetails:", self.recipesDetails)
                    print()
                    DispatchQueue.main.async {
                        print("calling self.mainView.foodTableView.reloadData()")
                        print()
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
