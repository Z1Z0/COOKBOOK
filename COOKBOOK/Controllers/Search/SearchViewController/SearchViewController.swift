//
//  SearchViewController.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 4/7/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class SearchViewController: UIViewController {
    
    var searchText: String?
    var recipes: SearchRecipesModel?
    let indicator = ActivityIndicator()
    let db = Firestore.firestore()
        
    lazy var mainView: SearchView = {
        let view = SearchView(frame: self.view.frame)
        view.vc = self
        view.delegate = self
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
        fetchData()
        mainView.banner.rootViewController = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = searchText
        preferedLargeTitle()
        setupNavigation()
    }
    
    func fetchData() {
        
        let newRecipe = searchText?.replacingOccurrences(of: " ", with: "+")
        
        indicator.setupIndicatorView(self.view, containerColor: .customDarkGray(), indicatorColor: .white)
        db.collection("AppInfo").document("apiKey").addSnapshotListener { (snapshot, error) in
            if error != nil {
                Alert.showAlert(title: "Error", subtitle: error?.localizedDescription ?? "Error", leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
            } else {
                if let apiKey = snapshot?["apiKey"] as? String {
                    AF.request("https://api.spoonacular.com/recipes/search?apiKey=\(apiKey)&query=\(newRecipe ?? "Burger")&number=25").responseJSON { (response) in
                        if response.error != nil {
                            Alert.showAlert(title: "Error", subtitle: "There is something wrong with connecting to our database, we are currently trying to work to solve this problem.", leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
                        }
                        do {
                            if let data = response.data {
                                self.recipes = try JSONDecoder().decode(SearchRecipesModel.self, from: data)
                                DispatchQueue.main.async {
                                    self.mainView.searchTableView.reloadData()
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

extension SearchViewController: SearchDelegate {
    func searchRecipeDelegate(recipeID: Int, recipeTitle: String, recipeImage: String) {
        let vc = SearchedRecipesDetailsViewController()
        vc.recipeID = recipeID
        vc.recipeTitle = recipeTitle
        vc.recipeImage = recipeImage
        self.show(vc, sender: nil)
    }
}
