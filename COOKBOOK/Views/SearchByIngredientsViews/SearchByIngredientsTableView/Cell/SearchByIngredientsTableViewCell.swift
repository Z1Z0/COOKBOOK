//
//  SearchByIngredientsTableViewCell.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 4/23/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation
import UIKit

class SearchByIngredientsTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutUI()
        selectionStyle = .none
        self.backgroundColor = .customVeryLightGray()
    }
    
    weak var delegate: FavouriteActionDelegate?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = 8.0
        containerView.clipsToBounds = true
        return containerView
    }()
    
    lazy var foodImage: UIImageView = {
        let foodImage = UIImageView()
        foodImage.translatesAutoresizingMaskIntoConstraints = false
        foodImage.contentMode = .scaleAspectFill
        foodImage.image = UIImage(named: "breakfast")
        foodImage.clipsToBounds = true
        return foodImage
    }()
    
    lazy var favouriteButton: UIButton = {
        var favouriteButton = UIButton()
        favouriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        favouriteButton.tintColor = .CustomGreen()
        favouriteButton.addTarget(self, action: #selector(favoriteButtonTapped(_:)), for: .touchUpInside)
        favouriteButton.translatesAutoresizingMaskIntoConstraints = false
        return favouriteButton
    }()
    
    @objc func favoriteButtonTapped(_ sender: UIButton) {
        delegate?.favouriteButtonTapped(sender.tag)
        
        UIView.animate(withDuration: 0.2,
        animations: {
            self.favouriteButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        },
        completion: { _ in
            UIView.animate(withDuration: 0.2) {
                self.favouriteButton.transform = CGAffineTransform.identity
            }
        })
    }
    
    lazy var foodTitle: UILabel = {
        let foodTitle = UILabel()
        foodTitle.textColor = .CustomGreen()
        foodTitle.numberOfLines = 0
        foodTitle.font = UIFont(name: "AvenirNext-Bold", size: 16)
        foodTitle.translatesAutoresizingMaskIntoConstraints = false
        return foodTitle
    }()
    
    func setupContainerView() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
//            containerView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func setupFoodImage() {
        NSLayoutConstraint.activate([
            foodImage.topAnchor.constraint(equalTo: containerView.topAnchor),
            foodImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            foodImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            foodImage.heightAnchor.constraint(equalToConstant: self.bounds.width / 1.8)
        ])
    }
    
    func setupFoodTitle() {
        
        NSLayoutConstraint.activate([
            foodTitle.topAnchor.constraint(equalTo: foodImage.bottomAnchor, constant: 16),
            foodTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            foodTitle.trailingAnchor.constraint(lessThanOrEqualTo: favouriteButton.leadingAnchor, constant: -16),
            foodTitle.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
        foodTitle.setContentHuggingPriority(.init(240.0), for: .horizontal)
        foodTitle.setContentCompressionResistancePriority(.init(740.0), for: .horizontal)
    }
    
    func setupFavouriteButtonConstraints() {
        NSLayoutConstraint.activate([
            favouriteButton.centerYAnchor.constraint(equalTo: foodTitle.centerYAnchor),
            favouriteButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
        ])
    }
    
    func addSubview() {
        addSubview(containerView)
        containerView.addSubview(foodImage)
        containerView.addSubview(foodTitle)
        containerView.addSubview(favouriteButton)
    }
    
    func layoutUI() {
        addSubview()
        setupContainerView()
        setupFoodImage()
        setupFoodTitle()
        setupFavouriteButtonConstraints()
    }
    
}
