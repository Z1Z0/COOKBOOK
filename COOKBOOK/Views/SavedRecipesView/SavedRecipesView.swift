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

class SavedRecipesView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var vc = SavedRecipesViewController()
    
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
            recipesTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            recipesTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            recipesTableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func addSubviews() {
        addSubview(recipesTableView)
    }
    
    func layoutUI() {
        addSubviews()
        setupRecipesTableViewConstraints()
    }
    
}

extension SavedRecipesView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vc.recipes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        let url = URL(string: vc.recipes?[indexPath.row].image ?? "Error")
        let processor = DownsamplingImageProcessor(size: cell.foodImage.bounds.size)
        cell.foodImage.kf.indicatorType = .activity
        cell.foodImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholderImage"), options: [.processor(processor), .scaleFactor(UIScreen.main.scale), .transition(.fade(1)), .cacheOriginalImage])
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
                
        return cell
    }
    
    
}
