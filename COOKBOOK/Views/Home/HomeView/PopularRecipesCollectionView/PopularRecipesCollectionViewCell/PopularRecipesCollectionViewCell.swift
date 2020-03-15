//
//  PopularRecipesCollectionViewCell.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 3/5/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit

class PopularRecipesCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutUI()
    }
    
    required init(coder adecoder: NSCoder) {
        fatalError("init(codeer:) has not been implemented")
    }
    
    lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = 8.0
        containerView.layer.masksToBounds = true
        return containerView
    }()
    
    lazy var popularRecipesImage: UIImageView = {
        let popularRecipesImage = UIImageView()
        popularRecipesImage.contentMode = .scaleAspectFill
        popularRecipesImage.clipsToBounds = true
        popularRecipesImage.translatesAutoresizingMaskIntoConstraints = false
        return popularRecipesImage
    }()
    
    lazy var recipesTitle: UILabel = {
        let recipesTitle = UILabel()
        recipesTitle.textColor = .customLightDarkGray()
        recipesTitle.textAlignment = .left
        recipesTitle.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        recipesTitle.translatesAutoresizingMaskIntoConstraints = false
        return recipesTitle
    }()
    
    func setupContainerViewConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func setupPopularRecipesImageConstraints() {
        NSLayoutConstraint.activate([
            popularRecipesImage.topAnchor.constraint(equalTo: containerView.topAnchor),
            popularRecipesImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            popularRecipesImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            popularRecipesImage.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.75)
        ])
    }
    
    func setupRecipesTitleConstraints() {
        NSLayoutConstraint.activate([
            recipesTitle.topAnchor.constraint(equalTo: popularRecipesImage.bottomAnchor, constant: 8.0),
            recipesTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8.0),
            recipesTitle.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -8.0)
        ])
        
        recipesTitle.setContentHuggingPriority(.init(240.0), for: .horizontal)
        recipesTitle.setContentCompressionResistancePriority(.init(740.0), for: .horizontal)
        
    }
    
    func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(popularRecipesImage)
        containerView.addSubview(recipesTitle)
    }
    
    func layoutUI() {
        addSubviews()
        setupContainerViewConstraints()
        setupPopularRecipesImageConstraints()
        setupRecipesTitleConstraints()
    }
    
    
}
