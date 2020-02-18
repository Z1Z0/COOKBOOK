//
//  ViewController.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 1/30/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit
import Material
import Firebase
import FacebookLogin
import FacebookCore
import GoogleSignIn

class SignInViewController: UIViewController {
    
    let loginStackView = UIStackView()
    let socialLoginStackView = UIStackView()
    fileprivate let widthConstant: CGFloat = 1.3
    fileprivate let height: CGFloat = 55
    let gradientColor = CAGradientLayer()
    let indicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        view.backgroundColor = .white
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        setupNavigation()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLoginConstraints()
        setupRegisterConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Restore the navigation bar to default
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
    
    let viewName: UILabel = {
        let viewName = UILabel()
        viewName.text = "Sign In"
        viewName.font = UIFont(name: "AvenirNext-Bold", size: 36)
        viewName.textColor = .customDarkGray()
        viewName.textAlignment = .left
        return viewName
    }()
    
    func setupViewName() {
        view.addSubview(viewName)
        viewName.translatesAutoresizingMaskIntoConstraints = false
        viewName.bottomAnchor.constraint(equalTo: loginStackView.topAnchor, constant: -25).isActive = true
        viewName.leadingAnchor.constraint(equalTo: loginStackView.leadingAnchor).isActive = true
        viewName.trailingAnchor.constraint(equalTo: loginStackView.trailingAnchor).isActive = true
    }
    
