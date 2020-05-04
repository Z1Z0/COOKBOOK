//
//  SearchByIngredientsView.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 4/20/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation
import UIKit

@objc protocol AddIngredientsToCollectionDelegate: class {
    @objc func addingIngredientsToCollection()
    @objc func searchByIngredients()
}

class SearchByIngredientsView: UIView, UITextFieldDelegate {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var ingredientsArray: [String] = []
    var cleanIngredientsArray: [String] = []
    var sectionInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    fileprivate let widthConstant: CGFloat = 1.3
    fileprivate let height: CGFloat = 55
    weak var delegate: AddIngredientsToCollectionDelegate?
    weak var deleteDelegate: DeleteIngredientsDelegate?
    
    lazy var addIngrediantsInstructionsLabel: UILabel = {
        let addIngrediantsInstructionsLabel = UILabel()
        addIngrediantsInstructionsLabel.text = "You can search for recipes that you can cook with your available ingredients"
        addIngrediantsInstructionsLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        addIngrediantsInstructionsLabel.textColor = .customDarkGray()
        addIngrediantsInstructionsLabel.numberOfLines = 0
        addIngrediantsInstructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        return addIngrediantsInstructionsLabel
    }()
    
    func setupAddIngrediantsInstructionsLabelConstraints() {
        NSLayoutConstraint.activate([
            addIngrediantsInstructionsLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            addIngrediantsInstructionsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            addIngrediantsInstructionsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    lazy var addIngrediantsTextField: UITextField = {
        let addIngrediantsTextField = UITextField()
        addIngrediantsTextField.layer.cornerRadius = 8.0
        addIngrediantsTextField.delegate = self
        let bordColor = UIColor(red: 28/255, green: 158/255, blue: 11/255, alpha: 1)
        addIngrediantsTextField.layer.borderColor = bordColor.cgColor
        addIngrediantsTextField.addPadding(padding: .left(15.0))
        addIngrediantsTextField.layer.borderWidth = 1.0
        addIngrediantsTextField.backgroundColor = .customVeryLightGray()
        addIngrediantsTextField.textColor = .black
        addIngrediantsTextField.translatesAutoresizingMaskIntoConstraints = false
        addIngrediantsTextField.keyboardType = .alphabet
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.customLightDarkGray(), NSAttributedString.Key.font : UIFont(name: "AvenirNext-DemiBold", size: 14)!]
        addIngrediantsTextField.attributedPlaceholder = NSAttributedString(string: "Add the ingredients one by one", attributes: attributes)
        addIngrediantsTextField.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        addIngrediantsTextField.textColor = .customDarkGray()
        return addIngrediantsTextField
    }()
    
    func setupAddIngrediantsTextFieldConstraints() {
        NSLayoutConstraint.activate([
            addIngrediantsTextField.topAnchor.constraint(equalTo: addIngrediantsInstructionsLabel.bottomAnchor, constant: 16),
            addIngrediantsTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            addIngrediantsTextField.trailingAnchor.constraint(equalTo: addIngredientsButton.leadingAnchor, constant: -16),
            addIngrediantsTextField.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    lazy var addIngredientsButton: UIButton = {
        let addIngredientsButton = UIButton(type: .system)
        addIngredientsButton.setTitle("Add", for: .normal)
        addIngredientsButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 14)
        addIngredientsButton.backgroundColor = .customDarkGray()
        addIngredientsButton.setTitleColor(.white, for: .normal)
        addIngredientsButton.layer.cornerRadius = 8.0
        addIngredientsButton.addTarget(delegate, action: #selector(delegate?.addingIngredientsToCollection), for: .touchUpInside)
        addIngredientsButton.translatesAutoresizingMaskIntoConstraints = false
        return addIngredientsButton
    }()
    
    func setupAddIngredientsButtonConstraints() {
        NSLayoutConstraint.activate([
            addIngredientsButton.topAnchor.constraint(equalTo: addIngrediantsInstructionsLabel.bottomAnchor, constant: 16),
            addIngredientsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            addIngredientsButton.heightAnchor.constraint(equalToConstant: 55),
            addIngredientsButton.widthAnchor.constraint(equalToConstant: frame.width / 5)
        ])
    }
    
    lazy var addIngrediantsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let addIngrediantsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        addIngrediantsCollectionView.backgroundColor = .white
        addIngrediantsCollectionView.register(SearchByIngredientsViewCollectionViewCell.self, forCellWithReuseIdentifier: "SearchByIngredientsViewCollectionViewCell")
        addIngrediantsCollectionView.delegate = self
        addIngrediantsCollectionView.dataSource = self
        addIngrediantsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        return addIngrediantsCollectionView
    }()
    
    func addIngrediantsCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            addIngrediantsCollectionView.topAnchor.constraint(equalTo: addIngrediantsTextField.bottomAnchor, constant: 16),
            addIngrediantsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            addIngrediantsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            addIngrediantsCollectionView.bottomAnchor.constraint(equalTo: searchRecipeButton.topAnchor, constant: -16)
        ])
    }
    
    lazy var searchRecipeButton: UIButton = {
        let searchRecipeButton = UIButton(type: .system)
        searchRecipeButton.setTitle("Search recipe", for: .normal)
        searchRecipeButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 14)
        searchRecipeButton.backgroundColor = .customDarkGray()
        searchRecipeButton.setTitleColor(.white, for: .normal)
        searchRecipeButton.layer.cornerRadius = 8.0
        searchRecipeButton.addTarget(delegate, action: #selector(delegate?.searchByIngredients), for: .touchUpInside)
        searchRecipeButton.translatesAutoresizingMaskIntoConstraints = false
        return searchRecipeButton
    }()
    
    func searchRecipeButtonConstraints() {
        NSLayoutConstraint.activate([
            searchRecipeButton.heightAnchor.constraint(equalToConstant: height),
            searchRecipeButton.widthAnchor.constraint(equalToConstant: frame.width / widthConstant),
            searchRecipeButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            searchRecipeButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func addSubviews() {
        addSubview(addIngrediantsInstructionsLabel)
        addSubview(addIngredientsButton)
        addSubview(addIngrediantsTextField)
        addSubview(addIngrediantsCollectionView)
        addSubview(searchRecipeButton)
    }
    
    func layoutUI() {
        addSubviews()
        setupAddIngrediantsInstructionsLabelConstraints()
        setupAddIngredientsButtonConstraints()
        setupAddIngrediantsTextFieldConstraints()
        addIngrediantsCollectionViewConstraints()
        searchRecipeButtonConstraints()
    }
    
}

extension SearchByIngredientsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, DeleteIngredientsDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cleanIngredientsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchByIngredientsViewCollectionViewCell", for: indexPath) as! SearchByIngredientsViewCollectionViewCell
        cell.ingredientTitleLabel.text = cleanIngredientsArray[indexPath.row]
        cell.deleteIngredient.addTarget(self, action: #selector(deleteIngredient(sender:)), for: .touchUpInside)
        cell.delegate = self
        cell.deleteIngredient.tag = indexPath.row
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (frame.width / 2) - 32, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    @objc func deleteIngredient(sender: UIButton) {
        deleteDelegate?.deleteButtonTapped(sender.tag)
    }
    
    func deleteButtonTapped(_ tag: Int) {
        let buttonRow = tag
        self.cleanIngredientsArray.remove(at: buttonRow)
        self.ingredientsArray = []
        let indexSet = IndexSet(integer: 0)
        self.addIngrediantsCollectionView.deleteItems(at: [IndexPath.init(row: buttonRow, section: 0)])
        self.addIngrediantsCollectionView.reloadSections(indexSet)
    }
}
