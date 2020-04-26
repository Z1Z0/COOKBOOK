//
//  AboutUsViewController.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 4/25/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {
    
    lazy var mainView: AboutUsView = {
        let view = AboutUsView(frame: self.view.frame)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSideMenu()
        preferedLargeTitle()
        self.title = "About us"
    }

}
