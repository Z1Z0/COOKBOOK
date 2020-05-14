//
//  RecipesTableViewDetails.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 3/9/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import Kingfisher
import Firebase

protocol RecipesTVDetailsSelectActionDelegate: class {
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

protocol PassingFavouriteRecipesDelegate: class {
    func passingFavouriteRecipes(id: String)
}

class RecipesTableViewDetailsView: UIView {
    
    let indicator = ActivityIndicator()
    var recipesTableVC = RecipesTableViewDetails()
    let db = Firestore.firestore()
//    weak var delegate: PassingFavouriteRecipesDelegate?
    
    weak var recipesTVDetailsSelectActionDelegate: RecipesTVDetailsSelectActionDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var foodTableView: UITableView = {
        let foodTableView = UITableView()
        foodTableView.translatesAutoresizingMaskIntoConstraints = false
        foodTableView.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1)
        foodTableView.delegate = self
        foodTableView.dataSource = self
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
            foodTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            foodTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            foodTableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func addSubview() {
        addSubview(foodTableView)
    }
    
    func layoutUI() {
        addSubview()
        setupFoodTableView()
    }

}

extension RecipesTableViewDetailsView: UITableViewDelegate, UITableViewDataSource, FavouriteActionDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesTableVC.recipesDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        let newURL = URL(string: recipesTableVC.recipesDetails[indexPath.row].image ?? "Error")
        let processor = DownsamplingImageProcessor(size: cell.foodImage.bounds.size)
        cell.foodImage.kf.indicatorType = .activity
        cell.foodImage.kf.setImage(with: newURL, placeholder: UIImage(named: "placeholderImage"), options: [.processor(processor), .scaleFactor(UIScreen.main.scale), .transition(.fade(1)), .cacheOriginalImage])
        cell.foodTitle.text = recipesTableVC.recipesDetails[indexPath.row].title
        
        if let readyInMin = recipesTableVC.recipesDetails[indexPath.row].readyInMinutes {
            cell.cookingTimeInfoLabel.text = "\(readyInMin) Minutes"
        }
        
        if let pricePerServing = recipesTableVC.recipesDetails[indexPath.row].pricePerServing {
            cell.priceInfoLabel.text = "$" + String(format: "%.2f", pricePerServing / 100)
        }
        
        if let serving = recipesTableVC.recipesDetails[indexPath.row].servings {
            cell.servesInfoLabel.text = "\(serving)"
        }
        
        if recipesTableVC.recipesDetails[indexPath.row].checked == true {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recipesTVDetailsSelectActionDelegate?.recipeDetails(
            recipeTitle: recipesTableVC.recipesDetails[indexPath.row].title ?? "Error",
            recipeImage: recipesTableVC.recipesDetails[indexPath.row].image ?? "Error",
            recipeTime: "\(recipesTableVC.recipesDetails[indexPath.row].readyInMinutes ?? 0) Min",
            recipeInstructions: recipesTableVC.recipesDetails[indexPath.row].instructions ?? "Error",
            ingredientsNumber: "\(recipesTableVC.recipesDetails[indexPath.row].extendedIngredients?.count ?? 0)",
            ingredientsNumbersInt: recipesTableVC.recipesDetails[indexPath.row].extendedIngredients?.count ?? 0,
            ingredientsName: (recipesTableVC.recipesDetails[indexPath.row].extendedIngredients?.compactMap({$0.name}) ?? ["Error"]),
            ingredientsWeight: recipesTableVC.recipesDetails[indexPath.row].extendedIngredients?.map({($0.amount ?? 0.0)}) ?? [0.0],
            ingredientsAmount: recipesTableVC.recipesDetails[indexPath.row].extendedIngredients?.map({($0.unit ?? "Error")}) ?? ["Error"],
            instructionsNumber: "\(recipesTableVC.recipesDetails[indexPath.row].analyzedInstructions?.count ?? 0)",
            instructionsSteps: recipesTableVC.recipesDetails[indexPath.row].analyzedInstructions?[0].steps?.map({$0.step ?? "Error"}) ?? ["Error"],
            recipeID: "\(recipesTableVC.recipesDetails[indexPath.row].id ?? 0)"
        )
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func favouriteButtonTapped(_ tag: Int) {
        recipesTableVC.recipesDetails[tag].checked = !(recipesTableVC.recipesDetails[tag].checked ?? false)
        let recipeID = "\(recipesTableVC.recipesDetails[tag].id ?? 0)"
        let uid = Auth.auth().currentUser!.uid
        let data = [
            "FavRecipes": recipeID
        ]
        
        switch recipesTableVC.recipesDetails[tag].checked {
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
    }
    
}
