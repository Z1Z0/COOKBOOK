//
//  SimilarRecipesViewController.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 6/30/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit

class SimilarRecipesViewController: UIViewController {
    
    var recipeTitle: String?
    var recipeDescription: String?
    var recipeImage: String?
    var recipeIngredients: [String]?
    var sequence = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51"]
    var ingredientsWeight: [Double]?
    var ingredientsUnit: [String]?
    var recipeTime: String?
    var instructionsNumber: String?
    var instructionsSteps: [String]?
    var ingredientsNumberInt: Int?
    
    lazy var mainView: SimilarRecipesView = {
        let view = SimilarRecipesView(frame: self.view.frame)
        view.backgroundColor = .white
        view.similarRecipesVC = self
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
        self.title = "Similar Recipe"
        preferedLargeTitle()
    }

}

extension SimilarRecipesViewController: RecipesDetailsDelegateAction {
    
    func startCookingButtonTapped() {
        let vc = StartCookingViewController()
        vc.modalPresentationStyle = .popover
        vc.recipeTitle = recipeTitle
        vc.recipeTime = recipeTime
        vc.recipeImage = recipeImage
        vc.instructionsNumber = instructionsNumber
        vc.instructionsSteps = instructionsSteps
        self.present(vc, animated: true, completion: nil)
    }
    
}

extension SimilarRecipesViewController: BuyingIngredientsButtonDelegate {
    
    func buyingIngredientsButtonTapped() {
        let vc = StartBuyingViewController()
        vc.modalPresentationStyle = .popover
        vc.ingredientsName = recipeIngredients
        vc.ingredientsWeight = ingredientsWeight
        vc.ingredientsAmount = ingredientsUnit
        vc.ingredientsNumber = ingredientsNumberInt
        self.present(vc, animated: true, completion: nil)
    }
    
}
