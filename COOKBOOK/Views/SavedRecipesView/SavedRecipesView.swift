//
//  SavedRecipesView.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 4/4/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import Firebase

class SavedRecipesView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var vc = SavedRecipesViewController()
    weak var recipesTVDetailsSelectActionDelegate: RecipesTVDetailsSelectActionDelegate?
    weak var delegate: FavouriteActionDelegate?
    let db = Firestore.firestore()
    
    lazy var recipesTableView: UITableView = {
        let recipesTableView = UITableView()
        recipesTableView.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1)
        recipesTableView.rowHeight = UITableView.automaticDimension
        recipesTableView.estimatedRowHeight = 100
        recipesTableView.showsVerticalScrollIndicator = false
        recipesTableView.separatorStyle = .none
        recipesTableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
        recipesTableView.delegate = self
        recipesTableView.dataSource = self
        recipesTableView.translatesAutoresizingMaskIntoConstraints = false
        return recipesTableView
    }()
    
    func setupRecipesTableViewConstraints() {
        NSLayoutConstraint.activate([
            recipesTableView.topAnchor.constraint(equalTo: topAnchor),
            recipesTableView.bottomAnchor.constraint(equalTo: banner.topAnchor, constant: -16),
            recipesTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            recipesTableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    lazy var banner: GADBannerView = {
        var banner = GADBannerView()
        banner = GADBannerView(adSize: kGADAdSizeBanner)
        banner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
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
    
    func addSubviews() {
        addSubview(recipesTableView)
        addSubview(banner)
    }
    
    func layoutUI() {
        addSubviews()
        setupRecipesTableViewConstraints()
        setupBannerConstraints()
    }
    
}

extension SavedRecipesView: UITableViewDelegate, UITableViewDataSource, FavouriteActionDelegate {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vc.recipes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        let url = URL(string: vc.recipes?[indexPath.row].image ?? "Error")
        cell.foodImage.kf.setImage(with: url)
        cell.foodTitle.text = vc.recipes?[indexPath.row].title
        
        if let readyInMin = vc.recipes?[indexPath.row].readyInMinutes {
            cell.cookingTimeInfoLabel.text = "\(readyInMin) Minutes"
        }
        
        if let pricePerServing = vc.recipes?[indexPath.row].pricePerServing {
            cell.priceInfoLabel.text = "$" + String(format: "%.2f", pricePerServing / 100)
        }
        
        if let serving = vc.recipes?[indexPath.row].servings {
            cell.servesInfoLabel.text = "\(serving)"
        }
        
        let configrations = UIImage.SymbolConfiguration(pointSize: 24)
        cell.favouriteButton.setImage(UIImage(systemName: "heart.fill", withConfiguration: configrations), for: .normal)
        cell.favouriteButton.tintColor = .CustomGreen()
        cell.delegate = self
        cell.favouriteButton.tag = indexPath.row
        cell.favouriteButton.addTarget(self, action: #selector(favoriteButtonTapped(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc func favoriteButtonTapped(_ sender: UIButton) {
        delegate?.favouriteButtonTapped(sender.tag)
    }
    
    func favouriteButtonTapped(_ tag: Int) {
        let recipeID = vc.recipes?[tag].id
        let uid = Auth.auth().currentUser!.uid
        db.collection("Users").document(uid).collection("FavouriteRecipes").document("\(recipeID ?? 0)").delete { (error) in
            if error != nil {
                Alert.showAlert(title: "Error", subtitle: error!.localizedDescription, leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
            } else {
                self.vc.recipes?.remove(at: tag)
                self.recipesTableView.deleteRows(at: [IndexPath.init(row: tag, section: 0)], with: .fade)
                self.recipesTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recipesTVDetailsSelectActionDelegate?.recipeDetails(
            recipeTitle: vc.recipes?[indexPath.row].title ?? "Error",
            recipeImage: vc.recipes?[indexPath.row].image ?? "Error",
            recipeTime: "\(vc.recipes?[indexPath.row].readyInMinutes ?? 0) Min",
            recipeInstructions: vc.recipes?[indexPath.row].instructions ?? "Error",
            ingredientsNumber: "\(vc.recipes?[indexPath.row].extendedIngredients?.count ?? 0)",
            ingredientsNumbersInt: vc.recipes?[indexPath.row].extendedIngredients?.count ?? 0,
            ingredientsName: (vc.recipes?[indexPath.row].extendedIngredients?.compactMap({$0.name}) ?? ["Error"]),
            ingredientsWeight: vc.recipes?[indexPath.row].extendedIngredients?.map({($0.amount ?? 0.0)}) ?? [0.0],
            ingredientsAmount: vc.recipes?[indexPath.row].extendedIngredients?.map({($0.unit ?? "Error")}) ?? ["Error"],
            instructionsNumber: "\(vc.recipes?[indexPath.row].analyzedInstructions?.count ?? 0)",
            instructionsSteps: vc.recipes?[indexPath.row].analyzedInstructions?[0].steps?.map({$0.step ?? "Error"}) ?? ["Error"],
            recipeID: "\(vc.recipes?[indexPath.row].id ?? 0)"
        )
    }

}
