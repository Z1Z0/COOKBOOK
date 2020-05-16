//
//  PopularRecipesTableViewCellCollectionViewCell.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 3/5/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire
import Firebase

protocol PopularRecipesDidselectActionDelegate: class {
    func categoriesTableViewCell(
        _ cell: UICollectionView,
        didSelectTitle title: String,
        image: String,
        recipeTime: String,
        instructions: String,
        ingredientsNumber: String,
        ingredientsNumbersInt: Int,
        ingredientsName: [String],
        ingredientsWeight: [Double],
        ingredientsAmount: [String],
        instructionsNumber: String,
        instructionsSteps: [String],
        recipeID: String
    )
}

class PopularRecipesTableViewCellCollectionViewCell: UITableViewCell, UICollectionViewDelegateFlowLayout {
    
    var recipes: Recipes?
    var recipesDetails = [Recipe]()
    let db = Firestore.firestore()
    
    weak var popularRecipesDidselectActionDelegate: PopularRecipesDidselectActionDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutUI()
        fetchData()
        self.backgroundColor = .clear
        selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchData() {
       db.collection("AppInfo").document("apiKey").addSnapshotListener { (snapshot, error) in
           if error != nil {
               Alert.showAlert(title: "Error", subtitle: error?.localizedDescription ?? "Error", leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
           } else {
               if let apiKey = snapshot?["apiKey"] as? String {
                   AF.request("https://api.spoonacular.com/recipes/random?apiKey=\(apiKey)&number=25").responseJSON { (response) in
                       if let error = response.error {
                           Alert.showAlert(title: "Error", subtitle: error.localizedDescription, leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
                       }
                       do {
                           if let data = response.data {
                               self.recipes = try JSONDecoder().decode(Recipes.self, from: data)
                               self.recipesDetails = self.recipes?.recipes ?? []
                               DispatchQueue.main.async {
                                   self.collectionView.reloadData()
                               }
                           }
                           
                       } catch {
                           Alert.showAlert(title: "Error", subtitle: error.localizedDescription, leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
                       }
                   }
               }
           }
       }
    }
    
    lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .clear
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()

    lazy var categoriesNameLabel: UILabel = {
        let categoriesNameLabel = UILabel()
        categoriesNameLabel.text = "Popular recipes"
        categoriesNameLabel.textColor = .customDarkGray()
        categoriesNameLabel.textAlignment = .left
        categoriesNameLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        categoriesNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return categoriesNameLabel
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PopularRecipesCollectionViewCell.self, forCellWithReuseIdentifier: "PopularRecipesCollectionViewCell")
        return collectionView
    }()

    func setupContainerViewConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }

    func setupCategoriesNameLabelConstraints() {
        NSLayoutConstraint.activate([
            categoriesNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            categoriesNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8)
        ])
    }

    func setupCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: categoriesNameLabel.bottomAnchor, constant: 16),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(categoriesNameLabel)
        containerView.addSubview(collectionView)
    }

    func layoutUI() {
        addSubviews()
        setupCollectionViewConstraints()
        setupContainerViewConstraints()
        setupCategoriesNameLabelConstraints()
    }

}

extension PopularRecipesTableViewCellCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipesDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let url = URL(string: recipesDetails[indexPath.row].image ?? "Error")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularRecipesCollectionViewCell", for: indexPath) as! PopularRecipesCollectionViewCell
        cell.popularRecipesImage.kf.setImage(with: url)
        cell.recipesTitle.text = recipesDetails[indexPath.row].title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w: CGFloat = self.frame.width * 0.7
        let h: CGFloat = collectionView.frame.size.height - 6.0
        return CGSize(width: w, height: h)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        popularRecipesDidselectActionDelegate?.categoriesTableViewCell(
            collectionView,
            didSelectTitle: recipesDetails[indexPath.row].title ?? "Error",
            image: recipesDetails[indexPath.row].image ?? "Error",
            recipeTime: "\(recipesDetails[indexPath.row].readyInMinutes ?? 0) Min",
            instructions: recipesDetails[indexPath.row].instructions ?? "Error",
            ingredientsNumber: "\(recipesDetails[indexPath.row].extendedIngredients?.count ?? 0)",
            ingredientsNumbersInt: recipesDetails[indexPath.row].extendedIngredients?.count ?? 5,
            ingredientsName: (recipesDetails[indexPath.row].extendedIngredients?.compactMap({$0.name}) ?? ["Error"]),
            ingredientsWeight: recipesDetails[indexPath.row].extendedIngredients?.map({($0.amount ?? 0.0)}) ?? [0.0],
            ingredientsAmount: recipesDetails[indexPath.row].extendedIngredients?.map({($0.unit ?? "Error")}) ?? ["Error"],
            instructionsNumber: "\(recipesDetails[indexPath.row].analyzedInstructions?.count ?? 0)",
            instructionsSteps: (recipesDetails[indexPath.row].analyzedInstructions?[0].steps?.map({$0.step ?? "Error"}) ?? ["Error"]),
            recipeID: "\(recipesDetails[indexPath.row].id ?? 0)"
        )
    }
    
}
