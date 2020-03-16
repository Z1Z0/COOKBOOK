//
//  NumberOfIngredientsTableViewCell.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 3/15/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit

class NumberOfIngredientsTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutUI()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var theNumberOfIngredient: UILabel = {
        let theNumberOfIngredient = UILabel()
        theNumberOfIngredient.text = "01"
        theNumberOfIngredient.font = UIFont(name: "AvenirNext-Regular", size: 14)
        theNumberOfIngredient.textColor = .customLightDarkGray()
        theNumberOfIngredient.textAlignment = .left
        theNumberOfIngredient.translatesAutoresizingMaskIntoConstraints = false
        return theNumberOfIngredient
    }()
    
    lazy var theNameOfIngredient: UILabel = {
        let theNameOfIngredient = UILabel()
        theNameOfIngredient.text = "Ingredients"
        theNameOfIngredient.font = UIFont(name: "AvenirNext-Regular", size: 14)
        theNameOfIngredient.textColor = .customDarkGray()
        theNameOfIngredient.textAlignment = .left
        theNameOfIngredient.translatesAutoresizingMaskIntoConstraints = false
        return theNameOfIngredient
    }()
    
    func setupTheNumberOfIngredientConstraints() {
        NSLayoutConstraint.activate([
            theNumberOfIngredient.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            theNumberOfIngredient.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setupTheNameOfIngredientConstraints() {
        NSLayoutConstraint.activate([
            theNameOfIngredient.leadingAnchor.constraint(equalTo: theNumberOfIngredient.trailingAnchor, constant: 16),
            theNameOfIngredient.centerYAnchor.constraint(equalTo: theNumberOfIngredient.centerYAnchor),
//            theNameOfIngredient.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    func addSubviews() {
        addSubview(theNumberOfIngredient)
        addSubview(theNameOfIngredient)
    }
    
    func layoutUI() {
        addSubviews()
        setupTheNumberOfIngredientConstraints()
        setupTheNameOfIngredientConstraints()
    }

}
