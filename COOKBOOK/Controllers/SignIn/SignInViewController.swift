//
//  ViewController.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 1/30/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit
import Firebase
import FacebookLogin
import FacebookCore
import GoogleSignIn

class SignInViewController: UIViewController, SignInDelegate {
    
    let indicator = ActivityIndicator()
        
    lazy var mainView: SignInView = {
        let view = SignInView(delegate: self, frame: self.view.frame)
        view.backgroundColor = .white
        return view
    }()
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    func loginButtonTapped() {
        indicator.setupIndicatorView(view, containerColor: .white, indicatorColor: .CustomGreen())
        view.alpha = 0.7
        let email = mainView.userEmail
        let password = mainView.userPassword
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil {
                if Auth.auth().currentUser?.isEmailVerified == true {
                    self.view.alpha = 1.0
                    self.indicator.hideIndicatorView()
                    print("Logined")
                } else {
                    Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                        if error == nil {
                            self.view.alpha = 1.0
                            self.indicator.hideIndicatorView()
                            Alert.showAlert(title: "Warning", subtitle: "You have not activate your account yet. We have sent you an email to activate it.", leftView: UIImageView(image: #imageLiteral(resourceName: "isWarningIcon")), style: .warning)
                        } else {
                            self.view.alpha = 1.0
                            self.indicator.hideIndicatorView()
                            Alert.showAlert(title: "Error", subtitle: "Incorrect email.", leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
                        }
                    })
                }
            } else {
                self.view.alpha = 1.0
                self.indicator.hideIndicatorView()
                Alert.showAlert(title: "Error", subtitle: "Incorrect email or password.", leftView: UIImageView(assetIdentifier: AssetIdentifier.error)!, style: .danger)
            }
        }
    }
    
    func registerButtonTapped() {
        let signupVC = SignUpViewController()
        self.show(signupVC, sender: nil)
    }
    
    func forgetPasswordButtonTapped() {
        let forgetPasswordVC = ForgetPasswordViewController()
        self.show(forgetPasswordVC, sender: nil)
    }
    
    func facebookButtonTapped() {
        indicator.setupIndicatorView(view, containerColor: .white, indicatorColor: .CustomGreen())
        view.alpha = 0.7
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
            self.view.alpha = 1.0
            self.indicator.hideIndicatorView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        setupNavigation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Restore the navigation bar to default
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
}
