//
//  AboutUsView.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 4/25/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation
import UIKit

class AboutUsView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate let widthConstant: CGFloat = 1.3
    
    lazy var cookbookLabel: UILabel = {
        let cookbookLabel = UILabel()
        cookbookLabel.text = "COOKBOOK"
        cookbookLabel.textColor = .customDarkGray()
        cookbookLabel.font = UIFont(name: "AvenirNext-Bold", size: 28)
        cookbookLabel.translatesAutoresizingMaskIntoConstraints = false
        return cookbookLabel
    }()
    
    func setupCookbookLabelConstraints() {
        NSLayoutConstraint.activate([
            cookbookLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            cookbookLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
    }
    
    lazy var cookingImage: UIImageView = {
        let cookingImage = UIImageView()
        cookingImage.image = UIImage(named: "cookingvector")
        cookingImage.contentMode = .scaleAspectFill
        cookingImage.clipsToBounds = true
        cookingImage.translatesAutoresizingMaskIntoConstraints = false
        return cookingImage
    }()
    
    func setupCookingImageConstraints() {
        NSLayoutConstraint.activate([
            cookingImage.topAnchor.constraint(equalTo: cookbookLabel.bottomAnchor, constant: 16),
            cookingImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            cookingImage.widthAnchor.constraint(equalToConstant: (self.frame.width / 2) + 50),
            cookingImage.heightAnchor.constraint(equalToConstant: (self.frame.width / 2) + 50)
        ])
    }
    
    lazy var aboutCookbookLabel: UILabel = {
        let aboutCookbookLabel = UILabel()
        aboutCookbookLabel.text = "This application was developed specifically to help everyone to cook what they love simply and smoothly by viewing the ingredients, the amount of ingredients, and steps of the recipe, and also helping those who are afraid of burning food."
        aboutCookbookLabel.textColor = .customLightDarkGray()
        aboutCookbookLabel.numberOfLines = 0
        aboutCookbookLabel.font = UIFont(name: "AvenirNext-Medium", size: 16)
        aboutCookbookLabel.translatesAutoresizingMaskIntoConstraints = false
        return aboutCookbookLabel
    }()
    
    func setupAboutCookbookLabelConstraints() {
        NSLayoutConstraint.activate([
            aboutCookbookLabel.topAnchor.constraint(equalTo: cookingImage.bottomAnchor, constant: 16),
            aboutCookbookLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            aboutCookbookLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    lazy var informationLabel: UILabel = {
        let informationLabel = UILabel()
        informationLabel.text = "If you have a question, faced a problem, or want to request future features. You can email us"
        informationLabel.textColor = .customDarkGray()
        informationLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        informationLabel.numberOfLines = 0
        informationLabel.translatesAutoresizingMaskIntoConstraints = false
        return informationLabel
    }()
    
    func setupInformationLabelConstraints() {
        NSLayoutConstraint.activate([
            informationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            informationLabel.topAnchor.constraint(equalTo: aboutCookbookLabel.bottomAnchor, constant: 16),
            informationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    lazy var sendEmailButton: UIButton = {
        let sendEmailButton = UIButton(type: .system)
        sendEmailButton.setTitle("Search recipe", for: .normal)
        sendEmailButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 14)
        sendEmailButton.backgroundColor = .CustomGreen()
        sendEmailButton.setTitleColor(.white, for: .normal)
        sendEmailButton.layer.cornerRadius = 8.0
        sendEmailButton.translatesAutoresizingMaskIntoConstraints = false
        return sendEmailButton
    }()
    
    func setupSendEmailButtonConstraints() {
        NSLayoutConstraint.activate([
            sendEmailButton.topAnchor.constraint(equalTo: informationLabel.bottomAnchor, constant: 16),
            sendEmailButton.heightAnchor.constraint(equalToConstant: 55),
            sendEmailButton.widthAnchor.constraint(equalToConstant: frame.width / widthConstant),
            sendEmailButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func addSubviews() {
        addSubview(cookbookLabel)
        addSubview(cookingImage)
        addSubview(aboutCookbookLabel)
        addSubview(informationLabel)
        addSubview(sendEmailButton)
    }
    
    func layoutUI() {
        addSubviews()
        setupCookbookLabelConstraints()
        setupCookingImageConstraints()
        setupAboutCookbookLabelConstraints()
        setupInformationLabelConstraints()
        setupSendEmailButtonConstraints()
    }
    
}
