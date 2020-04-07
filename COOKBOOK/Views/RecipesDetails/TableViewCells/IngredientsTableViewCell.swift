//
//  IngredientsTableViewCell.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 3/15/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit

@objc protocol BuyingIngredientsButtonDelegate: class {
    @objc func buyingIngredientsButtonTapped()
}

class IngredientsTableViewCell: UITableViewCell {
    
    weak var delegate: BuyingIngredientsButtonDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutUI()
        selectionStyle = .none        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var recipeTitleLabel: UILabel = {
        let recipeTitleLabel = UILabel()
        recipeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        recipeTitleLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 25)
        recipeTitleLabel.textColor = .customDarkGray()
        recipeTitleLabel.numberOfLines = 0
        recipeTitleLabel.textAlignment = .left
        return recipeTitleLabel
    }()
    
    lazy var recipeImage: UIImageView = {
        let recipeImage = UIImageView()
        recipeImage.contentMode = .scaleToFill
        recipeImage.clipsToBounds = true
        recipeImage.image = UIImage(named: "pizza")
        recipeImage.layer.cornerRadius = 8.0
        recipeImage.layer.masksToBounds = true
        recipeImage.translatesAutoresizingMaskIntoConstraints = false
        return recipeImage
    }()
    
    lazy var instructionLabel: UILabel = {
        let instructionLabel = UILabel()
        instructionLabel.text = "Instructions"
        instructionLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        instructionLabel.textColor = .customDarkGray()
        instructionLabel.textAlignment = .left
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        return instructionLabel
    }()
    
    lazy var instructionsTextView: UITextView = {
        let instructionsTextView = UITextView()
        instructionsTextView.text = "Myanmar Traditional Fish CurryMyanmar Traditional Fish CurryMyanmarMyanmar Traditional Fish CurryMyanmar Traditional Fish CurryMyanmarMyanmar Traditional Fish CurryMyanmar Traditional Fish CurryMyanmarMyanmar Traditional Fish CurryMyanmar Traditional Fish CurryMyanmarMyanmar Traditional Fish CurryMyanmar Traditional Fish CurryMyanmarMyanmar Traditional Fish CurryMyanmar Traditional Fish CurryMyanmarMyanmar Traditional Fish CurryMyanmar Traditional Fish CurryMyanmarMyanmar Traditional Fish CurryMyanmar Traditional Fish CurryMyanmarMyanmar Traditional Fish CurryMyanmar Traditional Fish CurryMyanmarMyanmar Traditional Fish CurryMyanmar Traditional Fish CurryMyanmarMyanmar Traditional Fish CurryMyanmar Traditional Fish CurryMyanmarMyanmar Traditional Fish CurryMyanmar Traditional Fish CurryMyanmarMyanmar Traditional Fish CurryMyanmar Traditional Fish CurryMyanmarMyanmar Traditional Fish CurryMyanmar Traditional Fish CurryMyanmarMyanmar Traditional Fish CurryMyanmar Traditional Fish CurryMyanmarMyanmar Traditional Fish CurryMyanmar Traditional Fish CurryMyanmarMyanmar Traditional Fish CurryMyanmar Traditional Fish CurryMyanmarMyanmar Traditional Fish CurryMyanmar Traditional Fish CurryMyanmarMyanmar Traditional Fish CurryMyanmar Traditional Fish CurryMyanmarMyanmar Traditional Fish CurryMyanmar Traditional Fish CurryMyanmarMyanmar Traditional Fish CurryMyanmar Traditional Fish CurryMyanmarMyanmar Traditional Fish CurryMyanmar Traditional Fish CurryMyanmarMyanmar Traditional Fish CurryMyanmar Traditional Fish CurryMyanmar"
        instructionsTextView.textColor = .customLightDarkGray()
        instructionsTextView.font = UIFont(name: "AvenirNext-Regular", size: 14)
        instructionsTextView.textAlignment = .left
        instructionsTextView.isEditable = false
        instructionsTextView.isScrollEnabled = false
        instructionsTextView.translatesAutoresizingMaskIntoConstraints = false
        return instructionsTextView
    }()
    
    lazy var ingredientsLabel: UILabel = {
        let ingredientsLabel = UILabel()
        ingredientsLabel.text = "Ingredients"
        ingredientsLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        ingredientsLabel.textColor = .customDarkGray()
        ingredientsLabel.textAlignment = .left
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        return ingredientsLabel
    }()
    
    lazy var buyingIngredientsButton: UIButton = {
        let buyingIngredientsButton = UIButton(type: .system)
        buyingIngredientsButton.translatesAutoresizingMaskIntoConstraints = false
        buyingIngredientsButton.setTitle("Start buying", for: .normal)
        buyingIngredientsButton.setTitleColor(.CustomGreen(), for: .normal)
        buyingIngredientsButton.addTarget(delegate, action: #selector(delegate?.buyingIngredientsButtonTapped), for: .touchUpInside)
        buyingIngredientsButton.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
        return buyingIngredientsButton
    }()
    
    lazy var numberOfGredientsLabel: UILabel = {
        let numberOfGredientsLabel = UILabel()
        numberOfGredientsLabel.text = "Ingredients"
        numberOfGredientsLabel.font = UIFont(name: "AvenirNext-Regular", size: 14)
        numberOfGredientsLabel.textColor = .customDarkGray()
        numberOfGredientsLabel.textAlignment = .left
        numberOfGredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        return numberOfGredientsLabel
    }()
    
    func setupRecipeTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            recipeTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            recipeTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            recipeTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16)
        ])
        recipeTitleLabel.setContentHuggingPriority(.init(240.0), for: .horizontal)
        recipeTitleLabel.setContentCompressionResistancePriority(.init(740.0), for: .horizontal)
    }
    
    func setupRecipeImageConstraints() {
        NSLayoutConstraint.activate([
            recipeImage.topAnchor.constraint(equalTo: recipeTitleLabel.bottomAnchor, constant: 16),
            recipeImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            recipeImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            recipeImage.heightAnchor.constraint(equalToConstant: self.frame.height * 5)
        ])
    }
    
    func setupInstructionsLabelConstraints() {
        NSLayoutConstraint.activate([
            instructionLabel.topAnchor.constraint(equalTo: recipeImage.bottomAnchor, constant: 16),
            instructionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            instructionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    func setupInstructionsTextViewConstraints() {
        NSLayoutConstraint.activate([
            instructionsTextView.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 8),
            instructionsTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            instructionsTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    func setupIngredientsLabelConstraints() {
        NSLayoutConstraint.activate([
            ingredientsLabel.topAnchor.constraint(equalTo: instructionsTextView.bottomAnchor, constant: 16),
            ingredientsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
        ])
    }
    
    func setupBuyingIngredientsButtonConstraints() {
        NSLayoutConstraint.activate([
            buyingIngredientsButton.centerYAnchor.constraint(equalTo: ingredientsLabel.centerYAnchor),
            buyingIngredientsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    func setupNumberOfIngredientsLabelConstraints() {
        NSLayoutConstraint.activate([
            numberOfGredientsLabel.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 8),
            numberOfGredientsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            numberOfGredientsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
            
        ])
    }
    
    func addSubViews() {
        addSubview(recipeTitleLabel)
        addSubview(recipeImage)
        addSubview(instructionLabel)
        addSubview(instructionsTextView)
        addSubview(ingredientsLabel)
        addSubview(buyingIngredientsButton)
        addSubview(numberOfGredientsLabel)
    }
    
    func layoutUI() {
        addSubViews()
        setupRecipeTitleLabelConstraints()
        setupRecipeImageConstraints()
        setupInstructionsLabelConstraints()
        setupInstructionsTextViewConstraints()
        setupIngredientsLabelConstraints()
        setupBuyingIngredientsButtonConstraints()
        setupNumberOfIngredientsLabelConstraints()
    }
    
}
