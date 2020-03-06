//
//  CollectionViewCell.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 3/2/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    required init(coder adecoder: NSCoder) {
        fatalError("init(codeer:) has not been implemented")
    }
        
    lazy var categoriesImage: UIImageView = {
        let categoriesImage = UIImageView()
        categoriesImage.contentMode = .scaleAspectFill
        categoriesImage.clipsToBounds = true
        categoriesImage.layer.cornerRadius = 8.0
        categoriesImage.image = UIImage(named: "pizza")
        categoriesImage.layer.cornerRadius = 8.0
        categoriesImage.layer.masksToBounds = true
        categoriesImage.translatesAutoresizingMaskIntoConstraints = false
        return categoriesImage
    }()
    
    lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .black
        containerView.alpha = 0.7
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    lazy var categoryName: UILabel = {
        let categoryName = UILabel()
        categoryName.textColor = .white
        categoryName.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        categoryName.text = "Soup"
        categoryName.textAlignment = .left
        categoryName.translatesAutoresizingMaskIntoConstraints = false
        return categoryName
    }()
    
    lazy var recipesNumber: UILabel = {
        let recipesNumber = UILabel()
        recipesNumber.textColor = .white
        recipesNumber.font = UIFont(name: "AvenirNext-Regular", size: 16)
        recipesNumber.text = "33"
        recipesNumber.textAlignment = .left
        recipesNumber.translatesAutoresizingMaskIntoConstraints = false
        return recipesNumber
    }()
    
    func setupcategoriesImageConstraints() {
        NSLayoutConstraint.activate([
            categoriesImage.topAnchor.constraint(equalTo: topAnchor),
            categoriesImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            categoriesImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoriesImage.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    func setupContainerViewConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: categoriesImage.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: categoriesImage.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: categoriesImage.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: categoriesImage.trailingAnchor)
        ])
    }
    
    func setupCategoryNameConstraints() {
        NSLayoutConstraint.activate([
            categoryName.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            categoryName.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            categoryName.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 16)
        ])
    }
    
    func setuprecipesNumberConstraints() {
        NSLayoutConstraint.activate([
            recipesNumber.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            recipesNumber.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            recipesNumber.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 16)
        ])
    }
    
    func addSubviews() {
        addSubview(categoriesImage)
        categoriesImage.addSubview(containerView)
        containerView.addSubview(categoryName)
        containerView.addSubview(recipesNumber)
    }
    
    func layoutUI() {
        addSubviews()
        setupcategoriesImageConstraints()
        setupContainerViewConstraints()
        setupCategoryNameConstraints()
        setuprecipesNumberConstraints()
    }
}
