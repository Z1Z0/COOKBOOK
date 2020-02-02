//
//  ViewController.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 1/30/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    var recipe: Recipe?
    var recipeDetails = [Result]()
    
    var recipeVC: RecipesViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func searchRecipe(_ sender: Any) {
        
//        fetchData()
        
        let vc = storyboard?.instantiateViewController(identifier: "RecipesViewController") as? RecipesViewController
        vc?.recipeSearch = searchTextField.text
        self.show(vc!, sender: nil)
    }

//    func fetchData() {
//        guard let query = searchTextField.text else { return }
//
//        Alamofire.request("https://api.spoonacular.com/recipes/search?query=\(query)&number=10&instructionsRequired=false&apiKey=db696760ce1043b08fc01d61d1ed0d35").responseJSON { (response) in
//            if let error = response.error {
//                print(error)
//                return
//            }
//            do {
//                let data = try JSONDecoder().decode(Recipe.self, from: response.data!)
//                print(data)
//                self.recipeDetails = self.recipe?.results ?? []
////                DispatchQueue.main.async {
////                    self.recipeVC?.recipeTableView.reloadData()
////                }
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//    }
}

