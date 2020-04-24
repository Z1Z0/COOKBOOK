//
//  StartBuyingByIngredientsViewController.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 4/24/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit

class StartBuyingByIngredientsViewController: UIViewController {
    
    var ingredientsName: [String]?
    var ingredientsWeight: [Double]?
    var ingredientsAmount: [String]?
    var ingredientsNumber: Int?
    
    lazy var mainView: StartBuyingByIngredientsView = {
        let view = StartBuyingByIngredientsView(frame: self.view.frame)
        view.vc = self
        view.delegate = self
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

extension StartBuyingByIngredientsViewController: StartCookingDelegateAction {
    func dismissButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
