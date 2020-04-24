//
//  SearchByIngredientsTableView.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 4/22/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class SearchByIngredientsTableView: UIView {
    
    var vc = SearchByIngredientsTableViewController()
    weak var delegate: SearchDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var searchTableView: UITableView = {
        let searchTableView = UITableView()
        searchTableView.translatesAutoresizingMaskIntoConstraints = false
        searchTableView.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1)
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.register(SearchByIngredientsTableViewCell.self, forCellReuseIdentifier: "SearchByIngredientsTableViewCell")
        searchTableView.register(Error404TableViewCell.self, forCellReuseIdentifier: "Error404TableViewCell")
        searchTableView.rowHeight = UITableView.automaticDimension
        searchTableView.estimatedRowHeight = 100
        searchTableView.showsVerticalScrollIndicator = false
        searchTableView.separatorStyle = .none
        return searchTableView
    }()
    
    func setupSearchTableViewConstraints() {
        NSLayoutConstraint.activate([
            searchTableView.topAnchor.constraint(equalTo: topAnchor),
            searchTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            searchTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchTableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func addSubviews() {
        addSubview(searchTableView)
    }
    
    func layoutUI() {
        addSubviews()
        setupSearchTableViewConstraints()
    }
    
}

extension SearchByIngredientsTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if vc.recipes?.count != 0 {
            return vc.recipes?.count ?? 0
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if vc.recipes?.count != 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchByIngredientsTableViewCell", for: indexPath) as! SearchByIngredientsTableViewCell
            cell.foodTitle.text = vc.recipes?[indexPath.row].title
            let url = URL(string: vc.recipes?[indexPath.row].image ?? "Error")
            cell.foodImage.kf.setImage(with: url)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Error404TableViewCell", for: indexPath) as! Error404TableViewCell
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.searchRecipeDelegate(recipeID: vc.recipes?[indexPath.row].id ?? 0, recipeTitle: vc.recipes?[indexPath.row].title ?? "Error", recipeImage: vc.recipes?[indexPath.row].image ?? "Error")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
