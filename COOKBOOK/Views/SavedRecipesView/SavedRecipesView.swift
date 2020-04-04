//
//  SavedRecipesView.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 4/4/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation
import UIKit

class SavedRecipesView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var recipesTableView: UITableView = {
        let recipesTableView = UITableView()
        recipesTableView.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1)
        recipesTableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
        recipesTableView.rowHeight = UITableView.automaticDimension
        recipesTableView.estimatedRowHeight = 100
        recipesTableView.showsVerticalScrollIndicator = false
        recipesTableView.separatorStyle = .none
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
        return Int()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
