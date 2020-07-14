//
//  SavedRecipesViewController.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 4/4/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class SavedRecipesViewController: UIViewController {
    
    var recipes: [Recipe]?
    let db = Firestore.firestore()
    var favRecipes: FavouriteRecipes?
    var document = [Document]()
    var recipesIDs: String?
    let indicator = ActivityIndicator()
    
    lazy var mainView: SavedRecipesView = {
        let view = SavedRecipesView(frame: self.view.frame)
        view.recipesTVDetailsSelectActionDelegate = self
        view.backgroundColor = .white
        view.vc = self
        return view
    }()
    
    override func loadView() {
        super.loadView()
        view = mainView
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.banner.rootViewController = self
        // Do any additional setup after loading the view.
        setupSideMenu()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Favourite recipes"
        preferedLargeTitle()
        setupNavigation()
        getFirebaseDocuments()
    }
    
    func fetchData() {
        db.collection("AppInfo").document("apiKey").addSnapshotListener { (snapshot, error) in
            if error != nil {
                Alert.showAlert(title: "Sorry", subtitle: error?.localizedDescription ?? "Error", leftView: UIImageView(image: #imageLiteral(resourceName: "isInfoIcon")), style: .warning)
            } else {
                if let apiKey = snapshot?["apiKey"] as? String {
                    AF.request("https://api.spoonacular.com/recipes/informationBulk?ids=\(self.recipesIDs ?? "0")&apiKey=\(apiKey)").responseJSON { (response) in
                        if response.error != nil {
                            Alert.showAlert(title: "Error", subtitle: "There is something wrong with connecting to our database, we are currently trying to work to solve this problem.", leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
                            self.indicator.hideIndicatorView(self.view)
                        }
                        do {
                            if let data = response.data {
                                
                                self.recipes = try JSONDecoder().decode([Recipe].self, from: data)
                                DispatchQueue.main.async {
                                    self.mainView.recipesTableView.reloadData()
                                }
                                self.indicator.hideIndicatorView(self.view)
                            }
                        } catch {
                            Alert.showAlert(title: "Error", subtitle: "You should save at least one recipe to show it to you.", leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
                            self.indicator.hideIndicatorView(self.view)
                        }
                    }
                }
            }
        }
    }
    
    func getFirebaseDocuments() {
        
        if let uid = Auth.auth().currentUser?.uid {
            indicator.setupIndicatorView(view, containerColor: .customDarkGray(), indicatorColor: .white)
            AF.request("https://firestore.googleapis.com/v1/projects/cookbook-5a8f7/databases/(default)/documents/Users/\(uid)/FavouriteRecipes").responseJSON { (response) in
                if response.error != nil {
                    Alert.showAlert(title: "Error", subtitle: "There is something wrong with connecting to our database, we are currently trying to work to solve this problem.", leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
                    self.indicator.hideIndicatorView(self.view)
                }
                do {
                    if let data = response.data {
                        self.favRecipes = try JSONDecoder().decode(FavouriteRecipes.self, from: data)
                        self.document = self.favRecipes?.documents ?? []
                        let recipesID = self.document.compactMap({($0.fields?.favRecipes?.stringValue ?? "Error")}).joined(separator: ",")
                        self.recipesIDs = recipesID
                        self.fetchData()
                        self.indicator.hideIndicatorView(self.view)
                    }
                    
                } catch {
                    Alert.showAlert(title: "Error", subtitle: "There is something wrong with connecting to our database, we are currently trying to work to solve this problem.", leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
                    self.indicator.hideIndicatorView(self.view)
                }
            }
        }
    }
}

extension SavedRecipesViewController: RecipesTVDetailsSelectActionDelegate {
    func recipeDetails(recipeTitle: String, recipeImage: String, recipeTime: String, recipeInstructions: String, ingredientsNumber: String, ingredientsNumbersInt: Int, ingredientsName: [String], ingredientsWeight: [Double], ingredientsAmount: [String], instructionsNumber: String, instructionsSteps: [String], recipeID: String) {
        let vc = RecipesDetailsViewController()
        vc.recipeTitle = recipeTitle
        vc.recipeImage = recipeImage
        vc.recipeTime = recipeTime
        vc.recipeInstructions = recipeInstructions
        vc.ingredientsNumber = ingredientsNumber
        vc.ingredientsNumberInt = ingredientsNumbersInt
        vc.ingredientsName = ingredientsName
        vc.ingredientsWeight = ingredientsWeight
        vc.ingredientsAmount = ingredientsAmount
        vc.instructionsNumber = instructionsNumber
        vc.instructionsSteps = instructionsSteps
        vc.recipeID = recipeID
        self.show(vc, sender: nil)
    }
}
