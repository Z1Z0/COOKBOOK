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
    @objc func skipButtonTapped()
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
//        loginStackView.addArrangedSubview(socialLoginStackView)
//        socialLoginStackView.addArrangedSubview(facebookBtnContainer)
//        facebookBtnContainer.addSubview(facebookBtn)
//        socialLoginStackView.addArrangedSubview(appleBtnContainer)
//        appleBtnContainer.addSubview(appleBtn)
        loginStackView.addArrangedSubview(forgetPasswordBtn)
        addSubview(skipBtn)
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
        loginButton.setTitle("Sign in", for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 14)
        loginButton.backgroundColor = .CustomGreen()
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 8.0
        loginButton.addTarget(delegate, action: #selector(delegate.loginButtonTapped), for: .touchUpInside)
        return loginButton
    }()
    
    private lazy var registerBtn: UIButton = {
        let registerButton = UIButton(type: .system)
        registerButton.setTitle("Create account", for: .normal)
        registerButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 14)
        registerButton.backgroundColor = .customDarkGray()
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.layer.cornerRadius = 8.0
        registerButton.addTarget(delegate, action: #selector(delegate.registerButtonTapped), for: .touchUpInside)
        return registerButton
    }()
    
    private lazy var facebookBtnContainer: UIView = {
        let facebookBtnContainer = UIView()
        facebookBtnContainer.backgroundColor = .clear
        facebookBtnContainer.translatesAutoresizingMaskIntoConstraints = false
        return facebookBtnContainer
    }()
    
    private lazy var facebookBtn: UIButton = {
        let facebookButton = UIButton()
        facebookButton.setImage(UIImage(named: "facebook"), for: .normal)
        facebookButton.backgroundColor = #colorLiteral(red: 0.1803921569, green: 0.2705882353, blue: 0.5294117647, alpha: 1)
        facebookButton.layer.cornerRadius = 8.0
        facebookButton.translatesAutoresizingMaskIntoConstraints = false
        return facebookButton
    }()
    
    private lazy var appleBtnContainer: UIView = {
        let appleBtnContainer = UIView()
        appleBtnContainer.backgroundColor = .clear
        appleBtnContainer.translatesAutoresizingMaskIntoConstraints = false
        return appleBtnContainer
    }()
    
    private lazy var appleBtn: UIButton = {
        let appleButton = UIButton()
        appleButton.setImage(UIImage(named: "apple"), for: .normal)
        appleButton.backgroundColor = #colorLiteral(red: 0.1450980392, green: 0.1450980392, blue: 0.1450980392, alpha: 1)
        appleButton.layer.cornerRadius = 8.0
        appleButton.translatesAutoresizingMaskIntoConstraints = false
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
    
    private lazy var skipBtn: UIButton = {
        let skipBtn = UIButton()
        skipBtn.setTitle("Skip to try cookbook without registration", for: .normal)
        skipBtn.setTitleColor(.customDarkGray(), for: .normal)
        skipBtn.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 12)
        skipBtn.addTarget(delegate, action: #selector(delegate.skipButtonTapped), for: .touchUpInside)
        skipBtn.translatesAutoresizingMaskIntoConstraints = false
        return skipBtn
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
            facebookBtn.heightAnchor.constraint(equalToConstant: frame.width / 6),
            facebookBtn.widthAnchor.constraint(equalToConstant: frame.width / 6),
            facebookBtn.centerXAnchor.constraint(equalTo: facebookBtnContainer.centerXAnchor),
            facebookBtn.centerYAnchor.constraint(equalTo: facebookBtnContainer.centerYAnchor)
        ])
    }
    
    private func setupFacebookButtonContainerConstraints() {
        NSLayoutConstraint.activate([
            facebookBtnContainer.heightAnchor.constraint(equalToConstant: frame.width / 6)
        ])
    }
    
    private func setupAppleButtonConstraints() {
        NSLayoutConstraint.activate([
            appleBtn.heightAnchor.constraint(equalToConstant: frame.width / 6),
            appleBtn.widthAnchor.constraint(equalToConstant: frame.width / 6),
            appleBtn.centerXAnchor.constraint(equalTo: appleBtnContainer.centerXAnchor),
            appleBtn.centerYAnchor.constraint(equalTo: appleBtnContainer.centerYAnchor)
        ])
    }
    
    private func setupAppleButtonContainerConstraints() {
        NSLayoutConstraint.activate([
            appleBtnContainer.heightAnchor.constraint(equalToConstant: frame.width / 6)
        ])
    }
    
    private func setupSocialLoginStackView() {
        socialLoginStackView.axis = .horizontal
        socialLoginStackView.distribution = .fillEqually
        socialLoginStackView.alignment = .center
        socialLoginStackView.spacing = 20
        setupSocialLoginStackViewConstraint()
    }
    
    private func setupSocialLoginStackViewConstraint() {
        NSLayoutConstraint.activate([
//            socialLoginStackView.leadingAnchor.constraint(equalTo: loginStackView.leadingAnchor),
//            socialLoginStackView.trailingAnchor.constraint(equalTo: loginStackView.trailingAnchor),
//            socialLoginStackView.widthAnchor.constraint(equalToConstant: frame.width / widthConstant),
//            socialLoginStackView.heightAnchor.constraint(equalToConstant: frame.width / 6)
        ])
    }
    
    private func setupForgetPasswordButtonConstraints() {
        NSLayoutConstraint.activate([
            forgetPasswordBtn.leadingAnchor.constraint(equalTo: loginStackView.leadingAnchor),
            forgetPasswordBtn.trailingAnchor.constraint(equalTo: loginStackView.trailingAnchor)
        ])
    }
    
    private func setupSkipButtonConstraints() {
        NSLayoutConstraint.activate([
//            skipBtn.leadingAnchor.constraint(equalTo: forgetPasswordBtn.leadingAnchor),
//            skipBtn.trailingAnchor.constraint(equalTo: forgetPasswordBtn.trailingAnchor)
            skipBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            skipBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            skipBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32)
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
//        setupSocialLoginStackView()
//        setupFacebookButtonContainerConstraints()
//        setupFacebookButtonConstraints()
//        setupAppleButtonContainerConstraints()
//        setupAppleButtonConstraints()
        setupForgetPasswordButtonConstraints()
        setupSkipButtonConstraints()
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