    let emailTxtField: UITextField = {
        let emailTextField = ErrorTextField()
        emailTextField.backgroundColor = .white
        emailTextField.placeholder = "Enter email"
        emailTextField.layer.sublayerTransform = CATransform3DMakeTranslation(16,0,0)
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
    
    func setupEmailConstraints() {
        emailTxtField.leadingAnchor.constraint(equalTo: loginStackView.leadingAnchor).isActive = true
        emailTxtField.trailingAnchor.constraint(equalTo: loginStackView.trailingAnchor).isActive = true
        emailTxtField.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    let passwordTxtField: UITextField = {
        let passwordTextField = ErrorTextField()
        passwordTextField.backgroundColor = .white
        passwordTextField.placeholder = "Enter password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(16,0,0)
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
    
    func setupPasswordConstraints() {
        passwordTxtField.leadingAnchor.constraint(equalTo: loginStackView.leadingAnchor).isActive = true
        passwordTxtField.trailingAnchor.constraint(equalTo: loginStackView.trailingAnchor).isActive = true
        passwordTxtField.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    let loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.setTitle("Sign In", for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 14)
        loginButton.backgroundColor = .clear
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 8.0
        loginButton.addTarget(self, action: #selector(toHomePage), for: .touchUpInside)
        return loginButton
    }()
    
    func setupLoginConstraints() {
        loginButton.setGradientBackground(colorOne: .CustomGreen(), colorTwo: .LightGreen())
        loginButton.heightAnchor.constraint(equalToConstant: height).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: view.frame.width / widthConstant).isActive = true
    }
    
    @objc func toHomePage(_ sender: Any) {
        setupIndicatorView()
        guard let email = emailTxtField.text else { return }
        guard let password = passwordTxtField.text else { return }
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil {
                if Auth.auth().currentUser?.isEmailVerified == true {
                    self.indicator.stopAnimating()
                    print("Logined")
                } else {
                    Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                        if error == nil {
                            self.indicator.stopAnimating()
                            print("send email success")
                        } else {
                            self.indicator.stopAnimating()
                            Alert.showAlert(title: "Error", subtitle: error!.localizedDescription, leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
                        }
                    })
                }
            } else {
                self.indicator.stopAnimating()
                Alert.showAlert(title: "Error", subtitle: error!.localizedDescription, leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
            }
        }
    }
    
    let registerBtn: UIButton = {
        let registerButton = UIButton()
        registerButton.setTitle("Creat account", for: .normal)
        registerButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 14)
        registerButton.backgroundColor = .clear
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.layer.cornerRadius = 8.0
        registerButton.addTarget(self, action: #selector(toSignupView), for: .touchUpInside)
        return registerButton
    }()
    
    func setupRegisterConstraints() {
        registerBtn.setGradientBackground(colorOne: .LightGreen(), colorTwo: .CustomGreen())
        registerBtn.heightAnchor.constraint(equalToConstant: height).isActive = true
        registerBtn.widthAnchor.constraint(equalToConstant: view.frame.width / widthConstant).isActive = true
    }
    
    @objc func toSignupView(_ sender: Any) {
        let signupView = SignUpViewController()
        self.show(signupView, sender: nil)
    }
    
    func setupLoginStackView() {
        view.addSubview(loginStackView)
        loginStackView.addArrangedSubview(emailTxtField)
        loginStackView.addArrangedSubview(passwordTxtField)
        loginStackView.addArrangedSubview(loginButton)
        loginStackView.addArrangedSubview(registerBtn)
        loginStackView.axis = .vertical
        loginStackView.distribution = .fillEqually
        loginStackView.alignment = .center
        loginStackView.spacing = 25
        setupLoginStackViewConstraint()
    }
    
    func setupLoginStackViewConstraint() {
        loginStackView.translatesAutoresizingMaskIntoConstraints = false
        loginStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loginStackView.widthAnchor.constraint(equalToConstant: view.frame.width / widthConstant).isActive = true
    }
    
    let facebookBtn: UIButton = {
        let facebookButton = UIButton()
        facebookButton.setImage(UIImage(named: "facebook"), for: .normal)
        facebookButton.backgroundColor = #colorLiteral(red: 0.1803921569, green: 0.2705882353, blue: 0.5294117647, alpha: 1)
        facebookButton.layer.cornerRadius = 8.0
        facebookButton.addTarget(self, action: #selector(signinFacebook), for: .touchUpInside)
        return facebookButton
    }()
    
    func setupFacebookButtonConstraints() {
        facebookBtn.heightAnchor.constraint(equalToConstant: view.frame.width / 6).isActive = true
    }
    
    @objc func signinFacebook() {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: [.publicProfile, .email], viewController: self) { (result) in
            switch result {
            case .success(granted: _, declined: _, token: _):
                self.signIntoFirebaseWithFacebook()
            case .failed(let error):
                print(error)
            case .cancelled:
                print("cancelled")
            }
        }
    }
    
    fileprivate func signIntoFirebaseWithFacebook() {
        let authenticationToken = AccessToken.current?.tokenString
        let credential = FacebookAuthProvider.credential(withAccessToken: authenticationToken!)
        Auth.auth().signIn(with: credential) { (user, error) in
            if let err = error {
                print(err)
                return
            }
            self.indicator.stopAnimating()
        }
    }
    
    let twitterBtn: UIButton = {
        let twitterButton = UIButton()
        twitterButton.setImage(UIImage(named: "twitter"), for: .normal)
        twitterButton.backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.5568627451, blue: 0.9333333333, alpha: 1)
        twitterButton.layer.cornerRadius = 8.0
        twitterButton.addTarget(self, action: #selector(signinTwitter), for: .touchUpInside)
        return twitterButton
    }()
    
    func setupTwitterButtonConstraints() {
        twitterBtn.heightAnchor.constraint(equalToConstant: view.frame.width / 6).isActive = true
    }
    
    @objc func signinTwitter() {
        func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
            if let error = error {
                print(error)
            } else {
                print(user.profile.name)
            }
            guard let auth = user.authentication else {return}
            let credential = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)
            
            Auth.auth().signIn(with: credential) { (result, error) in
                if let err = error {
                    print(err)
                    return
                }
                print("Success")
            }
        }
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
        socialLoginStackView.topAnchor.constraint(equalTo: loginStackView.bottomAnchor, constant: 25).isActive = true
        socialLoginStackView.widthAnchor.constraint(equalToConstant: view.frame.width / widthConstant).isActive = true
        socialLoginStackView.heightAnchor.constraint(equalToConstant: view.frame.width / 6).isActive = true
    }
    
    let forgetPasswordBtn: UIButton = {
        let forgetPasswordButton = UIButton()
        forgetPasswordButton.setTitle("Forget your password?", for: .normal)
        forgetPasswordButton.setTitleColor(.CustomGreen(), for: .normal)
        forgetPasswordButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 14)
        forgetPasswordButton.addTarget(self, action: #selector(toForgetPasswordView), for: .touchUpInside)
        return forgetPasswordButton
    }()
    
    func setupForgetPasswordButtonConstraints() {
        view.addSubview(forgetPasswordBtn)
        forgetPasswordBtn.translatesAutoresizingMaskIntoConstraints = false
        forgetPasswordBtn.topAnchor.constraint(equalTo: socialLoginStackView.bottomAnchor, constant: 25).isActive = true
        forgetPasswordBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc func toForgetPasswordView() {
        let forgetPasswordView = ForgetPasswordViewController()
        self.show(forgetPasswordView, sender: nil)
    }
    
    func dismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func checkTxtFields() {
        loginButton.isEnabled = false
        loginButton.alpha = 0.4
        emailTxtField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        passwordTxtField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
    }
    
    @objc func editingChanged(_ textField: UITextField) {
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



extension SignInViewController: TextFieldDelegate {
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
