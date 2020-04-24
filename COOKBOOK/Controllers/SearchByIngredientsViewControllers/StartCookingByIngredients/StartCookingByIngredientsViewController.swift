//
//  StartCookingByIngredientsViewController.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 4/24/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit

class StartCookingByIngredientsViewController: UIViewController {
    
    var recipeTitle: String?
    var recipeTime: String?
    var recipeImage: String?
    var instructionsNumber: String?
    var instructionsSteps: [String]?
    
    lazy var mainView: StartCookingByIngredientsView = {
        let view = StartCookingByIngredientsView(frame: self.view.frame)
        view.backgroundColor = .customDarkGray()
        view.vc = self
        view.delegate = self
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            self.mainView.startCookingTableView.reloadData()
        }
    }
}

extension StartCookingByIngredientsViewController: StartCookingDelegateAction {
    func dismissButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
