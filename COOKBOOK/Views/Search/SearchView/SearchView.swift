//
//  SearchView.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 4/7/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

protocol SearchDelegate: class {
    func searchRecipeDelegate(recipeID: Int, recipeTitle: String, recipeImage: String)
}

class SearchView: UIView {
    
    var vc = SearchViewController()
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
        searchTableView.register(SearchViewTableViewCell.self, forCellReuseIdentifier: "SearchViewTableViewCell")
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

extension SearchView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if vc.recipes?.totalResults ?? 0 == 0 {
            return 1
        } else if vc.recipes?.totalResults ?? 0 < vc.recipes?.number ?? 0 {
            return vc.recipes?.totalResults ?? 0
        } else {
            return vc.recipes?.number ?? 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if vc.recipes?.totalResults == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Error404TableViewCell", for: indexPath) as! Error404TableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchViewTableViewCell", for: indexPath) as! SearchViewTableViewCell
            cell.foodTitle.text = vc.recipes?.results?[indexPath.row].title
            let url = URL(string: "\(vc.recipes?.baseURI ?? "Error")" + "\(vc.recipes?.results?[indexPath.row].image ?? "Error")")
            let processor = DownsamplingImageProcessor(size: cell.foodImage.bounds.size)
            cell.foodImage.kf.indicatorType = .activity
            cell.foodImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholderImage"), options: [.processor(processor), .scaleFactor(UIScreen.main.scale), .transition(.fade(1)), .cacheOriginalImage])
            cell.cookingTimeInfoLabel.text = "\(vc.recipes?.results?[indexPath.row].readyInMinutes ?? 0) Mins"
            cell.servesInfoLabel.text = "\(vc.recipes?.results?[indexPath.row].servings ?? 0) People"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if vc.recipes?.totalResults != 0 {
            delegate?.searchRecipeDelegate(
                recipeID: vc.recipes?.results?[indexPath.row].id ?? 0,
                recipeTitle: vc.recipes?.results?[indexPath.row].title ?? "Error",
                recipeImage: "\(vc.recipes?.baseURI ?? "Error")" + "\(vc.recipes?.results?[indexPath.row].image ?? "Error")"
            )
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
