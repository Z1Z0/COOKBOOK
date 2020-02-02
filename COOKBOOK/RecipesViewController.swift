//
//  RecipesViewController.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 1/30/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class RecipesViewController: UIViewController {
    
    @IBOutlet weak var recipeTableView: UITableView!
    
    var recipe: Recipe?
    var recipeDetails = [Result]()
    var recipeSearch: String?
    
    let baseURL = "https://spoonacular.com/recipeImages/"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        recipeTableView.register(UINib(nibName: "RecipeTableViewCell", bundle: nil), forCellReuseIdentifier: "RecipeTableViewCell")
        recipeTableView.rowHeight = UITableView.automaticDimension
//        fetchData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
}

extension RecipesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as? RecipeTableViewCell
        cell?.recipeName.text = recipeDetails[indexPath.row].title
        if let imageURL = URL(string: baseURL + recipeDetails[indexPath.row].image) {
            print(imageURL)
            cell?.recipeImage.kf.setImage(with: imageURL)
        }
        return cell!
    }
    
    func fetchData() {
            guard let query = recipeSearch else { return }
//            print(query)
            Alamofire.request("https://api.spoonacular.com/recipes/search?query=\(query)&number=10&instructionsRequired=false&apiKey=db696760ce1043b08fc01d61d1ed0d35").responseJSON { (response) in
//                print(response)
                if let error = response.error {
                    print(error)
                    return
                }
                do {
                    let data = try JSONDecoder().decode(Recipe.self, from: response.data!)
//                    print(data)
                    self.recipeDetails = data.results 
                    DispatchQueue.main.async {
                        self.recipeTableView.reloadData()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
}
