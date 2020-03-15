//
//  RecipesDetailsViewController.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 3/14/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit

class RecipesDetailsViewController: UIViewController {
    
    lazy var mainView: RecipesDetailsView = {
        let view = RecipesDetailsView(frame: self.view.frame)
        view.backgroundColor = .customVeryLightGray()
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
