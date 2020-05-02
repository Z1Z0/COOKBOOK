//
//  SearchByIngredientsViewCollectionViewCell.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 4/21/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit

class SearchByIngredientsViewCollectionViewCell: UICollectionViewCell {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .CustomGreen()
        layer.cornerRadius = 8.0
        layoutUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var ingredientTitleLabel: UILabel = {
        let ingredientTitleLabel = UILabel()
        ingredientTitleLabel.textColor = .white
        ingredientTitleLabel.numberOfLines = 0
        ingredientTitleLabel.textAlignment = .left
        ingredientTitleLabel.font = UIFont(name: "AvenirNext-Bold", size: 14)
        ingredientTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return ingredientTitleLabel
    }()
    
    func ingredientTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            ingredientTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            ingredientTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            ingredientTitleLabel.trailingAnchor.constraint(equalTo: deleteIngredient.leadingAnchor, constant: -8)
        ])
    }
    
    lazy var deleteIngredient: UIButton = {
        let deleteIngredient = UIButton(type: .system)
        deleteIngredient.setImage(UIImage(systemName: "multiply.circle.fill"), for: .normal)
        deleteIngredient.tintColor = .white
        deleteIngredient.translatesAutoresizingMaskIntoConstraints = false
        return deleteIngredient
    }()
    
    func deleteIngredientConstraints() {
        NSLayoutConstraint.activate([
            deleteIngredient.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            deleteIngredient.centerYAnchor.constraint(equalTo: ingredientTitleLabel.centerYAnchor),
            deleteIngredient.widthAnchor.constraint(equalToConstant: 20),
            deleteIngredient.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    func addSubviews() {
        addSubview(ingredientTitleLabel)
        addSubview(deleteIngredient)
    }
    
    func layoutUI() {
        addSubviews()
        ingredientTitleLabelConstraints()
        deleteIngredientConstraints()
    }
    
}
