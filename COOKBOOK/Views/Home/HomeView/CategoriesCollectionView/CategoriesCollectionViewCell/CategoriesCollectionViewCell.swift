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
            categoryName.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            categoryName.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    func addSubviews() {
        addSubview(categoriesImage)
        categoriesImage.addSubview(containerView)
        containerView.addSubview(categoryName)
    }
    
    func layoutUI() {
        addSubviews()
        setupcategoriesImageConstraints()
        setupContainerViewConstraints()
        setupCategoryNameConstraints()
    }
}
