//
//  SplashView.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 2/18/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation
import UIKit

@objc protocol SplashViewDelegate: class {
    @objc func registerButtonTapped()
}

class SplashView: UIView {
    
    private let stackView = UIStackView()
    private let widthConstant: CGFloat = 1.3
    private let spacing: CGFloat = 25
    private weak var delegate: SplashViewDelegate!
    
    private lazy var backgroundImage: UIImageView = {
        let bg = UIImageView()
        bg.translatesAutoresizingMaskIntoConstraints = false
        bg.image = UIImage(named: "SplashBackground")
        bg.contentMode = .scaleToFill
        return bg
    }()
    
    private lazy var appName: UILabel = {
        let appNameLbl = UILabel()
        appNameLbl.translatesAutoresizingMaskIntoConstraints = false
        appNameLbl.text = "COOKBOOK"
        appNameLbl.textColor = .white
        appNameLbl.font = UIFont(name: "AvenirNext-Heavy", size: 36)
        appNameLbl.textAlignment = .left
        return appNameLbl
    }()
    
    lazy var appDescription: UITextView = {
        let appDescriptionTextView = UITextView()
        appDescriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        appDescriptionTextView.textColor = .white
        appDescriptionTextView.backgroundColor = .none
        appDescriptionTextView.textAlignment = .left
        appDescriptionTextView.isEditable = false
        appDescriptionTextView.isSelectable = false
        appDescriptionTextView.isScrollEnabled = false
        appDescriptionTextView.textContainer.maximumNumberOfLines = 0
        appDescriptionTextView.font = UIFont(name: "AvenirNext-Regular", size: 14)
        return appDescriptionTextView
    }()
    
    private lazy var getStartedBtn: UIButton = {
        let getStartedButton = UIButton()
        getStartedButton.translatesAutoresizingMaskIntoConstraints = false
        getStartedButton.setTitle("Get Started", for: .normal)
        getStartedButton.setTitleColor(.CustomGreen(), for: .normal)
        getStartedButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 14)
        getStartedButton.backgroundColor = .white
        getStartedButton.layer.cornerRadius = 6.0
        getStartedButton.addTarget(delegate, action: #selector(delegate.registerButtonTapped), for: .touchUpInside)
        return getStartedButton
    }()
    
    init(delegate: SplashViewDelegate, frame: CGRect) {
        super.init(frame: frame)
        self.delegate = delegate
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = spacing
    }
    
    private func addSubviews() {
        addSubview(backgroundImage)
        addSubview(appName)
        addSubview(appDescription)
        addSubview(stackView)
        bringSubviewToFront(stackView)
        stackView.addArrangedSubview(appName)
        stackView.addArrangedSubview(appDescription)
        addSubview(getStartedBtn)
    }
    
    private func setupStackViewConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            stackView.widthAnchor.constraint(equalToConstant: frame.width / widthConstant)
        ])
    }
    
    private func setupBackgroundImageConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            backgroundImage.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
    
    private func setupGetStartedButtonConstraints() {
        NSLayoutConstraint.activate([
            getStartedBtn.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: spacing),
            getStartedBtn.centerXAnchor.constraint(equalTo: centerXAnchor),
            getStartedBtn.widthAnchor.constraint(equalToConstant: frame.width / widthConstant),
            getStartedBtn.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    private func layoutUI() {
        addSubviews()
        setupStackView()
        setupStackViewConstraints()
        setupBackgroundImageConstraints()
        setupGetStartedButtonConstraints()
    }
}
