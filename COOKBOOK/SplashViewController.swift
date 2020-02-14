//
//  SplashViewController.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 2/10/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    fileprivate let stackView = UIStackView()
    fileprivate let widthConstant: CGFloat = 1.3
    fileprivate let spacing: CGFloat = 25

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupBackgroundImage()
        setupAppNameLbl()
        setupAppDescriptionTextView()
        setupStackView()
        setupStackViewConstraints()
        setupGetStartedButton()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    fileprivate let backgroundImage: UIImageView = {
        let bg = UIImageView()
        bg.image = UIImage(named: "SplashBackground")
        bg.contentMode = .scaleToFill
        return bg
    }()
    
    fileprivate func setupBackgroundImage() {
        view.addSubview(backgroundImage)
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        backgroundImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    fileprivate let appName: UILabel = {
        let appNameLbl = UILabel()
        appNameLbl.text = "COOKBOOK"
        appNameLbl.textColor = .white
        appNameLbl.font = UIFont(name: "AvenirNext-Heavy", size: 36)
        appNameLbl.textAlignment = .left
        return appNameLbl
    }()
    
    fileprivate func setupAppNameLbl() {
        view.addSubview(appName)
        appName.translatesAutoresizingMaskIntoConstraints = false

    }
    
    fileprivate let appDescription: UITextView = {
        let appDescriptionTextView = UITextView()
        appDescriptionTextView.text = "COOKBOOK COOKBOOK COOKBOOK COOKBOOK COOKBOOK COOKBOOK COOKBOOKasdasdasdasdasdasdasdaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
        appDescriptionTextView.textColor = .black
        appDescriptionTextView.backgroundColor = .none
        appDescriptionTextView.textAlignment = .left
        appDescriptionTextView.isEditable = false
        appDescriptionTextView.isSelectable = false
        appDescriptionTextView.isScrollEnabled = false
        appDescriptionTextView.textContainer.maximumNumberOfLines = 0
        appDescriptionTextView.font = UIFont(name: "AvenirNext-Regular", size: 14)
        return appDescriptionTextView
    }()
    
    fileprivate func setupAppDescriptionTextView() {
        view.addSubview(appDescription)
        appDescription.translatesAutoresizingMaskIntoConstraints = false
    }
    
    fileprivate let getStartedBtn: UIButton = {
        let getStartedButton = UIButton()
        getStartedButton.setTitle("Get Started", for: .normal)
        getStartedButton.setTitleColor(.CustomGreen(), for: .normal)
        getStartedButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 14)
        getStartedButton.backgroundColor = .white
        getStartedButton.layer.cornerRadius = 6.0
        getStartedButton.addTarget(self, action: #selector(goToLoginView(_:)), for: .touchUpInside)
        return getStartedButton
    }()
    
    fileprivate func setupGetStartedButton() {
        view.addSubview(getStartedBtn)
        getStartedBtn.translatesAutoresizingMaskIntoConstraints = false
        getStartedBtn.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: spacing).isActive = true
        getStartedBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        getStartedBtn.widthAnchor.constraint(equalToConstant: view.frame.width / widthConstant).isActive = true
        getStartedBtn.heightAnchor.constraint(equalToConstant: 55).isActive = true
    }
    
    @objc func goToLoginView(_ sender: Any){
        let loginView = SignInViewController()
        setupNavigation()
        self.show(loginView, sender: nil)
    }
    
    fileprivate func setupStackView() {
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = spacing
    }
    
    fileprivate func setupStackViewConstraints() {
        view.addSubview(stackView)
        view.bringSubviewToFront(stackView)
        stackView.addArrangedSubview(appName)
        stackView.addArrangedSubview(appDescription)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: view.frame.width / widthConstant).isActive = true
    }
    
    fileprivate func setupNavigation() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        backItem.tintColor = .CustomGreen()
        navigationItem.backBarButtonItem = backItem
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.CustomGreen()]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
}
