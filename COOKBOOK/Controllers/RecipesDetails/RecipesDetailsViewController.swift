//
//  RecipesDetailsViewController.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 3/14/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit

class RecipesDetailsViewController: UIViewController {
    
    var recipeTitle: String?
    var recipeImage: String?
    var recipeInstructions: String?
    
    lazy var mainView: RecipesDetailsView = {
        let view = RecipesDetailsView(frame: self.view.frame)
        view.backgroundColor = .white
        return view
    }()
    
    override func loadView() {
        super.loadView()
        mainView.recipeVC = self
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Recipe Details"
    }

}
