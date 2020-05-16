//
//  ViewController.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 1/30/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit
import Firebase

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
                    self.indicator.hideIndicatorView(self.view)
                    let homeVC = HomeViewController()
                    self.show(homeVC, sender: nil)
                    
                } else {
                    Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                        if error == nil {
                            self.view.alpha = 1.0
                            self.indicator.hideIndicatorView(self.view)
                            Alert.showAlert(title: "Warning", subtitle: "You have not activate your account yet. We have sent you an email to activate it.", leftView: UIImageView(image: #imageLiteral(resourceName: "isWarningIcon")), style: .warning)
                        } else {
                            self.view.alpha = 1.0
                            self.indicator.hideIndicatorView(self.view)
                            Alert.showAlert(title: "Error", subtitle: "Incorrect email.", leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
                        }
                    })
                }
            } else {
                self.view.alpha = 1.0
                self.indicator.hideIndicatorView(self.view)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        setupNavigation()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Restore the navigation bar to default
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
}
