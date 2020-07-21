//
//  RecipesDetailsView.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 3/14/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import Firebase

@objc protocol RecipesDetailsDelegateAction: class {
    @objc func startCookingButtonTapped()
}

protocol TransferSilimarDataDelegate: class {
    func transferData(for indexPath: Int)
}

class RecipesDetailsView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var recipeVC = RecipesDetailsViewController()
    weak var delegate: RecipesDetailsDelegateAction!
    weak var saveDelegate: FavouriteActionDelegate?
    let db = Firestore.firestore()
    weak var transferData: TransferSilimarDataDelegate?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.register(IngredientsTableViewCell.self, forCellReuseIdentifier: "IngredientsTableViewCell")
        tableView.register(NumberOfIngredientsTableViewCell.self, forCellReuseIdentifier: "NumberOfIngredientsTableViewCell")
        tableView.register(SimilarRecipesTableViewCell.self, forCellReuseIdentifier: "SimilarRecipesTableViewCell")
        return tableView
    }()
    
    lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .clear
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    lazy var startCookingButton: UIButton = {
        let startCookingButton = UIButton(type: .system)
        startCookingButton.setTitle("Start cooking", for: .normal)
        startCookingButton.setTitleColor(.white, for: .normal)
        startCookingButton.backgroundColor = .CustomGreen()
        startCookingButton.layer.cornerRadius = 8.0
        startCookingButton.translatesAutoresizingMaskIntoConstraints = false
        startCookingButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 14)
        startCookingButton.addTarget(delegate, action: #selector(delegate.startCookingButtonTapped), for: .touchUpInside)
        return startCookingButton
    }()
    
    lazy var saveButton: UIButton = {
        let saveButton = UIButton()
        saveButton.setTitleColor(.customDarkGray(), for: .normal)
        saveButton.setTitle("Save", for: .normal)
        let configrations = UIImage.SymbolConfiguration(pointSize: 24)
        saveButton.setImage(UIImage(systemName: "heart", withConfiguration: configrations), for: .normal)
        saveButton.imageEdgeInsets = UIEdgeInsets(top: 0,left: -5,bottom: 0,right: 0)
        saveButton.titleEdgeInsets = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: -5)
        saveButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 14)
        saveButton.tintColor = .customDarkGray()
        saveButton.backgroundColor = .clear
        saveButton.addTarget(self, action: #selector(favoriteButtonTapped(_:)), for: .touchUpInside)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        return saveButton
    }()
    
    @objc func favoriteButtonTapped(_ sender: UIButton) {
        saveDelegate?.favouriteButtonTapped(sender.tag)
        let button = sender
        
        UIView.animate(withDuration: 0.2,
        animations: {
            self.saveButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        },
        completion: { _ in
            UIView.animate(withDuration: 0.2) {
                self.saveButton.transform = CGAffineTransform.identity
            }
        })

        if Auth.auth().currentUser?.uid != nil {
            if button.isSelected == true {
                let configrations = UIImage.SymbolConfiguration(pointSize: 24)
                sender.setImage(UIImage(systemName: "heart", withConfiguration: configrations), for: .normal)
                sender.tintColor = .CustomGreen()
                sender.backgroundColor = .clear
                sender.isSelected = false
                let recipeID = recipeVC.recipeID
                let uid = Auth.auth().currentUser!.uid
                db.collection("Users").document(uid).collection("FavouriteRecipes").document(recipeID ?? "Error").delete()
            } else {
                let configrations = UIImage.SymbolConfiguration(pointSize: 24)
                sender.setImage(UIImage(systemName: "heart.fill", withConfiguration: configrations), for: .normal)
                sender.tintColor = .CustomGreen()
                sender.backgroundColor = .clear
                sender.isSelected = true
                let recipeID = recipeVC.recipeID
                let uid = Auth.auth().currentUser!.uid
                let data = [
                    "FavRecipes": recipeID
                    ] as! [String: String]
                db.collection("Users").document(uid).collection("FavouriteRecipes").document(recipeID ?? "Error").setData(data)
            }
        } else {
            Alert.showAlert(title: "Error", subtitle: "Please login to save your favorite recipes", leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
        }
    }
        
    func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: -16),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func setupContainerViewConstraints() {
        NSLayoutConstraint.activate([
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: frame.width / 5)
        ])
    }
    
    func setupStartCookingButton() {
        NSLayoutConstraint.activate([
            startCookingButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            startCookingButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -32),
            startCookingButton.heightAnchor.constraint(equalToConstant: 55),
            startCookingButton.widthAnchor.constraint(equalToConstant: frame.width * (2.5/4))
        ])
    }
    
    func setupSaveButtonConstraints() {
        NSLayoutConstraint.activate([
            saveButton.centerYAnchor.constraint(equalTo: startCookingButton.centerYAnchor),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            saveButton.heightAnchor.constraint(equalTo: startCookingButton.heightAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: frame.width * (1.2/4))
        ])
    }
    
    func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(startCookingButton)
        containerView.addSubview(saveButton)
        addSubview(tableView)
        
    }
    
    func layoutUI() {
        addSubviews()
        setupContainerViewConstraints()
        setupStartCookingButton()
        setupSaveButtonConstraints()
        setupTableViewConstraints()
    }
}

