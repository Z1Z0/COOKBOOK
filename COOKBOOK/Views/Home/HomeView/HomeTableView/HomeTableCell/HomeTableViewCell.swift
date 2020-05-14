//
//  HomeTableViewCell.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 2/23/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit

protocol FavouriteActionDelegate: class {
    func favouriteButtonTapped(_ tag: Int)
}

@objc protocol FavouriteButtonDelegate: class {
    func favouriteBtnTapped(_ sender: UIButton)
}

class HomeTableViewCell: UITableViewCell {

    
    let titlesStackView = UIStackView()
    let titlesInformationStackView = UIStackView()
    weak var delegate: FavouriteActionDelegate?
    weak var buttonTapped: FavouriteButtonDelegate?
    var homeView = HomeView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutUI()
        selectionStyle = .none
        self.backgroundColor = .customVeryLightGray()
    }
    
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
        foodImage.clipsToBounds = true
        return foodImage
    }()
    
    lazy var favouriteButton: UIButton = {
        var favouriteButton = UIButton()
//        let configrations = UIImage.SymbolConfiguration(pointSize: 24)
//        favouriteButton.setImage(UIImage(systemName: "heart", withConfiguration: configrations), for: .normal)
//        favouriteButton.contentMode = .scaleAspectFill
//        favouriteButton.tintColor = .CustomGreen()
        favouriteButton.backgroundColor = .clear
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
        foodTitle.text = "Ahmed"
        foodTitle.numberOfLines = 0
        foodTitle.font = UIFont(name: "AvenirNext-Bold", size: 16)
        foodTitle.translatesAutoresizingMaskIntoConstraints = false
        return foodTitle
    }()
    
    lazy var cookingTimeLabel: UILabel = {
        let cookingTimeLabel = UILabel()
        cookingTimeLabel.text = "Cooking time"
        cookingTimeLabel.adjustsFontSizeToFitWidth = true
        cookingTimeLabel.minimumScaleFactor = 0.5
        cookingTimeLabel.font = UIFont(name: "AvenirNext-Regular", size: 16)
        cookingTimeLabel.textColor = #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        cookingTimeLabel.textAlignment = .center
        cookingTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        return cookingTimeLabel
    }()
    
    lazy var servesLabel: UILabel = {
        let servesLabel = UILabel()
        servesLabel.text = "Serves"
        servesLabel.adjustsFontSizeToFitWidth = true
        servesLabel.minimumScaleFactor = 0.5
        servesLabel.font = UIFont(name: "AvenirNext-Regular", size: 16)
        servesLabel.textColor = #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        servesLabel.textAlignment = .center
        servesLabel.translatesAutoresizingMaskIntoConstraints = false
        return servesLabel
    }()
    
    lazy var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.text = "Price per serving"
        priceLabel.adjustsFontSizeToFitWidth = true
        priceLabel.minimumScaleFactor = 0.5
        priceLabel.font = UIFont(name: "AvenirNext-Regular", size: 16)
        priceLabel.textColor = #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        priceLabel.textAlignment = .center
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        return priceLabel
    }()
    
    func setupStackView() {
        titlesStackView.axis = .horizontal
        titlesStackView.distribution = .fillEqually
        titlesStackView.alignment = .center
        titlesStackView.spacing = 10
        titlesStackView.translatesAutoresizingMaskIntoConstraints = false
        setupStackViewConstraints()
    }
    
    func setupStackViewConstraints() {
        NSLayoutConstraint.activate([
            titlesStackView.topAnchor.constraint(equalTo: foodTitle.bottomAnchor, constant: 16),
            titlesStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titlesStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
    }
    
    lazy var cookingTimeInfoLabel: UILabel = {
        let cookingTimeInfoLabel = UILabel()
        cookingTimeInfoLabel.text = "45 Mins"
        cookingTimeInfoLabel.adjustsFontSizeToFitWidth = true
        cookingTimeInfoLabel.minimumScaleFactor = 0.5
        cookingTimeInfoLabel.font = UIFont(name: "AvenirNext-Regular", size: 16)
        cookingTimeInfoLabel.textColor = .customDarkGray()
        cookingTimeInfoLabel.textAlignment = .center
        cookingTimeInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        return cookingTimeInfoLabel
    }()
    
    lazy var servesInfoLabel: UILabel = {
        let servesInfoLabel = UILabel()
        servesInfoLabel.text = "4 People"
        servesInfoLabel.font = UIFont(name: "AvenirNext-Regular", size: 16)
        servesInfoLabel.textColor = .customDarkGray()
        servesInfoLabel.textAlignment = .center
        servesInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        return servesInfoLabel
    }()
    
    lazy var priceInfoLabel: UILabel = {
        let priceInfoLabel = UILabel()
        priceInfoLabel.text = "$12 - $15"
        priceInfoLabel.font = UIFont(name: "AvenirNext-Regular", size: 16)
        priceInfoLabel.textColor = .CustomGreen()
        priceInfoLabel.textAlignment = .center
        priceInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        return priceInfoLabel
    }()
    
    func setupInfoStackView() {
        titlesInformationStackView.axis = .horizontal
        titlesInformationStackView.distribution = .fillEqually
        titlesInformationStackView.alignment = .center
        titlesInformationStackView.spacing = 10
        titlesInformationStackView.translatesAutoresizingMaskIntoConstraints = false
        setupInfoStackViewConstraints()
    }
    
    func setupInfoStackViewConstraints() {
        NSLayoutConstraint.activate([
            titlesInformationStackView.topAnchor.constraint(equalTo: titlesStackView.bottomAnchor, constant: 8),
            titlesInformationStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            titlesInformationStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titlesInformationStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
    }
    
    func setupContainerView() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
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
        containerView.addSubview(titlesStackView)
        titlesStackView.addArrangedSubview(cookingTimeLabel)
        titlesStackView.addArrangedSubview(servesLabel)
        titlesStackView.addArrangedSubview(priceLabel)
        containerView.addSubview(titlesInformationStackView)
        titlesInformationStackView.addArrangedSubview(cookingTimeInfoLabel)
        titlesInformationStackView.addArrangedSubview(servesInfoLabel)
        titlesInformationStackView.addArrangedSubview(priceInfoLabel)
    }
    
    func layoutUI() {
        addSubview()
        setupContainerView()
        setupFoodImage()
        setupFoodTitle()
        setupFavouriteButtonConstraints()
        setupStackView()
        setupInfoStackView()
    }
    
}
