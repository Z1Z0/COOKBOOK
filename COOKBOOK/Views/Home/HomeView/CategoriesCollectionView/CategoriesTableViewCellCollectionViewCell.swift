//
//  CategoriesCollectionViewCell.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 3/1/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit

protocol RecipesDidselectActionDelegate: class {
    func categoriesTableViewCell(_ cell: UICollectionView, didSelectTitle title: String, ViewControllerTitle VCTitle: String)
}

class CategoriesTableViewCellCollectionViewCell: UITableViewCell, UICollectionViewDelegateFlowLayout {
        
    weak var recipesDidselectActionDelegate: RecipesDidselectActionDelegate?
    
    let categories: [String] = [
        "Main course",
        "Beef",
        "Chicken",
        "Seafood",
        "Vegetarian",
        "Breakfast",
        "Side dish",
        "Drink",
        "Sauce",
        "Soup",
        "Snacks",
        "Dessert"
    ]
    
    let categoriesTitle: [String] = [
        "main+course",
        "beef",
        "chicken",
        "seafood",
        "vegetarian",
        "breakfast",
        "side+dish",
        "drink",
        "sauce",
        "soup",
        "snacks",
        "dessert"
    ]
    
    let categoriesImages: [UIImage] = [
        UIImage(named: "maincourse")!,
        UIImage(named: "beef")!,
        UIImage(named: "chicken")!,
        UIImage(named: "seafood")!,
        UIImage(named: "vegetarian")!,
        UIImage(named: "breakfast")!,
        UIImage(named: "sidedish")!,
        UIImage(named: "drink")!,
        UIImage(named: "sauce")!,
        UIImage(named: "soup")!,
        UIImage(named: "snacks")!,
        UIImage(named: "dessert")!
    ]

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutUI()
        selectionStyle = .none
        self.backgroundColor = .clear
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
        categoriesNameLabel.text = "Categories"
        categoriesNameLabel.textColor = .customDarkGray()
        categoriesNameLabel.textAlignment = .left
        categoriesNameLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        categoriesNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return categoriesNameLabel
    }()

    @objc func test() {
        print("Test worked")
    }

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: "CategoriesCollectionViewCell")
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

extension CategoriesTableViewCellCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
        cell.categoriesImage.image = categoriesImages[indexPath.row]
        cell.categoryName.text = categories[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        recipesDidselectActionDelegate?.categoriesTableViewCell(collectionView, didSelectTitle: categoriesTitle[indexPath.row], ViewControllerTitle: categories[indexPath.row])
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w: CGFloat = self.frame.width * 0.4
        let h: CGFloat = collectionView.frame.size.height - 6.0
        return CGSize(width: w, height: h)
    }
    
}
