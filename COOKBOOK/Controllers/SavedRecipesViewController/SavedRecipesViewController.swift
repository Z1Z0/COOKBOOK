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
        
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Favourite recipes"
        preferedLargeTitle()
        getFirebaseDocuments()
    }
    
    func fetchData() {
        
        AF.request("https://api.spoonacular.com/recipes/informationBulk?ids=\(recipesIDs ?? "0")&apiKey=bbb927604e1d4f0195e6e22a92fc9d5f").responseJSON { (response) in
            if let error = response.error {
                print(error.localizedDescription)
            }
            do {
                if let data = response.data {
                    
                    self.recipes = try JSONDecoder().decode([Recipe].self, from: data)
                    DispatchQueue.main.async {
                        self.mainView.recipesTableView.reloadData()
                    }
                    
                }
                
            } catch {
                print(error.localizedDescription)
            }
            
        }
    }
    
    func getFirebaseDocuments() {
        indicator.setupIndicatorView(view, containerColor: .customDarkGray(), indicatorColor: .white)
        let uid = Auth.auth().currentUser!.uid
        AF.request("https://firestore.googleapis.com/v1/projects/cookbook-5a8f7/databases/(default)/documents/Users/\(uid)/FavouriteRecipes").responseJSON { (response) in
            if let error = response.error {
                print(error.localizedDescription)
            }
            do {
                if let data = response.data {
                    self.favRecipes = try JSONDecoder().decode(FavouriteRecipes.self, from: data)
                    self.document = self.favRecipes?.documents ?? []
                    let recipesID = self.document.map({($0.fields?.favRecipes?.stringValue)!}).joined(separator: ",")
                    self.recipesIDs = recipesID
                    self.fetchData()
                    self.indicator.hideIndicatorView(self.view)
                }
                
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }
    
    
    
}
