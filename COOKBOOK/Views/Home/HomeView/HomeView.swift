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

class HomeView: UIView {
    
    var recipes: Recipes?
    var recipesDetails = [Recipe]()
    let indicator = ActivityIndicator()
        
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
        foodTableView.backgroundColor = .white
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
//        fetchData()
    }
    
    func fetchData() {
        AF.request("https://api.spoonacular.com/recipes/random?apiKey=db696760ce1043b08fc01d61d1ed0d35&number=10&tags=dessert").responseJSON { (response) in
            if let error = response.error {
                print(error)
            }
            do {
                self.recipes = try JSONDecoder().decode(Recipes.self, from: response.data!)
                self.recipesDetails = self.recipes?.recipes ?? []
                DispatchQueue.main.async {
                    self.foodTableView.reloadData()
                }
            } catch {
                print(error)
            }
        }
    }
    
}

extension HomeView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        let url = URL(string: recipesDetails[indexPath.row].image ?? "Error")
        cell.foodImage.kf.setImage(with: url)
        cell.foodTitle.text = recipesDetails[indexPath.row].title
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//    return 50 // also UITableViewAutomaticDimension can be used
//    }
    
}
