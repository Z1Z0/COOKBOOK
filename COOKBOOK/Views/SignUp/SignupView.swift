//
//  SignupView.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 2/19/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation
import UIKit
import Material

@objc protocol SignupDelegate: class {
    @objc func registerBtnTapped()
}

class SignupView: UIView {
    
    let signupStackView = UIStackView()
    let socialLoginStackView = UIStackView()
    fileprivate let widthConstant: CGFloat = 1.3
    fileprivate let height: CGFloat = 55
    
    private weak var delegate: SignupDelegate!
    
    init(delegate: SignupDelegate, frame: CGRect) {
        super.init(frame: frame)
        self.delegate = delegate
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(signupStackView)
        signupStackView.addArrangedSubview(viewName)
        signupStackView.addArrangedSubview(usernameTxtField)
        signupStackView.addArrangedSubview(emailTxtField)
        signupStackView.addArrangedSubview(passwordTxtField)
        signupStackView.addArrangedSubview(confirmPasswordTxtField)
        signupStackView.addArrangedSubview(signupButton)
    }
    
    var username: String {
        return usernameTxtField.text!
    }
    
    var userEmail: String {
        return emailTxtField.text!
    }
    
    var userPassword: String {
        return passwordTxtField.text!
    }
    
    var userConfirmPassword: String {
        return confirmPasswordTxtField.text!
    }
    
    let viewName: UILabel = {
        let viewName = UILabel()
        viewName.text = "Create an \nAccount!"
        viewName.numberOfLines = 0
        viewName.font = UIFont(name: "AvenirNext-Bold", size: 36)
        viewName.textColor = .customDarkGray()
        viewName.textAlignment = .left
        return viewName
    }()
    
    func setupViewName() {
        NSLayoutConstraint.activate([
            viewName.leadingAnchor.constraint(equalTo: signupStackView.leadingAnchor),
            viewName.trailingAnchor.constraint(equalTo: signupStackView.trailingAnchor)
        ])
    }
    
    let usernameTxtField: UITextField = {
        let usernameTextField = ErrorTextField()
        usernameTextField.backgroundColor = .white
        usernameTextField.placeholder = "Username"
        usernameTextField.keyboardType = .default
        usernameTextField.layer.cornerRadius = 8.0
        usernameTextField.isClearIconButtonEnabled = true
        usernameTextField.isPlaceholderUppercasedWhenEditing = false
        usernameTextField.placeholderAnimation = .default
        usernameTextField.placeholderActiveColor = .gray
        usernameTextField.detailColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        usernameTextField.dividerActiveColor = #colorLiteral(red: 0.1098039216, green: 0.6196078431, blue: 0.0431372549, alpha: 1)
        usernameTextField.autocapitalizationType = .none
        usernameTextField.placeholderLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        usernameTextField.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        usernameTextField.placeholderNormalColor = .customDarkGray()
        return usernameTextField
    }()
    
