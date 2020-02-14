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
    
    var recipe: Recipe?
    var recipeDetails = [Result]()
    var recipeSearch: String?
    
    let baseURL = "https://spoonacular.com/recipeImages/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        navigationController?.isNavigationBarHidden = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}
