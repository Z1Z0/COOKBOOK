//
//  RecipesDetailsViewController.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 3/14/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import Firebase

class RecipesDetailsViewController: UIViewController {
    
    var recipeTitle: String?
    var recipeImage: String?
    var recipeTime: String?
    var recipeInstructions: String?
    var recipeSummary: String?
    var ingredientsNumber: String?
    var ingredientsNumberInt: Int?
    var ingredientsName: [String] = []
    var ingredientsWeight: [Double]?
    var ingredientsAmount: [String]?
    var instructionsNumber: String?
    var instructionsSteps: [String]?
    var recipeID: String?
    var sequence = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51"]
    
    var similarRecipes = [SimilarRecipesModel]()
    var bulkRecipes = [Recipe]()
    let db = Firestore.firestore()

    lazy var mainView: RecipesDetailsView = {
        let view = RecipesDetailsView(frame: self.view.frame)
        view.backgroundColor = .white
        view.transferData = self
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
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Recipe Details"
        preferedLargeTitle()
        
        setupNavigation()
    }
    
    func fetchData() {
        db.collection("AppInfo").document("apiKey").addSnapshotListener { (snapshot, error) in
            if let apiKey = snapshot?["apiKey"] as? String {
                AF.request("https://api.spoonacular.com/recipes/\(self.recipeID ?? "")/similar?apiKey=\(apiKey)&number=10").responseJSON { (response) in
                    if response.error != nil {
                        Alert.showAlert(title: "Error", subtitle: "There is something wrong with connecting to our database, we are currently trying to work to solve this problem.", leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
                    } else {
                        do {
                            
                            if let data = response.data {
                                self.similarRecipes = try JSONDecoder().decode([SimilarRecipesModel].self, from: data)
                                let ids = self.similarRecipes.compactMap({$0.id ?? 0})
                                let stringArrayCleaned = ids.description.replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: " ", with: "")
                                AF.request("https://api.spoonacular.com/recipes/informationBulk?ids=\(stringArrayCleaned)&apiKey=\(apiKey)").responseJSON { (response) in
                                    if response.error != nil {
                                        Alert.showAlert(title: "Error", subtitle: "There is something wrong with connecting to our database, we are currently trying to work to solve this problem.", leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
                                    } else {
                                        do {
                                            if let data = response.data {
                                                self.bulkRecipes = try JSONDecoder().decode([Recipe].self, from: data)
                                            }
                                        }
                                        catch {
                                            Alert.showAlert(title: "Error", subtitle: "There is something wrong with connecting to our database, we are currently trying to work to solve this problem.", leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
                                        }
                                    }
                                }
                            }
                        }
                        catch {
                            Alert.showAlert(title: "Error", subtitle: "There is something wrong with connecting to our database, we are currently trying to work to solve this problem.", leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
                        }
                    }
                }
            }
        }
    }

}

extension RecipesDetailsViewController: RecipesDetailsDelegateAction {
    
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

extension RecipesDetailsViewController: BuyingIngredientsButtonDelegate {
    
    func buyingIngredientsButtonTapped() {
        let vc = StartBuyingViewController()
        vc.modalPresentationStyle = .popover
        vc.ingredientsName = ingredientsName
        vc.ingredientsWeight = ingredientsWeight
        vc.ingredientsAmount = ingredientsAmount
        vc.ingredientsNumber = ingredientsNumberInt
        self.present(vc, animated: true, completion: nil)
    }
    
}

extension RecipesDetailsViewController: TransferSilimarDataDelegate {
    func transferData(for indexPath: Int) {
        let vc = SimilarRecipesViewController()
        vc.recipeTitle = bulkRecipes[indexPath].title
        vc.recipeImage = bulkRecipes[indexPath].image
        vc.recipeSummary = bulkRecipes[indexPath].summary
        vc.recipeDescription = bulkRecipes[indexPath].instructions
        vc.recipeIngredients = bulkRecipes[indexPath].extendedIngredients?.compactMap({$0.name})
        vc.ingredientsWeight = bulkRecipes[indexPath].extendedIngredients?.compactMap({$0.amount})
        vc.ingredientsUnit = bulkRecipes[indexPath].extendedIngredients?.compactMap({$0.unit})
        
        if let preparingTime = bulkRecipes[indexPath].readyInMinutes {
            vc.recipeTime = "\(preparingTime) Min"
        }
        
        if bulkRecipes.count > 0 {
            if bulkRecipes[indexPath].analyzedInstructions?.count ?? 0 > 0 {
                if bulkRecipes[indexPath].analyzedInstructions?[0].steps?.count ?? 0 > 0 {
                    vc.instructionsSteps = bulkRecipes[indexPath].analyzedInstructions?[0].steps?.compactMap({$0.step ?? "Error"}) ?? ["Error"]
                }
            }
        }
        
        vc.ingredientsNumberInt = bulkRecipes[indexPath].extendedIngredients?.count
        self.show(vc, sender: nil)
    }
}