    func setupUsernameConstraints() {
        NSLayoutConstraint.activate([
            usernameTxtField.leadingAnchor.constraint(equalTo: signupStackView.leadingAnchor),
            usernameTxtField.trailingAnchor.constraint(equalTo: signupStackView.trailingAnchor),
            usernameTxtField.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    let emailTxtField: UITextField = {
        let emailTextField = ErrorTextField()
        emailTextField.backgroundColor = .white
        emailTextField.placeholder = "Email"
        emailTextField.keyboardType = .emailAddress
        emailTextField.layer.cornerRadius = 8.0
        emailTextField.isClearIconButtonEnabled = true
        emailTextField.isPlaceholderUppercasedWhenEditing = false
        emailTextField.placeholderAnimation = .default
        emailTextField.placeholderActiveColor = .gray
        emailTextField.detailColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        emailTextField.dividerActiveColor = #colorLiteral(red: 0.1098039216, green: 0.6196078431, blue: 0.0431372549, alpha: 1)
        emailTextField.autocapitalizationType = .none
        emailTextField.placeholderLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        emailTextField.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        emailTextField.placeholderNormalColor = .customDarkGray()
        return emailTextField
    }()
    
    func setupEmailConstraints() {
        NSLayoutConstraint.activate([
            emailTxtField.leadingAnchor.constraint(equalTo: signupStackView.leadingAnchor),
            emailTxtField.trailingAnchor.constraint(equalTo: signupStackView.trailingAnchor),
            emailTxtField.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    let passwordTxtField: UITextField = {
        let passwordTextField = ErrorTextField()
        passwordTextField.backgroundColor = .white
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.keyboardType = .default
        passwordTextField.layer.cornerRadius = 8.0
        passwordTextField.isClearIconButtonEnabled = true
        passwordTextField.isPlaceholderUppercasedWhenEditing = false
        passwordTextField.placeholderAnimation = .default
        passwordTextField.placeholderActiveColor = .gray
        passwordTextField.detailColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        passwordTextField.dividerActiveColor = #colorLiteral(red: 0.1098039216, green: 0.6196078431, blue: 0.0431372549, alpha: 1)
        passwordTextField.placeholderLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        passwordTextField.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        passwordTextField.placeholderNormalColor = .customDarkGray()
        return passwordTextField
    }()
    
    func setupPasswordConstraints() {
        NSLayoutConstraint.activate([
            passwordTxtField.leadingAnchor.constraint(equalTo: signupStackView.leadingAnchor),
            passwordTxtField.trailingAnchor.constraint(equalTo: signupStackView.trailingAnchor),
            passwordTxtField.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    let confirmPasswordTxtField: UITextField = {
        let confirmPasswordTextField = ErrorTextField()
        confirmPasswordTextField.backgroundColor = .white
        confirmPasswordTextField.placeholder = "Confirm Password"
        confirmPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.keyboardType = .default
        confirmPasswordTextField.layer.cornerRadius = 8.0
        confirmPasswordTextField.isClearIconButtonEnabled = true
        confirmPasswordTextField.isPlaceholderUppercasedWhenEditing = false
        confirmPasswordTextField.placeholderAnimation = .default
        confirmPasswordTextField.placeholderActiveColor = .gray
        confirmPasswordTextField.detailColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        confirmPasswordTextField.dividerActiveColor = #colorLiteral(red: 0.1098039216, green: 0.6196078431, blue: 0.0431372549, alpha: 1)
        confirmPasswordTextField.placeholderLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        confirmPasswordTextField.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        confirmPasswordTextField.placeholderNormalColor = .customDarkGray()
        return confirmPasswordTextField
    }()
    
    func setupConfirmPasswordConstraints() {
        NSLayoutConstraint.activate([
            confirmPasswordTxtField.leadingAnchor.constraint(equalTo: signupStackView.leadingAnchor),
            confirmPasswordTxtField.trailingAnchor.constraint(equalTo: signupStackView.trailingAnchor),
            confirmPasswordTxtField.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    private lazy var signupButton: UIButton = {
        let signupButton = UIButton(type: .system)
        signupButton.setTitle("Signup", for: .normal)
        signupButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 14)
        signupButton.backgroundColor = .customDarkGray()
        signupButton.setTitleColor(.white, for: .normal)
        signupButton.layer.cornerRadius = 8.0
        signupButton.addTarget(delegate, action: #selector(delegate.registerBtnTapped), for: .touchUpInside)
        return signupButton
    }()
    
    func setupSignupConstraints() {
        NSLayoutConstraint.activate([
            signupButton.heightAnchor.constraint(equalToConstant: height),
            signupButton.widthAnchor.constraint(equalToConstant: frame.width / widthConstant)
        ])
    }
    
    func setupSignupStackView() {
        signupStackView.axis = .vertical
        signupStackView.distribution = .fill
        signupStackView.alignment = .fill
        signupStackView.spacing = 25
        signupStackView.translatesAutoresizingMaskIntoConstraints = false
        setupSignupStackViewConstraint()
    }
    
    func setupSignupStackViewConstraint() {
        NSLayoutConstraint.activate([
            signupStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            signupStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            signupStackView.widthAnchor.constraint(equalToConstant: frame.width / widthConstant)
        ])
        
    }
    
    let facebookBtn: UIButton = {
        let facebookButton = UIButton()
        facebookButton.setImage(UIImage(named: "facebook"), for: .normal)
        facebookButton.backgroundColor = #colorLiteral(red: 0.1803921569, green: 0.2705882353, blue: 0.5294117647, alpha: 1)
        facebookButton.layer.cornerRadius = 8.0
        return facebookButton
    }()
    
    func setupFacebookButtonConstraints() {
        NSLayoutConstraint.activate([
            facebookBtn.heightAnchor.constraint(equalToConstant: frame.width / 6)
        ])
    }
    
    let twitterBtn: UIButton = {
        let twitterButton = UIButton()
        twitterButton.setImage(UIImage(named: "twitter"), for: .normal)
        twitterButton.backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.5568627451, blue: 0.9333333333, alpha: 1)
        twitterButton.layer.cornerRadius = 8.0
        return twitterButton
    }()
    
    func setupTwitterButtonConstraints() {
        NSLayoutConstraint.activate([
            twitterBtn.heightAnchor.constraint(equalToConstant: frame.width / 6)
        ])
        
    }
    
    let appleBtn: UIButton = {
        let appleButton = UIButton()
        appleButton.setImage(UIImage(named: "apple"), for: .normal)
        appleButton.backgroundColor = #colorLiteral(red: 0.1450980392, green: 0.1450980392, blue: 0.1450980392, alpha: 1)
        appleButton.layer.cornerRadius = 8.0
        return appleButton
    }()
    
    func setupAppleButtonConstraints() {
        NSLayoutConstraint.activate([
            appleBtn.heightAnchor.constraint(equalToConstant: frame.width / 6)
        ])
        
    }
    
    func setupSocialLoginStackView() {
        socialLoginStackView.axis = .horizontal
        socialLoginStackView.distribution = .fillEqually
        socialLoginStackView.alignment = .center
        socialLoginStackView.spacing = frame.width / 8
        socialLoginStackView.translatesAutoresizingMaskIntoConstraints = false
        setupSocialLoginStackViewConstraint()
    }
    
    func setupSocialLoginStackViewConstraint() {
        NSLayoutConstraint.activate([
            socialLoginStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            socialLoginStackView.topAnchor.constraint(equalTo: signupStackView.bottomAnchor, constant: 25),
            socialLoginStackView.widthAnchor.constraint(equalToConstant: frame.width / widthConstant),
            socialLoginStackView.heightAnchor.constraint(equalToConstant: frame.width / 6)
        ])
    }
    
    func dismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)
    }
    
    func checkTxtFields() {
        signupButton.isEnabled = false
        signupButton.alpha = 0.4
        usernameTxtField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        emailTxtField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        passwordTxtField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        confirmPasswordTxtField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
    }
    
    func layoutUI() {
        addSubviews()
        setupSignupStackView()
        setupViewName()
        setupSignupConstraints()
        setupUsernameConstraints()
        setupEmailConstraints()
        setupPasswordConstraints()
        setupConfirmPasswordConstraints()
        dismissKeyboard()
        checkTxtFields()
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let username = usernameTxtField.text, !username.isEmpty,
            let email = emailTxtField.text, !email.isEmpty,
            let password = passwordTxtField.text, !password.isEmpty,
            let confirmPassword = confirmPasswordTxtField.text, !confirmPassword.isEmpty
            else {
                signupButton.isEnabled = false
                signupButton.alpha = 0.4
                return
        }
        signupButton.isEnabled = true
        signupButton.alpha = 1.0
    }
    
}

extension SignupView: TextFieldDelegate {
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
