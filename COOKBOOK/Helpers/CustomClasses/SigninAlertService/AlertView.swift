//
//  AlertView.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 6/17/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation
import UIKit
import Material

@objc protocol AlertDelegateAction: class {
    @objc func dismissVC()
    @objc func signinUser()
}

class AlertView: UIView {
    
    weak var delegate: AlertDelegateAction?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
        LayoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var userEmail: String {
        return emailTxtField.text ?? "Error"
    }
    
    var userPassword: String {
        return passwordTxtField.text ?? "Error"
    }
    
    lazy var containerView: UIView = {
        let container = UIView()
        container.backgroundColor = .darkGray
        container.layer.cornerRadius = 8.0
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    func setupContainerView() {
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: self.frame.width - 100),
            containerView.heightAnchor.constraint(equalToConstant: self.frame.height / 3 + 40),
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    lazy var loginLabel: UILabel = {
        let loginLabel = UILabel()
        loginLabel.text = "Sign In"
        loginLabel.textColor = .white
        loginLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        return loginLabel
    }()
    
    func setupLoginLabelConstraints() {
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            loginLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            loginLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])
    }
    
    private lazy var emailTxtField: UITextField = {
        let emailTextField = ErrorTextField()
        emailTextField.backgroundColor = .clear
        emailTextField.textColor = .white
        emailTextField.placeholder = "Enter email"
        emailTextField.keyboardType = .emailAddress
        emailTextField.layer.cornerRadius = 8.0
        emailTextField.isPlaceholderUppercasedWhenEditing = false
        emailTextField.placeholderAnimation = .default
        emailTextField.placeholderActiveColor = .CustomGreen()
        emailTextField.detailColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        emailTextField.autocapitalizationType = .none
        emailTextField.dividerActiveColor = .CustomGreen()
        emailTextField.dividerNormalColor = .white
        emailTextField.placeholderLabel.font = UIFont(name: "AvenirNext-Medium", size: 14)
        emailTextField.font = UIFont(name: "AvenirNext-Medium", size: 14)
        emailTextField.placeholderNormalColor = .white
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        return emailTextField
    }()
    
    func setupEmailTxtFieldConstraints() {
        NSLayoutConstraint.activate([
            emailTxtField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 32),
            emailTxtField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            emailTxtField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            emailTxtField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private lazy var passwordTxtField: UITextField = {
        let passwordTextField = ErrorTextField()
        passwordTextField.backgroundColor = .clear
        passwordTextField.textColor = .white
        passwordTextField.placeholder = "Enter password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.keyboardType = .default
        passwordTextField.layer.cornerRadius = 8.0
        passwordTextField.isPlaceholderUppercasedWhenEditing = false
        passwordTextField.placeholderAnimation = .default
        passwordTextField.placeholderActiveColor = .CustomGreen()
        passwordTextField.detailColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        passwordTextField.dividerActiveColor = .CustomGreen()
        passwordTextField.dividerNormalColor = .white
        passwordTextField.placeholderLabel.font = UIFont(name: "AvenirNext-Medium", size: 14)
        passwordTextField.font = UIFont(name: "AvenirNext-Medium", size: 14)
        passwordTextField.placeholderNormalColor = .white
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        return passwordTextField
    }()
    
    func setupPasswordTxtFieldConstraints() {
        NSLayoutConstraint.activate([
            passwordTxtField.topAnchor.constraint(equalTo: emailTxtField.bottomAnchor, constant: 32),
            passwordTxtField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            passwordTxtField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            passwordTxtField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    lazy var signinButton: UIButton = {
        let signinButton = UIButton(type: .system)
        signinButton.backgroundColor = .CustomGreen()
        signinButton.setTitle("Sign in", for: .normal)
        signinButton.setTitleColor(.white, for: .normal)
        signinButton.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        signinButton.layer.cornerRadius = 8.0
        signinButton.addTarget(delegate, action: #selector(delegate?.signinUser), for: .touchUpInside)
        signinButton.translatesAutoresizingMaskIntoConstraints = false
        return signinButton
    }()
    
    func setupSigninButtonConstraints() {
        NSLayoutConstraint.activate([
            signinButton.topAnchor.constraint(equalTo: passwordTxtField.bottomAnchor, constant: 32),
            signinButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            signinButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            signinButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    lazy var cancelButton: UIButton = {
        let cancelButton = UIButton(type: .system)
        cancelButton.backgroundColor = .systemRed
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        cancelButton.layer.cornerRadius = 8.0
        cancelButton.addTarget(delegate, action: #selector(delegate?.dismissVC), for: .touchUpInside)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        return cancelButton
    }()
    
    func setupCancelButtonConstraints() {
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: signinButton.bottomAnchor, constant: 16),
            cancelButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            cancelButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            cancelButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(loginLabel)
        containerView.addSubview(emailTxtField)
        containerView.addSubview(passwordTxtField)
        containerView.addSubview(signinButton)
        containerView.addSubview(cancelButton)
    }
    
    func LayoutUI() {
        addSubviews()
        setupContainerView()
        setupLoginLabelConstraints()
        setupEmailTxtFieldConstraints()
        setupPasswordTxtFieldConstraints()
        setupSigninButtonConstraints()
        setupCancelButtonConstraints()
    }
    
}
