//
//  ForgetPasswordViewController.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 2/12/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit
import Material
import Firebase

class ForgetPasswordViewController: UIViewController, forgetPasswordDelegate {
    
    let indicator = ActivityIndicator()

    lazy var mainView: ForgetPasswordView = {
        let view = ForgetPasswordView(delegate: self, frame: self.view.frame)
        view.backgroundColor = .white
        return view
    }()
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    func forgetPasswordTapped() {
        indicator.setupIndicatorView(view, containerColor: .white, indicatorColor: .CustomGreen())
        self.view.alpha = 0.7
        let email = mainView.userEmail
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error != nil {
                self.view.alpha = 1.0
                self.indicator.hideIndicatorView(self.view)
                Alert.showAlert(title: "Error", subtitle: "Incorrect email.", leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
            } else {
                self.view.alpha = 1.0
                self.indicator.hideIndicatorView(self.view)
                Alert.showAlert(title: "Email sent", subtitle: "We have sent email to reset your password", leftView: UIImageView(image: #imageLiteral(resourceName: "isSuccessIcon")), style: .success)
            }
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
    }
    
}
