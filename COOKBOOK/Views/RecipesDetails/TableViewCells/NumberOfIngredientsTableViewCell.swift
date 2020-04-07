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
        theNameOfIngredient.numberOfLines = 0
        theNameOfIngredient.translatesAutoresizingMaskIntoConstraints = false
        return theNameOfIngredient
    }()
    
    lazy var theAmountOfIngredient: UILabel = {
        let theAmountOfIngredient = UILabel()
        theAmountOfIngredient.text = "2.0"
        theAmountOfIngredient.font = UIFont(name: "AvenirNext-Regular", size: 14)
        theAmountOfIngredient.textColor = .customDarkGray()
        theAmountOfIngredient.textAlignment = .center
        theAmountOfIngredient.translatesAutoresizingMaskIntoConstraints = false
        return theAmountOfIngredient
    }()
    
    func setupTheNumberOfIngredientConstraints() {
        NSLayoutConstraint.activate([
            theNumberOfIngredient.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            theNumberOfIngredient.centerYAnchor.constraint(equalTo: theNameOfIngredient.centerYAnchor)
        ])
    }
    
    func setupTheNameOfIngredientConstraints() {
        NSLayoutConstraint.activate([
            theNameOfIngredient.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            theNameOfIngredient.leadingAnchor.constraint(equalTo: theNumberOfIngredient.trailingAnchor, constant: 16),
            theNameOfIngredient.trailingAnchor.constraint(lessThanOrEqualTo: theAmountOfIngredient.leadingAnchor, constant: -16),
            theNameOfIngredient.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
        theNameOfIngredient.setContentHuggingPriority(.init(240.0), for: .horizontal)
        theNameOfIngredient.setContentCompressionResistancePriority(.init(740.0), for: .horizontal)
    }
    
    func setupTheAmountOfIngredientConstraints() {
        NSLayoutConstraint.activate([
            theAmountOfIngredient.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            theAmountOfIngredient.centerYAnchor.constraint(equalTo: theNameOfIngredient.centerYAnchor)
        ])
    }
    
    func addSubviews() {
        addSubview(theNumberOfIngredient)
        addSubview(theNameOfIngredient)
        addSubview(theAmountOfIngredient)
    }
    
    func layoutUI() {
        addSubviews()
        setupTheNumberOfIngredientConstraints()
        setupTheNameOfIngredientConstraints()
        setupTheAmountOfIngredientConstraints()
    }

}
