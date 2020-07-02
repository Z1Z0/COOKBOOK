//
//  SimilarRecipesTableViewCell.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 6/29/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

protocol SimilarRecipesDelegate: class {
    func similarRecipesData(indexPath: Int)
}

class SimilarRecipesTableViewCell: UITableViewCell, UICollectionViewDelegateFlowLayout {
    
    var similarRecipes = [SimilarRecipesModel]()
    var bulkRecipes = [Recipe]()
    var recipesDetailsView = RecipesDetailsView()
    var recipeID: String?
    weak var delegate: SimilarRecipesDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutUI()
//        fetchData()
        self.backgroundColor = .clear
        selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .clear
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()

    lazy var categoriesNameLabel: UILabel = {
        let categoriesNameLabel = UILabel()
        categoriesNameLabel.text = "Similar recipes"
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
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
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

extension SimilarRecipesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipesDetailsView.recipeVC.bulkRecipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularRecipesCollectionViewCell", for: indexPath) as! PopularRecipesCollectionViewCell
        cell.recipesTitle.text = recipesDetailsView.recipeVC.bulkRecipes[indexPath.row].title
        let url = URL(string: recipesDetailsView.recipeVC.bulkRecipes[indexPath.row].image ?? "Error")
        cell.popularRecipesImage.kf.setImage(with: url)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.similarRecipesData(indexPath: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w: CGFloat = self.frame.width * 0.7
        let h: CGFloat = collectionView.frame.size.height - 6.0
        return CGSize(width: w, height: h)
    }
}
