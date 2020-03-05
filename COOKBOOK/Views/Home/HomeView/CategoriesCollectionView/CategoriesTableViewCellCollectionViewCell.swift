//
//  CategoriesCollectionViewCell.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 3/1/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit

class CategoriesTableViewCellCollectionViewCell: UITableViewCell, UICollectionViewDelegateFlowLayout {

    let categories = ["italian food", "chinese food", "korean food", "italian food", "chinese food", "korean food", "italian food", "chinese food", "korean food", "italian food", "chinese food", "korean food"]

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutUI()
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
        categoriesNameLabel.text = "Categories"
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
        collectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: "CategoriesCollectionViewCell")
        return collectionView
    }()

    func setupContainerViewConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            // should not be constrained to categoriesNameLabel height
            //containerView.heightAnchor.constraint(equalTo: categoriesNameLabel.heightAnchor)
            // constrain 16-pts from bottom of cell
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }

    func setupCategoriesNameLabelConstraints() {
        NSLayoutConstraint.activate([
            categoriesNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            // centerY to seeAllCategoriesButton
            categoriesNameLabel.centerYAnchor.constraint(equalTo: seeAllCategoriesButton.centerYAnchor)
        ])
    }

    func setupSeeAllCategoriesButtonConstraints() {
        NSLayoutConstraint.activate([
            seeAllCategoriesButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            // constrain top to containerView top
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
        // but categoriesNameLabel inside containerView
        //addSubview(categoriesNameLabel)
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


extension CategoriesTableViewCellCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w: CGFloat = self.frame.width * 0.4
        let h: CGFloat = collectionView.frame.size.height - 6.0
        return CGSize(width: w, height: h)
    }
    
}
