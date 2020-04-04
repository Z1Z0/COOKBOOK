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
    var recipeTime: String?
    var recipeInstructions: String?
    var ingredientsNumber: String?
    var ingredientsNumberInt: Int?
    var ingredientsName: [String] = []
    var instructionsNumber: String?
    var instructionsSteps: [String]?
    var sequence = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30"]
        
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

extension RecipesDetailsViewController: RecipesDetailsDelegateAction {
    
    func startCookingButtonTapped() {
        let vc = StartCookingViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.recipeTitle = recipeTitle
        vc.recipeTime = recipeTime
        vc.recipeImage = recipeImage
        vc.instructionsNumber = instructionsNumber
        vc.instructionsSteps = instructionsSteps
        self.present(vc, animated: true, completion: nil)
    }
}
