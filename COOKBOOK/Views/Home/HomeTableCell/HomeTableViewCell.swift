//
//  HomeTableViewCell.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 2/23/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

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
        containerView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowOffset = .init(width: 2, height: 2)
        containerView.layer.shadowRadius = 7.0
        containerView.layer.cornerRadius = 8.0
//        containerView.clipsToBounds = true
        return containerView
    }()
    
    lazy var foodImage: UIImageView = {
        let foodImage = UIImageView()
        foodImage.translatesAutoresizingMaskIntoConstraints = false
        foodImage.contentMode = .scaleAspectFill
        foodImage.clipsToBounds = true
        foodImage.layer.cornerRadius = 8.0
        return foodImage
    }()
    
    lazy var foodTitle: UILabel = {
        let foodTitle = UILabel()
        foodTitle.textColor = .CustomGreen()
        foodTitle.numberOfLines = 0
        foodTitle.translatesAutoresizingMaskIntoConstraints = false
        return foodTitle
    }()
    
    func setupContainerView() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
//            containerView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setupFoodImage() {
        NSLayoutConstraint.activate([
            foodImage.topAnchor.constraint(equalTo: containerView.topAnchor),
//            foodImage.bottomAnchor.constraint(equalTo: foodTitle.topAnchor, constant: 16),
            foodImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            foodImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            foodImage.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    func setupFoodTitle() {
        NSLayoutConstraint.activate([
            foodTitle.topAnchor.constraint(equalTo: foodImage.bottomAnchor, constant: 16),
            foodTitle.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            foodTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            foodTitle.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
    }
    
    func addSubview() {
        addSubview(containerView)
        containerView.addSubview(foodImage)
        containerView.addSubview(foodTitle)
    }
    
    func layoutUI() {
        addSubview()
        setupContainerView()
        setupFoodImage()
        setupFoodTitle()
    }
    
}
