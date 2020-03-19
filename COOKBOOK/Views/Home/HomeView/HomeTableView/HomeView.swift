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

protocol HomeViewDidSelectActionDelegate: class {
    func homeView(_ view: HomeView, didSelectCategoryWithTitle title: String, VCTitle: String)
}

protocol PopularRecipesSelectActionDelegate: class {
    func popularRecipes(_ view: HomeView, recipeTitle: String, recipeImage: String, recipeInstructions: String)
}

protocol RecipesDetailsSelectActionDelegate: class {
    func recipeDetails(recipeTitle: String, recipeImage: String, recipeInstructions: String)
}

class HomeView: UIView {
    
    var recipes: Recipes?
    var recipesDetails = [Recipe]()
    let indicator = ActivityIndicator()
    
    weak var homeViewDidSelectActionDelegate: HomeViewDidSelectActionDelegate?
    weak var recipeDetailsViewSelectActionDelegate: RecipesDetailsSelectActionDelegate?
    weak var popularRecipesDidselectActionDelegate: PopularRecipesSelectActionDelegate?
    
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
            foodTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            foodTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            foodTableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func addSubview() {
        addSubview(foodTableView)
    }
    
    func layoutUI() {
        indicator.setupIndicatorView(self, containerColor: .customDarkGray(), indicatorColor: .white)
        addSubview()
        setupFoodTableView()
        DispatchQueue.main.async {
            self.fetchData()
        }
        
    }
    
    func fetchData() {
        AF.request("https://api.spoonacular.com/recipes/random?apiKey=8f39671a836440e38af6f6dbd8507b1c&number=25").responseJSON { (response) in
            if let error = response.error {
                print(error)
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
                print(error)
            }
            self.indicator.hideIndicatorView(self)
        }
    }
    
}

extension HomeView: UITableViewDelegate, UITableViewDataSource {
    
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
                cell.priceInfoLabel.text = String(format: "%.2f", pricePerServing / 100)
            }
            
            if let serving = recipesDetails[indexPath.row].servings {
                cell.servesInfoLabel.text = "\(serving)"
            }
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recipeDetailsViewSelectActionDelegate?.recipeDetails(recipeTitle: recipesDetails[indexPath.row].title ?? "Error", recipeImage: recipesDetails[indexPath.row].image ?? "Error", recipeInstructions: recipesDetails[indexPath.row].instructions ?? "Error")
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 2 {
            return "Random recipes"
        } else {
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = .white
        (view as! UITableViewHeaderFooterView).textLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        (view as! UITableViewHeaderFooterView).textLabel?.textColor = .customDarkGray()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 130
        } else if indexPath.section == 1 {
            return 180
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
    func categoriesTableViewCell(_ cell: UICollectionView, didSelectTitle title: String, image: String, instructions: String) {
        popularRecipesDidselectActionDelegate?.popularRecipes(self, recipeTitle: title, recipeImage: image, recipeInstructions: instructions)
    }
}
