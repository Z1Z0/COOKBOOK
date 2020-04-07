//
//  ListOfIngredientsTableViewCell.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 4/7/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit
import BEMCheckBox

class ListOfIngredientsTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var checkBoXButton: BEMCheckBox = {
        let checkBoXButton = BEMCheckBox()
        checkBoXButton.boxType = .square
        checkBoXButton.cornerRadius = 3.0
        checkBoXButton.onTintColor = .white
        checkBoXButton.onFillColor = .white
        checkBoXButton.onCheckColor = .CustomGreen()
        checkBoXButton.tintColor = .white
        checkBoXButton.onAnimationType = .fill
        checkBoXButton.lineWidth = 2
        checkBoXButton.translatesAutoresizingMaskIntoConstraints = false
        return checkBoXButton
    }()
    
    lazy var ingredientNamesLabel: UILabel = {
        let ingredientNamesLabel = UILabel()
        ingredientNamesLabel.textColor = .white
        ingredientNamesLabel.textAlignment = .left
        ingredientNamesLabel.text = "onion, finely chopped"
        ingredientNamesLabel.font = UIFont(name: "AvenirNext-Regular", size: 14)
        ingredientNamesLabel.translatesAutoresizingMaskIntoConstraints = false
        return ingredientNamesLabel
    }()
    
    lazy var ingredientsWeightLabel: UILabel = {
        let ingredientsWeightLabel = UILabel()
        ingredientsWeightLabel.textColor = .white
        ingredientsWeightLabel.textAlignment = .left
        ingredientsWeightLabel.text = "1g"
        ingredientsWeightLabel.font = UIFont(name: "AvenirNext-Regular", size: 14)
        ingredientsWeightLabel.translatesAutoresizingMaskIntoConstraints = false
        return ingredientsWeightLabel
    }()
    
    func setupCheckBoXButton() {
        NSLayoutConstraint.activate([
            checkBoXButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            checkBoXButton.centerYAnchor.constraint(equalTo: ingredientNamesLabel.centerYAnchor),
            checkBoXButton.widthAnchor.constraint(equalToConstant: 20),
            checkBoXButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func setupIngredientNamesLabelConstraints() {
        NSLayoutConstraint.activate([
            ingredientNamesLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            ingredientNamesLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            ingredientNamesLabel.leadingAnchor.constraint(equalTo: checkBoXButton.trailingAnchor, constant: 16),
            ingredientNamesLabel.trailingAnchor.constraint(equalTo: ingredientsWeightLabel.leadingAnchor, constant: -16)
        ])
    }
    
    func setupIngredientsWeightLabelConstraints() {
        NSLayoutConstraint.activate([
            ingredientsWeightLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            ingredientsWeightLabel.centerYAnchor.constraint(equalTo: ingredientNamesLabel.centerYAnchor)
        ])
    }
    
    func addSubviews() {
        addSubview(checkBoXButton)
        addSubview(ingredientNamesLabel)
        addSubview(ingredientsWeightLabel)
    }
    
    func layoutUI() {
        addSubviews()
        setupCheckBoXButton()
        setupIngredientNamesLabelConstraints()
        setupIngredientsWeightLabelConstraints()
    }

}
