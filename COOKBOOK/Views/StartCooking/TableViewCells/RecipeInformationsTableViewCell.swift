//
//  RecipeInformationsTableViewCell.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 3/26/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit

class RecipeInformationsTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutUI()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .black
        containerView.alpha = 0.7
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    lazy var recipeImage: UIImageView = {
        let recipeImage = UIImageView()
        recipeImage.contentMode = .scaleToFill
        recipeImage.clipsToBounds = true
        recipeImage.image = UIImage(named: "pizza")
        recipeImage.layer.masksToBounds = true
        recipeImage.translatesAutoresizingMaskIntoConstraints = false
        return recipeImage
    }()
    
    lazy var timerContainerView: UIView = {
        let timerContainerView = UIView()
        timerContainerView.backgroundColor = .white
        timerContainerView.layer.cornerRadius = self.frame.width / 24
        timerContainerView.clipsToBounds = true
        timerContainerView.translatesAutoresizingMaskIntoConstraints = false
        return timerContainerView
    }()
    
    lazy var timerLabel: UILabel = {
        let timerLabel = UILabel()
        timerLabel.text = "45 Min"
        timerLabel.textColor = .CustomGreen()
        timerLabel.font = UIFont(name: "AvenirNext-Medium", size: 14)
        timerLabel.textAlignment = .center
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        return timerLabel
    }()
    
    lazy var recipeTitleLabel: UILabel = {
        let recipeTitleLabel = UILabel()
        recipeTitleLabel.textColor = .white
        recipeTitleLabel.text = "Bla Bla Bla Bla Bla Bla Bla Bla"
        recipeTitleLabel.textAlignment = .left
        recipeTitleLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 25)
        recipeTitleLabel.numberOfLines = 0
        recipeTitleLabel.alpha = 1.0
        recipeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return recipeTitleLabel
    }()
    
    lazy var startProcessLabel: UILabel = {
        let startProcessLabel = UILabel()
        startProcessLabel.textColor = .white
        startProcessLabel.text = "Start process"
        startProcessLabel.textAlignment = .left
        startProcessLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        startProcessLabel.translatesAutoresizingMaskIntoConstraints = false
        return startProcessLabel
    }()
    
    lazy var numberOfProcessLabel: UILabel = {
        let numberOfProcessLabel = UILabel()
        numberOfProcessLabel.textColor = .white
        numberOfProcessLabel.text = "7 process"
        numberOfProcessLabel.textAlignment = .left
        numberOfProcessLabel.font = UIFont(name: "AvenirNext-Regular", size: 14)
        numberOfProcessLabel.translatesAutoresizingMaskIntoConstraints = false
        return numberOfProcessLabel
    }()
    
    func setupContainerViewConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: recipeImage.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: recipeImage.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: recipeImage.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: recipeImage.bottomAnchor)
        ])
    }
    
    func setupRecipeImageConstraints() {
        NSLayoutConstraint.activate([
            recipeImage.topAnchor.constraint(equalTo: topAnchor),
            recipeImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            recipeImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            recipeImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            recipeImage.heightAnchor.constraint(lessThanOrEqualToConstant: 300)
        ])
        recipeImage.setContentHuggingPriority(.init(240.0), for: .vertical)
        recipeImage.setContentCompressionResistancePriority(.init(740.0), for: .vertical)
    }
    
    func setupTimerContinerViewConstraints() {
        NSLayoutConstraint.activate([
            timerContainerView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 32),
            timerContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            timerContainerView.widthAnchor.constraint(equalToConstant: self.frame.width / 5),
            timerContainerView.heightAnchor.constraint(equalToConstant: self.frame.width / 12)
        ])
        
    }
    
    func setupTimerLabelCostraints() {
        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: timerContainerView.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: timerContainerView.centerYAnchor)
        ])
    }
    
    func setupRecipeTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            recipeTitleLabel.topAnchor.constraint(equalTo: timerContainerView.bottomAnchor, constant: 16),
            recipeTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            recipeTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -16)
        ])
        recipeTitleLabel.setContentHuggingPriority(.init(240.0), for: .horizontal)
        recipeTitleLabel.setContentCompressionResistancePriority(.init(740.0), for: .horizontal)
    }
    
    func setupStartProcessLabelConstraints() {
        NSLayoutConstraint.activate([
            startProcessLabel.topAnchor.constraint(equalTo: recipeTitleLabel.bottomAnchor, constant: 16),
            startProcessLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
        ])
    }
    
    func setupnumberOfProcessLabelConstraints() {
        NSLayoutConstraint.activate([
            numberOfProcessLabel.topAnchor.constraint(equalTo: startProcessLabel.bottomAnchor, constant: 8),
            numberOfProcessLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            numberOfProcessLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8)
        ])
    }
    
    func addSubviews() {
        addSubview(recipeImage)
        addSubview(containerView)
        addSubview(timerContainerView)
        timerContainerView.addSubview(timerLabel)
        addSubview(recipeTitleLabel)
        addSubview(startProcessLabel)
        addSubview(numberOfProcessLabel)
    }
    
    func layoutUI() {
        addSubviews()
        setupRecipeImageConstraints()
        setupContainerViewConstraints()
        setupTimerContinerViewConstraints()
        setupTimerLabelCostraints()
        setupRecipeTitleLabelConstraints()
        setupStartProcessLabelConstraints()
        setupnumberOfProcessLabelConstraints()
    }
    
}