extension RecipesDetailsView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else if section == 1 {
            return recipeVC.ingredientsName.count
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientsTableViewCell", for: indexPath) as! IngredientsTableViewCell
            cell.recipeTitleLabel.text = recipeVC.recipeTitle
            let url = URL(string: recipeVC.recipeImage ?? "Error")
            cell.recipeImage.kf.setImage(with: url)
            //Calories
            let calories = recipeVC.recipeSummary?.match("[0-9]+ calories")
            let newCalories = calories?.joined()
            let usedCalories = newCalories?.joined().replacingOccurrences(of: " calories", with: "")
            cell.caloriesNumberLabel.text = usedCalories
            
            //Protein
            let protein = recipeVC.recipeSummary?.match("[0-9]+g of protein")
            let newProtein = protein?.joined()
            let usedProtein = newProtein?.joined().replacingOccurrences(of: " of protein", with: "")
            cell.proteinNumberLabel.text = usedProtein
            
            //Fat
            let fat = recipeVC.recipeSummary?.match("[0-9]+g of fat")
            let newFat = fat?.joined()
            let usedFat = newFat?.joined().replacingOccurrences(of: " of fat", with: "")
            cell.fatNumberLabel.text = usedFat
            let recipeInstruction = recipeVC.recipeInstructions?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
            cell.instructionsTextView.text = recipeInstruction
            cell.numberOfGredientsLabel.text = "\(recipeVC.ingredientsName.count) Ingredients"
            
            return cell
            
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NumberOfIngredientsTableViewCell", for: indexPath) as! NumberOfIngredientsTableViewCell
            cell.theNumberOfIngredient.text = recipeVC.sequence[indexPath.row]
            cell.theNameOfIngredient.text = recipeVC.ingredientsName[indexPath.row]
            if let weight = recipeVC.ingredientsWeight?[indexPath.row] {
                cell.theAmountOfIngredient.text = "\(String(format: "%.2f", weight)) \(recipeVC.ingredientsAmount?[indexPath.row] ?? "Error")"
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SimilarRecipesTableViewCell", for: indexPath) as! SimilarRecipesTableViewCell
            cell.recipesDetailsView = self
            cell.delegate = self
            cell.collectionView.reloadData()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
            return 200
        } else {
            return UITableView.automaticDimension
        }
    }
}

extension RecipesDetailsView: SimilarRecipesDelegate {
    func similarRecipesData(indexPath: Int) {
        transferData?.transferData(for: indexPath)
    }
}
