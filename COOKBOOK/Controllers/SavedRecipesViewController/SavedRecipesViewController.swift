//
//  SavedRecipesViewController.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 4/4/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit

class SavedRecipesViewController: UIViewController {
    
    lazy var mainView: SavedRecipesView = {
        let view = SavedRecipesView(frame: self.view.frame)
        view.backgroundColor = .white
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
