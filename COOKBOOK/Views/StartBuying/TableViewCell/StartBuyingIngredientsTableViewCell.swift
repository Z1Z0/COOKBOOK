//
//  IngredientsTableViewCell.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 4/6/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit
import BEMCheckBox

class StartBuyingIngredientsTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var ingredientsLabel: UILabel = {
        let ingredientsLabel = UILabel()
        ingredientsLabel.text = "Ingredients"
        ingredientsLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 25)
        ingredientsLabel.textAlignment = .left
        ingredientsLabel.textColor = .white
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        return ingredientsLabel
    }()
    
    lazy var ingredientsNumbersLabel: UILabel = {
        let ingredientsNumbersLabel = UILabel()
        ingredientsNumbersLabel.text = "7 ingredients"
        ingredientsNumbersLabel.font = UIFont(name: "AvenirNext-Medium", size: 16)
        ingredientsNumbersLabel.textAlignment = .left
        ingredientsNumbersLabel.textColor = .white
        ingredientsNumbersLabel.translatesAutoresizingMaskIntoConstraints = false
        return ingredientsNumbersLabel
    }()
    
    func setupIngredientsLabelConstraints() {
        NSLayoutConstraint.activate([
            ingredientsLabel.topAnchor.constraint(equalTo: topAnchor, constant: 64),
            ingredientsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            ingredientsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    func setupingredientsNumbersLabelConstraints() {
        NSLayoutConstraint.activate([
            ingredientsNumbersLabel.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 8),
            ingredientsNumbersLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            ingredientsNumbersLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            ingredientsNumbersLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    func addSubviews() {
        addSubview(ingredientsLabel)
        addSubview(ingredientsNumbersLabel)
    }
    
    func layoutUI() {
        addSubviews()
        setupIngredientsLabelConstraints()
        setupingredientsNumbersLabelConstraints()
    }
    
}
