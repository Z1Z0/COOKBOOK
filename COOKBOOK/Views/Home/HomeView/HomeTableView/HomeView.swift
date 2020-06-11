//
//  SignupView.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 2/19/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import Kingfisher
import Firebase

protocol HomeViewDidSelectActionDelegate: class {
    func homeView(
        _ view: HomeView,
        didSelectCategoryWithTitle title: String,
        VCTitle: String
    )
}

protocol PopularRecipesSelectActionDelegate: class {
    func popularRecipes(
        _ view: HomeView,
        recipeTitle: String,
        recipeImage: String,
        recipeTime: String,
        recipeInstructions: String,
        ingredientsNumber: String,
        ingredientsNumbersInt: Int,
        ingredientsName: [String],
        ingredientsWeight: [Double],
        ingredientsAmount: [String],
        instructionsNumber: String,
        instructionsSteps: [String],
        recipeID: String
    )
}

protocol RecipesDetailsSelectActionDelegate: class {
    func recipeDetails(
        recipeTitle: String,
        recipeImage: String,
        recipeTime: String,
        recipeInstructions: String,
        ingredientsNumber: String,
        ingredientsNumbersInt: Int,
        ingredientsName: [String],
        ingredientsWeight: [Double],
        ingredientsAmount: [String],
        instructionsNumber: String,
        instructionsSteps: [String],
        recipeID: String
    )
}

class HomeView: UIView {
    
    var recipes: Recipes?
    var recipesDetails = [Recipe]()
    let indicator = ActivityIndicator()
    
    weak var homeViewDidSelectActionDelegate: HomeViewDidSelectActionDelegate?
    weak var recipeDetailsViewSelectActionDelegate: RecipesDetailsSelectActionDelegate?
    weak var popularRecipesDidselectActionDelegate: PopularRecipesSelectActionDelegate?
    let db = Firestore.firestore()
    
