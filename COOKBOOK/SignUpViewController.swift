//
//  SignUpViewController.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 2/12/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit
import Material
import Firebase

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    let signupStackView = UIStackView()
    let socialLoginStackView = UIStackView()
    fileprivate let widthConstant: CGFloat = 1.3
    fileprivate let height: CGFloat = 55
    let indicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupSignupStackView()
        setupViewName()
        setupUsernameConstraints()
        setupEmailConstraints()
        setupPasswordConstraints()
        setupConfirmPasswordConstraints()
        dismissKeyboard()
        setupSocialLoginStackView()
        setupFacebookButtonConstraints()
        setupTwitterButtonConstraints()
        setupAppleButtonConstraints()
        checkTxtFields()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        setupNavigation()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupSignupConstraints()
    }
    
    let viewName: UILabel = {
        let viewName = UILabel()
        viewName.text = "Create an \nAccount!"
        viewName.numberOfLines = 2
        viewName.font = UIFont(name: "AvenirNext-Bold", size: 36)
        viewName.textColor = .customDarkGray()
        viewName.textAlignment = .left
        return viewName
    }()
    
    func setupViewName() {
        view.addSubview(viewName)
        viewName.translatesAutoresizingMaskIntoConstraints = false
        viewName.bottomAnchor.constraint(equalTo: signupStackView.topAnchor, constant: -25).isActive = true
        viewName.leadingAnchor.constraint(equalTo: signupStackView.leadingAnchor).isActive = true
        viewName.trailingAnchor.constraint(equalTo: signupStackView.trailingAnchor).isActive = true
    }
    
    let usernameTxtField: UITextField = {
        let usernameTextField = ErrorTextField()
        usernameTextField.backgroundColor = .white
        usernameTextField.placeholder = "Username"
        usernameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(16,0,0)
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
        usernameTxtField.leadingAnchor.constraint(equalTo: signupStackView.leadingAnchor).isActive = true
        usernameTxtField.trailingAnchor.constraint(equalTo: signupStackView.trailingAnchor).isActive = true
        usernameTxtField.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    let emailTxtField: UITextField = {
        let emailTextField = ErrorTextField()
        emailTextField.backgroundColor = .white
        emailTextField.placeholder = "Email"
        emailTextField.layer.sublayerTransform = CATransform3DMakeTranslation(16,0,0)
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
        emailTxtField.leadingAnchor.constraint(equalTo: signupStackView.leadingAnchor).isActive = true
        emailTxtField.trailingAnchor.constraint(equalTo: signupStackView.trailingAnchor).isActive = true
        emailTxtField.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    let passwordTxtField: UITextField = {
        let passwordTextField = ErrorTextField()
        passwordTextField.backgroundColor = .white
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(16,0,0)
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
        passwordTxtField.leadingAnchor.constraint(equalTo: signupStackView.leadingAnchor).isActive = true
        passwordTxtField.trailingAnchor.constraint(equalTo: signupStackView.trailingAnchor).isActive = true
        passwordTxtField.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    let confirmPasswordTxtField: UITextField = {
        let confirmPasswordTextField = ErrorTextField()
        confirmPasswordTextField.backgroundColor = .white
        confirmPasswordTextField.placeholder = "Confirm Password"
        confirmPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(16,0,0)
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
        confirmPasswordTxtField.leadingAnchor.constraint(equalTo: signupStackView.leadingAnchor).isActive = true
        confirmPasswordTxtField.trailingAnchor.constraint(equalTo: signupStackView.trailingAnchor).isActive = true
        confirmPasswordTxtField.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    let signupButton: UIButton = {
        let signupButton = UIButton()
        signupButton.setTitle("Signup", for: .normal)
        signupButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 14)
        signupButton.backgroundColor = .customDarkGray()
        signupButton.setTitleColor(.white, for: .normal)
        signupButton.layer.cornerRadius = 8.0
        signupButton.addTarget(self, action: #selector(signupNewUser(_:)), for: .touchUpInside)
        return signupButton
    }()
    
    func setupSignupConstraints() {
        signupButton.heightAnchor.constraint(equalToConstant: height).isActive = true
        signupButton.widthAnchor.constraint(equalToConstant: view.frame.width / widthConstant).isActive = true
    }
    
    @objc func signupNewUser( _ sender: Any ) {
        setupIndicatorView()
        guard let email = emailTxtField.text else { return }
        guard let password = passwordTxtField.text else { return }
        guard let confirmPassword = confirmPasswordTxtField.text else { return }
        
        let validateEmail = isValidEmail(emailStr: email)
        
        if validateEmail == true {
            if isValidPassword(testStr: password) == true {
                if confirmPassword == password {
                    Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                        if error == nil {
                            self.indicator.stopAnimating()
                            Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                                self.correctSignupAlert(title: "Yaaaaaaay", message: "Signup", actionTitle: "To signin")
                            })
                            print("Success")
                        } else {
                            self.indicator.stopAnimating()
                            self.errorAlert(title: "Error", message: error!.localizedDescription, actionTitle: "Cancel")
                        }
                    }
                } else {
                    self.indicator.stopAnimating()
                    self.errorAlert(title: "Error", message: "Password doesn't match", actionTitle: "Cancel")
                }
            } else {
                self.indicator.stopAnimating()
                self.errorAlert(title: "Error", message: "Password should contain at least 8 charachters", actionTitle: "Cancel")
            }
        } else {
            self.indicator.stopAnimating()
            self.errorAlert(title: "Error", message: "Invalid email", actionTitle: "Cancel")
        }
    }
    
    func setupSignupStackView() {
        view.addSubview(signupStackView)
        signupStackView.addArrangedSubview(usernameTxtField)
        signupStackView.addArrangedSubview(emailTxtField)
        signupStackView.addArrangedSubview(passwordTxtField)
        signupStackView.addArrangedSubview(confirmPasswordTxtField)
        signupStackView.addArrangedSubview(signupButton)
        signupStackView.axis = .vertical
        signupStackView.distribution = .fillEqually
        signupStackView.alignment = .center
        signupStackView.spacing = 25
        setupSignupStackViewConstraint()
    }
    
    func setupSignupStackViewConstraint() {
        signupStackView.translatesAutoresizingMaskIntoConstraints = false
        signupStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signupStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        signupStackView.widthAnchor.constraint(equalToConstant: view.frame.width / widthConstant).isActive = true
    }
    
    let facebookBtn: UIButton = {
        let facebookButton = UIButton()
        facebookButton.setImage(UIImage(named: "facebook"), for: .normal)
        facebookButton.backgroundColor = #colorLiteral(red: 0.1803921569, green: 0.2705882353, blue: 0.5294117647, alpha: 1)
        facebookButton.layer.cornerRadius = 8.0
        return facebookButton
    }()
    
    func setupFacebookButtonConstraints() {
        facebookBtn.heightAnchor.constraint(equalToConstant: view.frame.width / 6).isActive = true
    }
    
    let twitterBtn: UIButton = {
        let twitterButton = UIButton()
        twitterButton.setImage(UIImage(named: "twitter"), for: .normal)
        twitterButton.backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.5568627451, blue: 0.9333333333, alpha: 1)
        twitterButton.layer.cornerRadius = 8.0
        return twitterButton
    }()
    
    func setupTwitterButtonConstraints() {
        twitterBtn.heightAnchor.constraint(equalToConstant: view.frame.width / 6).isActive = true
    }
    
    let appleBtn: UIButton = {
        let appleButton = UIButton()
        appleButton.setImage(UIImage(named: "apple"), for: .normal)
        appleButton.backgroundColor = #colorLiteral(red: 0.1450980392, green: 0.1450980392, blue: 0.1450980392, alpha: 1)
        appleButton.layer.cornerRadius = 8.0
        return appleButton
    }()
    
    func setupAppleButtonConstraints() {
        appleBtn.heightAnchor.constraint(equalToConstant: view.frame.width / 6).isActive = true
    }
    
    func setupSocialLoginStackView() {
        view.addSubview(socialLoginStackView)
        socialLoginStackView.addArrangedSubview(facebookBtn)
        socialLoginStackView.addArrangedSubview(twitterBtn)
        socialLoginStackView.addArrangedSubview(appleBtn)
        socialLoginStackView.axis = .horizontal
        socialLoginStackView.distribution = .fillEqually
        socialLoginStackView.alignment = .center
        socialLoginStackView.spacing = view.frame.width / 8
        setupSocialLoginStackViewConstraint()
    }
    
    func setupSocialLoginStackViewConstraint() {
        socialLoginStackView.translatesAutoresizingMaskIntoConstraints = false
        socialLoginStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        socialLoginStackView.topAnchor.constraint(equalTo: signupStackView.bottomAnchor, constant: 25).isActive = true
        socialLoginStackView.widthAnchor.constraint(equalToConstant: view.frame.width / widthConstant).isActive = true
        socialLoginStackView.heightAnchor.constraint(equalToConstant: view.frame.width / 6).isActive = true
    }
    
    func dismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    fileprivate func setupNavigation() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        backItem.tintColor = .CustomGreen()
        navigationItem.backBarButtonItem = backItem
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.CustomGreen()]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    func checkTxtFields() {
        signupButton.isEnabled = false
        signupButton.alpha = 0.4
        usernameTxtField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        emailTxtField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        passwordTxtField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        confirmPasswordTxtField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
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
    
    func setupIndicatorView() {
        view.addSubview(indicator)
        indicator.style = .large
        indicator.center = self.view.center
        indicator.color = .customDarkGray()
        indicator.backgroundColor = .clear
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
}

extension SignUpViewController: TextFieldDelegate {
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
