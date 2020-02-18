//
//  SplashViewController.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 2/10/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController, SplashViewDelegate {
    
    lazy var mainView: SplashView = {
        let view = SplashView(delegate: self, frame: self.view.frame)
        view.backgroundColor = .white
        return view
    }()
    
    override func loadView() {
        super.loadView()
        view = mainView
//        mainView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        setupNavigation()
    }
    
    func registerButtonTapped() {
        let loginVC = SignInViewController()
        self.show(loginVC, sender: nil)
    }
    
}
