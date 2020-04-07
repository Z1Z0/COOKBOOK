//
//  RecipeStepsTableViewCell.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 3/26/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit

class RecipeStepsTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutUI()
        selectionStyle = .none
        backgroundColor = .customDarkGray()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var numbersContainerView: UIView = {
        let numbersContainerView = UIView()
        numbersContainerView.backgroundColor = .CustomGreen()
        numbersContainerView.layer.cornerRadius = 8.0
        numbersContainerView.translatesAutoresizingMaskIntoConstraints = false
        return numbersContainerView
    }()
    
    lazy var numberofProcessLabel: UILabel = {
        let numberofProcessLabel = UILabel()
        numberofProcessLabel.text = "01"
        numberofProcessLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        numberofProcessLabel.textColor = .white
        numberofProcessLabel.textAlignment = .center
        numberofProcessLabel.translatesAutoresizingMaskIntoConstraints = false
        return numberofProcessLabel
    }()
    
    lazy var nameOfProcessLabel: UILabel = {
        let nameOfProcessLabel = UILabel()
        nameOfProcessLabel.text = "Place onion, garlic and ginger in a food processor and process to a smooth paste.Place onion, garlic and ginger in a food processor and process to a smooth paste.Place onion, garlic and ginger in a food processor and process to a smooth paste.Place onion, garlic and ginger in a food processor and process to a smooth paste.Place onion, garlic and ginger in a food processor and process to a smooth paste."
        nameOfProcessLabel.textColor = .white
        nameOfProcessLabel.numberOfLines = 0
        nameOfProcessLabel.textAlignment = .left
        nameOfProcessLabel.font = UIFont(name: "AvenirNext-Regular", size: 14)
        nameOfProcessLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameOfProcessLabel
    }()
    
    func setupNumbersContainerViewConstraints() {
        NSLayoutConstraint.activate([
            numbersContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            numbersContainerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            numbersContainerView.widthAnchor.constraint(equalToConstant: 30),
            numbersContainerView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setupNumberofProcessLabelConstraints() {
        NSLayoutConstraint.activate([
            numberofProcessLabel.centerXAnchor.constraint(equalTo: numbersContainerView.centerXAnchor),
            numberofProcessLabel.centerYAnchor.constraint(equalTo: numbersContainerView.centerYAnchor)
        ])
    }
    
    func setupNameOfProcessLabelConstraints() {
        NSLayoutConstraint.activate([
            nameOfProcessLabel.leadingAnchor.constraint(equalTo: numbersContainerView.trailingAnchor, constant: 16),
            nameOfProcessLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            nameOfProcessLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameOfProcessLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
        nameOfProcessLabel.setContentHuggingPriority(.init(240.0), for: .horizontal)
        nameOfProcessLabel.setContentCompressionResistancePriority(.init(740.0), for: .horizontal)
    }
    
    func addSubviews() {
        addSubview(numbersContainerView)
        numbersContainerView.addSubview(numberofProcessLabel)
        addSubview(nameOfProcessLabel)
    }
    
    func layoutUI() {
        addSubviews()
        setupNumbersContainerViewConstraints()
        setupNumberofProcessLabelConstraints()
        setupNameOfProcessLabelConstraints()
    }

}
