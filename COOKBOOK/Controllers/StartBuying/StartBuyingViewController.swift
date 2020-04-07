//
//  StartBuyingViewController.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 4/7/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit

class StartBuyingViewController: UIViewController {
    
    var ingredientsName: [String]?
    var ingredientsWeight: [Double]?
    var ingredientsAmount: [String]?
    
    lazy var mainView: StartBuyingView = {
        let view = StartBuyingView(frame: self.view.frame)
        view.vc = self
        view.backgroundColor = .customDarkGray()
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

extension StartBuyingViewController: StartCookingDelegateAction {
    func dismissButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
