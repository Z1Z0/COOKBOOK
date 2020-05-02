//
//  SearchByIngredientsDetailsViewController.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 4/24/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit
import Alamofire

class SearchByIngredientsDetailsViewController: UIViewController {

    let indicator = ActivityIndicator()
    var recipeID: Int?
    var recipes: Recipe?
    var recipeTitle: String?
    var recipeImage: String?
    var sequence = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41"]
    
    lazy var mainView: SearchByIngredientsDetailsView = {
        let view = SearchByIngredientsDetailsView(frame: self.view.frame)
        view.vc = self
        view.backgroundColor = .white
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
        self.title = "Recipe Details"
        preferedLargeTitle()
    }
    
    func fetchData() {
                
        indicator.setupIndicatorView(self.view, containerColor: .customDarkGray(), indicatorColor: .white)
        AF.request("https://api.spoonacular.com/recipes/\(recipeID ?? 0)/information?apiKey=8f39671a836440e38af6f6dbd8507b1c").responseJSON { (response) in
            if let error = response.error {
                print(error.localizedDescription)
            }
            do {
                if let data = response.data {
                    
                    self.recipes = try JSONDecoder().decode(Recipe.self, from: data)
                    DispatchQueue.main.async {
                        self.mainView.tableView.reloadData()
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

extension SearchByIngredientsDetailsViewController: SearchedRecipesDetailsDelegateAction {
    func startCookingButtonTapped() {
        let vc = StartCookingByIngredientsViewController()
        vc.modalPresentationStyle = .popover
        vc.recipeTitle = recipeTitle
        vc.recipeImage = recipeImage
        vc.recipeTime = "\(recipes?.readyInMinutes ?? 0) Mins"
        vc.instructionsSteps = recipes?.analyzedInstructions?[0].steps?.map({($0.step ?? "Error")})
        self.present(vc, animated: true, completion: nil)
    }
}

extension SearchByIngredientsDetailsViewController: BuyingIngredientsButtonDelegate {
    func buyingIngredientsButtonTapped() {
        let vc = StartBuyingByIngredientsViewController()
        vc.modalPresentationStyle = .popover
        vc.ingredientsName = recipes?.extendedIngredients?.map({$0.name ?? "Error"})
        vc.ingredientsAmount = recipes?.extendedIngredients?.map({$0.unit ?? "Error"})
        vc.ingredientsWeight = recipes?.extendedIngredients?.map({$0.amount ?? 0.0})
        vc.ingredientsNumber = recipes?.extendedIngredients?.count
        self.present(vc, animated: true, completion: nil)
    }
}