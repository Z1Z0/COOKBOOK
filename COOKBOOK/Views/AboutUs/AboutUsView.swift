//
//  AboutUsView.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 4/25/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation
import UIKit

@objc protocol GoToAboutUsDelegate: class {
    @objc func goToAboutUs()
}

class AboutUsView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate let widthConstant: CGFloat = 1.3
    weak var delegate: GoToAboutUsDelegate?
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    func setupScrollViewConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
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
            cookbookLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16)
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
        aboutCookbookLabel.textColor = .customLightDarkGray()
        aboutCookbookLabel.numberOfLines = 0
        aboutCookbookLabel.font = UIFont(name: "AvenirNext-Medium", size: 16)
        aboutCookbookLabel.translatesAutoresizingMaskIntoConstraints = false
        return aboutCookbookLabel
    }()
    
    func setupAboutCookbookLabelConstraints() {
        NSLayoutConstraint.activate([
            aboutCookbookLabel.topAnchor.constraint(equalTo: cookingImage.bottomAnchor, constant: 16),
            aboutCookbookLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            aboutCookbookLabel.widthAnchor.constraint(equalToConstant: frame.width / widthConstant)
        ])
    }
    
    lazy var informationLabel: UILabel = {
        let informationLabel = UILabel()
        informationLabel.textColor = .customDarkGray()
        informationLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        informationLabel.numberOfLines = 0
        informationLabel.translatesAutoresizingMaskIntoConstraints = false
        return informationLabel
    }()
    
    func setupInformationLabelConstraints() {
        NSLayoutConstraint.activate([
            informationLabel.topAnchor.constraint(equalTo: aboutCookbookLabel.bottomAnchor, constant: 16),
            informationLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            informationLabel.widthAnchor.constraint(equalToConstant: frame.width / widthConstant)
        ])
    }
    
    lazy var sendEmailButton: UIButton = {
        let sendEmailButton = UIButton(type: .system)
        sendEmailButton.setTitle("Contact us", for: .normal)
        sendEmailButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 14)
        sendEmailButton.backgroundColor = .CustomGreen()
        sendEmailButton.setTitleColor(.white, for: .normal)
        sendEmailButton.layer.cornerRadius = 8.0
        sendEmailButton.addTarget(delegate, action: #selector(delegate?.goToAboutUs), for: .touchUpInside)
        sendEmailButton.translatesAutoresizingMaskIntoConstraints = false
        return sendEmailButton
    }()
    
    func setupSendEmailButtonConstraints() {
        NSLayoutConstraint.activate([
            sendEmailButton.topAnchor.constraint(equalTo: informationLabel.bottomAnchor, constant: 16),
            sendEmailButton.heightAnchor.constraint(equalToConstant: 55),
            sendEmailButton.widthAnchor.constraint(equalToConstant: frame.width / widthConstant),
            sendEmailButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            sendEmailButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16)
        ])
    }
    
    func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(cookbookLabel)
        scrollView.addSubview(cookingImage)
        scrollView.addSubview(aboutCookbookLabel)
        scrollView.addSubview(informationLabel)
        scrollView.addSubview(sendEmailButton)
    }
    
    func layoutUI() {
        addSubviews()
        setupScrollViewConstraints()
        setupCookbookLabelConstraints()
        setupCookingImageConstraints()
        setupAboutCookbookLabelConstraints()
        setupInformationLabelConstraints()
        setupSendEmailButtonConstraints()
    }
    
}