    override init( frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var foodTableView: UITableView = {
        let foodTableView = UITableView()
        foodTableView.translatesAutoresizingMaskIntoConstraints = false
        foodTableView.backgroundColor = .customVeryLightGray()
        foodTableView.delegate = self
        foodTableView.dataSource = self
        foodTableView.register(CategoriesTableViewCellCollectionViewCell.self, forCellReuseIdentifier: "CategoriesTableViewCellCollectionViewCell")
        foodTableView.register(PopularRecipesTableViewCellCollectionViewCell.self, forCellReuseIdentifier: "PopularRecipesTableViewCellCollectionViewCell")
        foodTableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
        foodTableView.rowHeight = UITableView.automaticDimension
        foodTableView.estimatedRowHeight = 100
        foodTableView.showsVerticalScrollIndicator = false
        foodTableView.separatorStyle = .none
        return foodTableView
    }()
    
    func setupFoodTableView() {
        
        NSLayoutConstraint.activate([
            foodTableView.topAnchor.constraint(equalTo: topAnchor),
            foodTableView.bottomAnchor.constraint(equalTo: banner.topAnchor, constant: -16),
            foodTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            foodTableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    lazy var banner: GADBannerView = {
        var banner = GADBannerView()
        banner = GADBannerView(adSize: kGADAdSizeBanner)
        banner.adUnitID = "ca-app-pub-3727927641788977/2917288980"
        banner.load(GADRequest())
        banner.translatesAutoresizingMaskIntoConstraints = false
        return banner
    }()
    
    func setupBannerConstraints() {
        
        NSLayoutConstraint.activate([
            banner.centerXAnchor.constraint(equalTo: centerXAnchor),
            banner.heightAnchor.constraint(equalToConstant: 50),
            banner.widthAnchor.constraint(equalToConstant: 350),
            banner.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    func addSubview() {
        
        addSubview(foodTableView)
        addSubview(banner)
    }
    
    func layoutUI() {
        indicator.setupIndicatorView(self, containerColor: .customDarkGray(), indicatorColor: .white)
        addSubview()
        
        setupFoodTableView()
        setupBannerConstraints()
        DispatchQueue.main.async {
            self.fetchData()
        }
        
    }
    
    func fetchData() {
        db.collection("AppInfo").document("apiKey").addSnapshotListener { (snapshot, error) in
            if error != nil {
                Alert.showAlert(title: "Error", subtitle: "Check your internet connection", leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
            } else {
                if let apiKey = snapshot?["apiKey"] as? String {
                    AF.request("https://api.spoonacular.com/recipes/random?apiKey=\(apiKey)&number=25").responseJSON { (response) in
                        if error != nil {
                            Alert.showAlert(title: "Error", subtitle: "Check your internet connection", leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
                        }
                        do {
                            if let data = response.data {
                                self.recipes = try JSONDecoder().decode(Recipes.self, from: data)
                                self.recipesDetails = self.recipes?.recipes ?? []
                                DispatchQueue.main.async {
                                    self.foodTableView.reloadData()
                                }
                            }
                            
                        } catch {
                            Alert.showAlert(title: "Error", subtitle: "Check your internet connection", leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
                        }
                        self.indicator.hideIndicatorView(self)
                    }
                }
            }
        }
    }
    
}

extension HomeView: UITableViewDelegate, UITableViewDataSource, FavouriteActionDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else {
            return recipesDetails.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTableViewCellCollectionViewCell", for: indexPath) as! CategoriesTableViewCellCollectionViewCell
            cell.recipesDidselectActionDelegate = self
            cell.collectionView.reloadData()
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PopularRecipesTableViewCellCollectionViewCell", for: indexPath) as! PopularRecipesTableViewCellCollectionViewCell
            cell.popularRecipesDidselectActionDelegate = self
            cell.collectionView.reloadData()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
            let url = URL(string: recipesDetails[indexPath.row].image ?? "Error")
            cell.foodImage.kf.setImage(with: url)
            cell.foodTitle.text = recipesDetails[indexPath.row].title
            
            if let readyInMin = recipesDetails[indexPath.row].readyInMinutes {
                cell.cookingTimeInfoLabel.text = "\(readyInMin) Minutes"
            }
            
            if let pricePerServing = recipesDetails[indexPath.row].pricePerServing {
                cell.priceInfoLabel.text = "$" + String(format: "%.2f", pricePerServing / 100)
            }
            
            if let serving = recipesDetails[indexPath.row].servings {
                cell.servesInfoLabel.text = "\(serving)"
            }
            cell.homeView = self
            if recipesDetails[indexPath.row].checked == true {
                let configrations = UIImage.SymbolConfiguration(pointSize: 24)
                cell.favouriteButton.setImage(UIImage(systemName: "heart.fill", withConfiguration: configrations), for: .normal)
                cell.favouriteButton.tintColor = .CustomGreen()
                cell.favouriteButton.backgroundColor = .clear
                cell.favouriteButton.isSelected = false

            } else {
                let configrations = UIImage.SymbolConfiguration(pointSize: 24)
                cell.favouriteButton.setImage(UIImage(systemName: "heart", withConfiguration: configrations), for: .normal)
                cell.favouriteButton.tintColor = .CustomGreen()
                cell.favouriteButton.backgroundColor = .clear
                cell.favouriteButton.isSelected = true
            }
            
            cell.delegate = self
            cell.favouriteButton.tag = indexPath.row
            return cell
        }
        
    }
    
    func favouriteButtonTapped(_ tag: Int) {
        if Auth.auth().currentUser?.uid != nil {
            recipesDetails[tag].checked = !(recipesDetails[tag].checked ?? false)
            let recipeID = "\(recipesDetails[tag].id ?? 0)"
            let uid = Auth.auth().currentUser!.uid
            let data = [
                "FavRecipes": recipeID
            ]
            
            switch recipesDetails[tag].checked {
            case true:
                db.collection("Users").document(uid).collection("FavouriteRecipes").document(recipeID).setData(data)
                DispatchQueue.main.async {
                    self.foodTableView.reloadData()
                }
            case false:
                db.collection("Users").document(uid).collection("FavouriteRecipes").document(recipeID).delete()
                DispatchQueue.main.async {
                    self.foodTableView.reloadData()
                }
            default:
                db.collection("Users").document(uid).collection("FavouriteRecipes").document(recipeID).setData(data)
                DispatchQueue.main.async {
                    self.foodTableView.reloadData()
                }
            }
        } else {
            Alert.showAlert(title: "Error", subtitle: "Please login to save your favorite recipes", leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            recipeDetailsViewSelectActionDelegate?.recipeDetails(
                recipeTitle: recipesDetails[indexPath.row].title ?? "Error",
                recipeImage: recipesDetails[indexPath.row].image ?? "Error",
                recipeTime: "\(recipesDetails[indexPath.row].readyInMinutes ?? 0) Min",
                recipeInstructions: recipesDetails[indexPath.row].instructions ?? "Error",
                ingredientsNumber: "\(recipesDetails[indexPath.row].extendedIngredients?.count ?? 5)",
                ingredientsNumbersInt: recipesDetails[indexPath.row].extendedIngredients?.count ?? 0,
                ingredientsName: (recipesDetails[indexPath.row].extendedIngredients?.map({($0.name ?? "Error")}) ?? ["Error"]),
                ingredientsWeight: recipesDetails[indexPath.row].extendedIngredients?.map({($0.amount ?? 0.0)}) ?? [0.0],
                ingredientsAmount: recipesDetails[indexPath.row].extendedIngredients?.map({($0.unit ?? "Error")}) ?? ["Error"],
                instructionsNumber: "\(recipesDetails[indexPath.row].analyzedInstructions?.count ?? 5)",
                instructionsSteps: (recipesDetails[indexPath.row].analyzedInstructions?[0].steps?.map({($0.step ?? "Error")}) ?? ["Error"]),
                recipeID: "\(recipesDetails[indexPath.row].id ?? 0)"
            )
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 2 {
            return "Random recipes"
        } else {
            return ""
        }
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = .customVeryLightGray()
        (view as! UITableViewHeaderFooterView).textLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        (view as! UITableViewHeaderFooterView).textLabel?.textColor = .customDarkGray()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 140
        } else if indexPath.section == 1 {
            return 200
        } else {
            return UITableView.automaticDimension
        }
    }
}

extension HomeView: RecipesDidselectActionDelegate {
    func categoriesTableViewCell(_ cell: UICollectionView, didSelectTitle title: String, ViewControllerTitle VCTitle: String) {
        homeViewDidSelectActionDelegate?.homeView(self, didSelectCategoryWithTitle: title, VCTitle: VCTitle)
    }
}

extension HomeView: PopularRecipesDidselectActionDelegate {
    func categoriesTableViewCell(_ cell: UICollectionView, didSelectTitle title: String, image: String, recipeTime: String, instructions: String, ingredientsNumber: String, ingredientsNumbersInt: Int, ingredientsName: [String], ingredientsWeight: [Double], ingredientsAmount: [String], instructionsNumber: String, instructionsSteps: [String], recipeID: String) {
        
        popularRecipesDidselectActionDelegate?.popularRecipes(
            self,
            recipeTitle: title,
            recipeImage: image,
            recipeTime: recipeTime,
            recipeInstructions: instructions,
            ingredientsNumber: ingredientsNumber,
            ingredientsNumbersInt: ingredientsNumbersInt,
            ingredientsName: ingredientsName,
            ingredientsWeight: ingredientsWeight,
            ingredientsAmount: ingredientsAmount,
            instructionsNumber: instructionsNumber,
            instructionsSteps: instructionsSteps,
            recipeID: recipeID
        )
    }

}
