//
//  SearchByIngredientsViewController.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 4/20/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit
import Alamofire

class SearchByIngredientsViewController: UIViewController {
    
    lazy var mainView: SearchByIngredientsView = {
        let view = SearchByIngredientsView(frame: self.view.frame)
        view.backgroundColor = .white
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
        setupNavigation()
        setupSideMenu()
        preferedLargeTitle()
        self.title = "Ingredients"
        preferedLargeTitle()
    }
}

extension SearchByIngredientsViewController: AddIngredientsToCollectionDelegate {
    
    func addingIngredientsToCollection() {
        mainView.ingredientsArray.append(mainView.addIngrediantsTextField.text!)
        for ingredient in mainView.ingredientsArray {
            if ingredient != "" {
                
                mainView.cleanIngredientsArray.append(ingredient)
                mainView.cleanIngredientsArray.removeDuplicates()
                print(mainView.cleanIngredientsArray)
                DispatchQueue.main.async {
                    self.mainView.addIngrediantsCollectionView.reloadData()
                    self.mainView.addIngrediantsTextField.text = ""
                }
                
            }
        }
        
    }
    
    func searchByIngredients() {
        let  vc = SearchByIngredientsTableViewController()
        let ingredientsString = mainView.cleanIngredientsArray.joined(separator: "+")
        vc.ingredientsString = ingredientsString
        self.show(vc, sender: nil)
    }
    
}
