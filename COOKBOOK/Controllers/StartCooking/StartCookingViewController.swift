//
//  StartCookingViewController.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 3/25/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit

class StartCookingViewController: UIViewController {
    
    var recipeTitle: String?
    var recipeTime: String?
    var recipeImage: String?
    
    lazy var mainView: StartCookingView = {
        let view = StartCookingView(frame: self.view.frame)
        view.backgroundColor = .customDarkGray()
        view.vc = self
        return view
    }()
    
    override func loadView() {
        super.loadView()
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

extension StartCookingViewController: StartCookingDelegateAction {
    func dismissButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
