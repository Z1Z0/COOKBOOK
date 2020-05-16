//
//  SplashViewController.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 2/10/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit
import Firebase
import NotificationBannerSwift

class SplashViewController: UIViewController, SplashViewDelegate {
    
    let db = Firestore.firestore()
    
    lazy var mainView: SplashView = {
        let view = SplashView(delegate: self, frame: self.view.frame)
        view.backgroundColor = .white
        return view
    }()
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        setupNavigation()
        setNeedsStatusBarAppearanceUpdate()
        getAboutUsData()
    }
    
    func registerButtonTapped() {
        let loginVC = SignInViewController()
        self.show(loginVC, sender: nil)
    }
    
    func getAboutUsData() {
        db.collection("AppInfo").document("splash").addSnapshotListener { (snapshot, error) in
            if error != nil {
                Alert.showAlert(title: "Ops", subtitle: "There is error in your connection", leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
            } else {
                if let description = snapshot?["splash"] as? String {
                    self.mainView.appDescription.text = description
                }
            }
        }
    }
    
}
