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

class PopularRecipesTableViewCellCollectionViewCell: UITableViewCell, UICollectionViewDelegateFlowLayout {
    
    var recipes: RecipesData?
    var recipesDetails = [RecipeData]()

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
        AF.request("https://api.spoonacular.com/recipes/random?apiKey=db696760ce1043b08fc01d61d1ed0d35&number=10").responseJSON { (response) in
            if let error = response.error {
                print(error)
            }
            do {
                if let data = response.data {
                    self.recipes = try JSONDecoder().decode(RecipesData.self, from: data)
                    self.recipesDetails = self.recipes?.recipes ?? []
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
                
            } catch {
                print(error)
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

    lazy var seeAllCategoriesButton: UIButton = {
        let seeAllCategoriesButton = UIButton()
        seeAllCategoriesButton.setTitle("See all", for: .normal)
        seeAllCategoriesButton.setTitleColor(.CustomGreen(), for: .normal)
        seeAllCategoriesButton.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 14)
        seeAllCategoriesButton.translatesAutoresizingMaskIntoConstraints = false
        seeAllCategoriesButton.addTarget(self, action: #selector(test), for: .touchUpInside)
        return seeAllCategoriesButton
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
            categoriesNameLabel.centerYAnchor.constraint(equalTo: seeAllCategoriesButton.centerYAnchor)
        ])
    }

    func setupSeeAllCategoriesButtonConstraints() {
        NSLayoutConstraint.activate([
            seeAllCategoriesButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            seeAllCategoriesButton.topAnchor.constraint(equalTo: containerView.topAnchor)
        ])
    }

    func setupCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: seeAllCategoriesButton.bottomAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(categoriesNameLabel)
        containerView.addSubview(seeAllCategoriesButton)
        containerView.addSubview(collectionView)
    }

    func layoutUI() {
        addSubviews()
        setupCollectionViewConstraints()
        setupContainerViewConstraints()
        setupCategoriesNameLabelConstraints()
        setupSeeAllCategoriesButtonConstraints()
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
    
}
