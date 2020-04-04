//
//  SignInView.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 2/18/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation
import UIKit
import Material

@objc protocol SignInDelegate: class {
    @objc func loginButtonTapped()
    @objc func registerButtonTapped()
    @objc func forgetPasswordButtonTapped()
    @objc func facebookButtonTapped()
    @objc func twitterButtonTapped()
}

class SignInView: UIView {
    private let loginStackView = UIStackView()
    private let socialLoginStackView = UIStackView()
    private let widthConstant: CGFloat = 1.3
    private let height: CGFloat = 55
    private let gradientColor = CAGradientLayer()
    
    private weak var delegate: SignInDelegate!
    
    init(delegate: SignInDelegate, frame: CGRect) {
        super.init(frame: frame)
        self.delegate = delegate
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var userEmail: String {
        return emailTxtField.text!
    }
    
    var userPassword: String {
        return passwordTxtField.text!
    }
    
    private func addSubviews() {
        addSubview(loginStackView)
        loginStackView.addArrangedSubview(viewName)
        loginStackView.addArrangedSubview(emailTxtField)
        loginStackView.addArrangedSubview(passwordTxtField)
        loginStackView.addArrangedSubview(loginButton)
        loginStackView.addArrangedSubview(registerBtn)
        loginStackView.addArrangedSubview(socialLoginStackView)
        socialLoginStackView.addArrangedSubview(facebookBtn)
        socialLoginStackView.addArrangedSubview(twitterBtn)
        socialLoginStackView.addArrangedSubview(appleBtn)
        loginStackView.addArrangedSubview(forgetPasswordBtn)
        
    }
    
    private lazy var viewName: UILabel = {
        let viewName = UILabel()
        viewName.text = "Sign In"
        viewName.font = UIFont(name: "AvenirNext-Bold", size: 36)
        viewName.textColor = .customDarkGray()
        viewName.textAlignment = .left
        return viewName
    }()
    
    private lazy var emailTxtField: UITextField = {
        let emailTextField = ErrorTextField()
        emailTextField.backgroundColor = .white
        emailTextField.placeholder = "Enter email"
        emailTextField.keyboardType = .emailAddress
        emailTextField.layer.cornerRadius = 8.0
        emailTextField.isClearIconButtonEnabled = true
        emailTextField.isPlaceholderUppercasedWhenEditing = false
        emailTextField.placeholderAnimation = .default
        emailTextField.placeholderActiveColor = .gray
        emailTextField.detailColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        emailTextField.dividerActiveColor = .CustomGreen()
        emailTextField.autocapitalizationType = .none
        emailTextField.placeholderLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        emailTextField.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        emailTextField.placeholderNormalColor = .customDarkGray()
        return emailTextField
    }()
    
    private lazy var passwordTxtField: UITextField = {
        let passwordTextField = ErrorTextField()
        passwordTextField.backgroundColor = .white
        passwordTextField.placeholder = "Enter password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.keyboardType = .default
        passwordTextField.layer.cornerRadius = 8.0
        passwordTextField.isClearIconButtonEnabled = true
        passwordTextField.isPlaceholderUppercasedWhenEditing = false
        passwordTextField.placeholderAnimation = .default
        passwordTextField.placeholderActiveColor = .gray
        passwordTextField.detailColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        passwordTextField.dividerActiveColor = .CustomGreen()
        passwordTextField.placeholderLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        passwordTextField.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        passwordTextField.placeholderNormalColor = .customDarkGray()
        return passwordTextField
    }()
    
    private lazy var loginButton: UIButton = {
        let loginButton = UIButton(type: .system)
        loginButton.setTitle("Sign In", for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 14)
        loginButton.backgroundColor = .CustomGreen()
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 8.0
        loginButton.addTarget(delegate, action: #selector(delegate.loginButtonTapped), for: .touchUpInside)
        return loginButton
    }()
    
    private lazy var registerBtn: UIButton = {
        let registerButton = UIButton(type: .system)
        registerButton.setTitle("Creat account", for: .normal)
        registerButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 14)
        registerButton.backgroundColor = .customDarkGray()
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.layer.cornerRadius = 8.0
        registerButton.addTarget(delegate, action: #selector(delegate.registerButtonTapped), for: .touchUpInside)
        return registerButton
    }()
    
    private lazy var facebookBtn: UIButton = {
        let facebookButton = UIButton()
        facebookButton.setImage(UIImage(named: "facebook"), for: .normal)
        facebookButton.backgroundColor = #colorLiteral(red: 0.1803921569, green: 0.2705882353, blue: 0.5294117647, alpha: 1)
        facebookButton.layer.cornerRadius = 8.0
        facebookButton.addTarget(delegate, action: #selector(delegate.facebookButtonTapped), for: .touchUpInside)
        return facebookButton
    }()
    
    private lazy var twitterBtn: UIButton = {
        let twitterButton = UIButton()
        twitterButton.setImage(UIImage(named: "twitter"), for: .normal)
        twitterButton.backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.5568627451, blue: 0.9333333333, alpha: 1)
        twitterButton.layer.cornerRadius = 8.0
        twitterButton.addTarget(delegate, action: #selector(delegate.twitterButtonTapped), for: .touchUpInside)
        return twitterButton
    }()
    
    private lazy var appleBtn: UIButton = {
        let appleButton = UIButton()
        appleButton.setImage(UIImage(named: "apple"), for: .normal)
        appleButton.backgroundColor = #colorLiteral(red: 0.1450980392, green: 0.1450980392, blue: 0.1450980392, alpha: 1)
        appleButton.layer.cornerRadius = 8.0
        return appleButton
    }()
    
    private lazy var forgetPasswordBtn: UIButton = {
        let forgetPasswordButton = UIButton()
        forgetPasswordButton.setTitle("Forget your password?", for: .normal)
        forgetPasswordButton.setTitleColor(.CustomGreen(), for: .normal)
        forgetPasswordButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 14)
        forgetPasswordButton.addTarget(delegate, action: #selector(delegate.forgetPasswordButtonTapped), for: .touchUpInside)
        return forgetPasswordButton
    }()
    
    
    
    private func setupViewName() {
        NSLayoutConstraint.activate([
            viewName.leadingAnchor.constraint(equalTo: loginStackView.leadingAnchor),
            viewName.trailingAnchor.constraint(equalTo: loginStackView.trailingAnchor)
        ])
    }
    
    private func setupEmailConstraints() {
        NSLayoutConstraint.activate([
            emailTxtField.leadingAnchor.constraint(equalTo: loginStackView.leadingAnchor),
            emailTxtField.trailingAnchor.constraint(equalTo: loginStackView.trailingAnchor),
            emailTxtField.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    private func setupPasswordConstraints() {
        NSLayoutConstraint.activate([
            passwordTxtField.leadingAnchor.constraint(equalTo: loginStackView.leadingAnchor),
            passwordTxtField.trailingAnchor.constraint(equalTo: loginStackView.trailingAnchor),
            passwordTxtField.heightAnchor.constraint(equalToConstant: height)
        ])
        
    }
    
    private func setupLoginConstraints() {
        NSLayoutConstraint.activate([
            loginButton.heightAnchor.constraint(equalToConstant: height),
            loginButton.widthAnchor.constraint(equalToConstant: frame.width / widthConstant)
        ])
    }
    
    private func setupRegisterConstraints() {
        NSLayoutConstraint.activate([
            registerBtn.heightAnchor.constraint(equalToConstant: height),
            registerBtn.widthAnchor.constraint(equalToConstant: frame.width / widthConstant)
        ])
    }
    
    private func setupLoginStackView() {
        loginStackView.axis = .vertical
        loginStackView.distribution = .fill
        loginStackView.alignment = .fill
        loginStackView.spacing = 25
        loginStackView.translatesAutoresizingMaskIntoConstraints = false
        setupLoginStackViewConstraint()
    }
    
    private func setupLoginStackViewConstraint() {
        NSLayoutConstraint.activate([
            loginStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            loginStackView.widthAnchor.constraint(equalToConstant: frame.width / widthConstant)
        ])
    }
    
    private func setupFacebookButtonConstraints() {
        NSLayoutConstraint.activate([
            facebookBtn.heightAnchor.constraint(equalToConstant: frame.width / 6)
        ])
    }
    
    private func setupTwitterButtonConstraints() {
        NSLayoutConstraint.activate([
            twitterBtn.heightAnchor.constraint(equalToConstant: frame.width / 6)
        ])
    }
    
    private func setupAppleButtonConstraints() {
        NSLayoutConstraint.activate([
            appleBtn.heightAnchor.constraint(equalToConstant: frame.width / 6)
        ])
    }
    
    private func setupSocialLoginStackView() {
        socialLoginStackView.axis = .horizontal
        socialLoginStackView.distribution = .fillEqually
        socialLoginStackView.alignment = .center
        socialLoginStackView.spacing = frame.width / 8
        setupSocialLoginStackViewConstraint()
    }
    
    private func setupSocialLoginStackViewConstraint() {
        NSLayoutConstraint.activate([
            socialLoginStackView.leadingAnchor.constraint(equalTo: loginStackView.leadingAnchor),
            socialLoginStackView.trailingAnchor.constraint(equalTo: loginStackView.trailingAnchor),
            socialLoginStackView.widthAnchor.constraint(equalToConstant: frame.width / widthConstant),
            socialLoginStackView.heightAnchor.constraint(equalToConstant: frame.width / 6)
        ])
    }
    
    private func setupForgetPasswordButtonConstraints() {
        NSLayoutConstraint.activate([
            forgetPasswordBtn.leadingAnchor.constraint(equalTo: loginStackView.leadingAnchor),
            forgetPasswordBtn.trailingAnchor.constraint(equalTo: loginStackView.trailingAnchor)
        ])
    }
    
    private func dismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)
    }
    
    private func checkTxtFields() {
        loginButton.isEnabled = false
        loginButton.alpha = 0.4
        emailTxtField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        passwordTxtField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
    }
    
    @objc private func editingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let email = emailTxtField.text, !email.isEmpty,
            let password = passwordTxtField.text, !password.isEmpty
            else {
                loginButton.isEnabled = false
                loginButton.alpha = 0.4
                return
        }
        loginButton.isEnabled = true
        loginButton.alpha = 1.0
    }
    
    private func layoutUI() {
        addSubviews()
        setupLoginConstraints()
        setupRegisterConstraints()
        setupLoginStackView()
        setupViewName()
        setupEmailConstraints()
        setupPasswordConstraints()
        dismissKeyboard()
        setupSocialLoginStackView()
        setupFacebookButtonConstraints()
        setupTwitterButtonConstraints()
        setupAppleButtonConstraints()
        setupForgetPasswordButtonConstraints()
        checkTxtFields()
    }
}

extension SignInView: TextFieldDelegate {
    public func textFieldDidEndEditing(_ textField: UITextField) {
        (textField as? ErrorTextField)?.isErrorRevealed = false
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        (textField as? ErrorTextField)?.isErrorRevealed = false
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        (textField as? ErrorTextField)?.isErrorRevealed = true
        return true
    }
}
