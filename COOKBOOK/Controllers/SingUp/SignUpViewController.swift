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

class SignUpViewController: UIViewController, SignupDelegate {
    
    let indicator = ActivityIndicator()
    let db = Firestore.firestore()
    
    lazy var mainView: SignupView = {
        let view = SignupView(delegate: self, frame: self.view.frame)
        view.backgroundColor = .white
        return view
    }()
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    func registerBtnTapped() {
        indicator.setupIndicatorView(view, containerColor: .white, indicatorColor: .CustomGreen())
        self.view.alpha = 0.7
        let name = mainView.username
        let email = mainView.userEmail
        let password = mainView.userPassword
        let confirmPassword = mainView.userConfirmPassword
        
        let validateEmail = isValidEmail(emailStr: email)
        
        var data = [
            "Username": name,
            "Email": email
        ]
        
        if validateEmail == true {
            if isValidPassword(testStr: password) == true {
                if confirmPassword == password {
                    Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                        if error == nil {
                            if let uid = Auth.auth().currentUser?.uid {
                                self.db.collection("Users").document(uid).setData(data)
                            }
                            
                            self.view.alpha = 1.0
                            self.indicator.hideIndicatorView(self.view)
                            Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                                
                            })
                            self.view.alpha = 1.0
                            self.indicator.hideIndicatorView(self.view)
                            Alert.showAlert(title: "Email created", subtitle: "You have created your account. Please check your email and activate the account", leftView: UIImageView(image: #imageLiteral(resourceName: "isSuccessIcon")), style: .success)
                        } else {
                            self.view.alpha = 1.0
                            self.indicator.hideIndicatorView(self.view)
                            Alert.showAlert(title: "Error", subtitle: error!.localizedDescription, leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
                        }
                    }
                } else {
                    self.view.alpha = 1.0
                    self.indicator.hideIndicatorView(self.view)
                    Alert.showAlert(title: "Error", subtitle: "Password doesn't match", leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
                }
            } else {
                self.view.alpha = 1.0
                self.indicator.hideIndicatorView(self.view)
                Alert.showAlert(title: "Error", subtitle: "Please enter password that contains at least one uppercase, at least one digit, at least one lowercase, 8 characters total.", leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
            }
        } else {
            self.view.alpha = 1.0
            self.indicator.hideIndicatorView(self.view)
            Alert.showAlert(title: "Error", subtitle: "Please enter a valid email", leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
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
    }
    
}
