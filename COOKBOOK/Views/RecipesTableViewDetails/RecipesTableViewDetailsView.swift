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

class RecipesTableViewDetailsView: UIView {
    
    let indicator = ActivityIndicator()
    var recipesTableVC = RecipesTableViewDetails()
        
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

extension RecipesTableViewDetailsView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesTableVC.recipesDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        let newURL = URL(string: recipesTableVC.recipesDetails[indexPath.row].image ?? "Error")
        cell.foodImage.kf.setImage(with: newURL)
        cell.foodTitle.text = recipesTableVC.recipesDetails[indexPath.row].title
        
        if let readyInMin = recipesTableVC.recipesDetails[indexPath.row].readyInMinutes {
            cell.cookingTimeInfoLabel.text = "\(readyInMin) Minutes"
        }
        
        if let pricePerServing = recipesTableVC.recipesDetails[indexPath.row].pricePerServing {
            cell.priceInfoLabel.text = "$\(Int(pricePerServing))"
        }
        
        if let serving = recipesTableVC.recipesDetails[indexPath.row].servings {
            cell.servesInfoLabel.text = "\(serving)"
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
