//
//  RecipesDetailsView.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 3/14/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation
import UIKit

class RecipesDetailsView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .customVeryLightGray()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .clear
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    lazy var recipeTitleLabel: UILabel = {
        let recipeTitleLabel = UILabel()
        recipeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        recipeTitleLabel.text = "Myanmar Traditional Fish Curry"
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
    
    func setupScrollView() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func setupContainerView() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1)
        ])
    }
    
    func setupRecipeTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            recipeTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            recipeTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            recipeTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -16)
        ])
        recipeTitleLabel.setContentHuggingPriority(.init(240.0), for: .horizontal)
        recipeTitleLabel.setContentCompressionResistancePriority(.init(740.0), for: .horizontal)
    }
    
    func setupRecipeImageConstraints() {
        NSLayoutConstraint.activate([
            recipeImage.topAnchor.constraint(equalTo: recipeTitleLabel.bottomAnchor, constant: 16),
            recipeImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            recipeImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            recipeImage.heightAnchor.constraint(equalToConstant: frame.height / 4)
        ])
    }
    
    func setupInstructionsLabel() {
        NSLayoutConstraint.activate([
            instructionLabel.topAnchor.constraint(equalTo: recipeImage.bottomAnchor, constant: 16),
            instructionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            instructionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
    }
    
    func setupInstructionsTextView() {
        NSLayoutConstraint.activate([
            instructionsTextView.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 8),
            instructionsTextView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            instructionsTextView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
    }
    
    func setupIngredientsLabel() {
        NSLayoutConstraint.activate([
            ingredientsLabel.topAnchor.constraint(equalTo: instructionsTextView.bottomAnchor, constant: 16),
            ingredientsLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
        ])
    }
    
    func setupBuyingIngredientsButton() {
        NSLayoutConstraint.activate([
            buyingIngredientsButton.centerYAnchor.constraint(equalTo: ingredientsLabel.centerYAnchor),
            buyingIngredientsButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
    }
    
    func setupNumberOfGredientsLabel() {
        NSLayoutConstraint.activate([
            numberOfGredientsLabel.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 8),
            numberOfGredientsLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            numberOfGredientsLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
    }
    
    func addSubViews() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(recipeTitleLabel)
        containerView.addSubview(recipeImage)
        containerView.addSubview(instructionLabel)
        containerView.addSubview(instructionsTextView)
        containerView.addSubview(ingredientsLabel)
        containerView.addSubview(buyingIngredientsButton)
        containerView.addSubview(numberOfGredientsLabel)
    }
    
    func layoutUI() {
        addSubViews()
        setupScrollView()
        setupContainerView()
        setupRecipeTitleLabelConstraints()
        setupRecipeImageConstraints()
        setupInstructionsLabel()
        setupInstructionsTextView()
        setupIngredientsLabel()
        setupBuyingIngredientsButton()
        setupNumberOfGredientsLabel()
    }
}
