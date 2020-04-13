//
//  StartBuyingSearchedRecipesViewController.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 4/9/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit

class StartBuyingSearchedRecipesViewController: UIViewController {
    
    var ingredientsName: [String]?
    var ingredientsWeight: [Double]?
    var ingredientsAmount: [String]?
    var ingredientsNumber: Int?
    
    lazy var mainView: StartBuyingSearchedRecipesView = {
        let view = StartBuyingSearchedRecipesView(frame: self.view.frame)
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

extension StartBuyingSearchedRecipesViewController: StartCookingDelegateAction {
    func dismissButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
