//
//  SearchedRecipesDetailsViewController.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 4/8/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import Firebase

class SearchedRecipesDetailsViewController: UIViewController {
    
    let indicator = ActivityIndicator()
    var recipeID: Int?
    var recipes: Recipe?
    var recipeTitle: String?
    var recipeImage: String?
    var sequence = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51"]
    let db = Firestore.firestore()
    
    lazy var mainView: SearchedRecipesDetails = {
        let view = SearchedRecipesDetails(frame: self.view.frame)
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
        db.collection("AppInfo").document("apiKey").addSnapshotListener { (snapshot, error) in
            if error != nil {
                Alert.showAlert(title: "Error", subtitle: error?.localizedDescription ?? "Error", leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
            } else {
                if let apiKey = snapshot?["apiKey"] as? String {
                    AF.request("https://api.spoonacular.com/recipes/\(self.recipeID ?? 0)/information?apiKey=\(apiKey)").responseJSON { (response) in
                        if response.error != nil {
                            Alert.showAlert(title: "Error", subtitle: "There is something wrong with connecting to our database, we are currently trying to work to solve this problem.", leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
                        }
                        do {
                            if let data = response.data {
                                
                                self.recipes = try JSONDecoder().decode(Recipe.self, from: data)
                                DispatchQueue.main.async {
                                    self.mainView.tableView.reloadData()
                                }
                            }
                            
                        } catch {
                            Alert.showAlert(title: "Error", subtitle: "There is something wrong with connecting to our database, we are currently trying to work to solve this problem.", leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
                        }
                        DispatchQueue.main.async {
                            self.indicator.hideIndicatorView(self.view)
                        }
                    }
                }
            }
        }
    }
}

extension SearchedRecipesDetailsViewController: SearchedRecipesDetailsDelegateAction {
    func startCookingButtonTapped() {
        let vc = StartCookingSearchedRecipesViewController()
        vc.modalPresentationStyle = .popover
        vc.recipeTitle = recipeTitle
        vc.recipeImage = recipeImage
        vc.recipeTime = "\(recipes?.readyInMinutes ?? 0) Mins"
        vc.instructionsSteps = recipes?.analyzedInstructions?[0].steps?.compactMap({($0.step ?? "Error")})
        self.present(vc, animated: true, completion: nil)
    }
}

extension SearchedRecipesDetailsViewController: BuyingIngredientsButtonDelegate {
    func buyingIngredientsButtonTapped() {
        let vc = StartBuyingSearchedRecipesViewController()
        vc.modalPresentationStyle = .popover
        vc.ingredientsName = recipes?.extendedIngredients?.compactMap({$0.name ?? "Error"})
        vc.ingredientsAmount = recipes?.extendedIngredients?.compactMap({$0.unit ?? "Error"})
        vc.ingredientsWeight = recipes?.extendedIngredients?.compactMap({$0.amount ?? 0.0})
        vc.ingredientsNumber = recipes?.extendedIngredients?.count
        self.present(vc, animated: true, completion: nil)
    }
}
