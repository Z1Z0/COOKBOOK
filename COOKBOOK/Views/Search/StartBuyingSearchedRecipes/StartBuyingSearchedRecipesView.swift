//
//  StartBuyingSearchedRecipesView.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 4/9/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation
import UIKit

class StartBuyingSearchedRecipesView: UIView {
    
    private let widthConstant: CGFloat = 1.3
    weak var delegate: StartCookingDelegateAction?
    var vc = StartBuyingSearchedRecipesViewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var startBuyingTableView: UITableView = {
        let startBuyingTableView = UITableView()
        startBuyingTableView.translatesAutoresizingMaskIntoConstraints = false
        startBuyingTableView.delegate = self
        startBuyingTableView.dataSource = self
        startBuyingTableView.rowHeight = UITableView.automaticDimension
        startBuyingTableView.estimatedRowHeight = 100
        startBuyingTableView.showsVerticalScrollIndicator = false
        startBuyingTableView.separatorStyle = .singleLine
        startBuyingTableView.backgroundColor = .customDarkGray()
        startBuyingTableView.register(StartBuyingIngredientsTableViewCell.self, forCellReuseIdentifier: "StartBuyingIngredientsTableViewCell")
        startBuyingTableView.register(ListOfIngredientsTableViewCell.self, forCellReuseIdentifier: "ListOfIngredientsTableViewCell")
        return startBuyingTableView
    }()
    
    lazy var dismissButton: UIButton = {
        let dismissButton = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 26, weight: .regular, scale: .large)
        dismissButton.setImage(UIImage(systemName: "multiply", withConfiguration: imageConfig), for: .normal)
        dismissButton.tintColor = .white
        dismissButton.addTarget(delegate, action: #selector(delegate?.dismissButtonTapped), for: .touchUpInside)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        return dismissButton
    }()
    
    lazy var finishBuyingButton: UIButton = {
        let finishBuyingButton = UIButton(type: .system)
        finishBuyingButton.setTitle("Finish", for: .normal)
        finishBuyingButton.setTitleColor(.white, for: .normal)
        finishBuyingButton.backgroundColor = .CustomGreen()
        finishBuyingButton.layer.cornerRadius = 8.0
        finishBuyingButton.translatesAutoresizingMaskIntoConstraints = false
        finishBuyingButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 14)
        finishBuyingButton.addTarget(delegate, action: #selector(delegate?.dismissButtonTapped), for: .touchUpInside)
        return finishBuyingButton
    }()
    
    func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            startBuyingTableView.topAnchor.constraint(equalTo: topAnchor),
            startBuyingTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            startBuyingTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            startBuyingTableView.bottomAnchor.constraint(equalTo: finishBuyingButton.topAnchor, constant: -16)
        ])
    }
    
    func setupDismissButtonConstraints() {
        NSLayoutConstraint.activate([
            dismissButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            dismissButton.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 16),
            dismissButton.widthAnchor.constraint(equalToConstant: frame.size.width / 8),
            dismissButton.heightAnchor.constraint(equalToConstant: frame.size.width / 8)
        ])
    }
    
    func setupFinishCookingButtonConstraints() {
        NSLayoutConstraint.activate([
            finishBuyingButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            finishBuyingButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            finishBuyingButton.widthAnchor.constraint(equalToConstant: frame.width / widthConstant),
            finishBuyingButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    func addSubviews() {
        addSubview(startBuyingTableView)
        addSubview(dismissButton)
        addSubview(finishBuyingButton)
    }
    
    func layoutUI() {
        addSubviews()
        setupTableViewConstraints()
        setupDismissButtonConstraints()
        setupFinishCookingButtonConstraints()
    }
    
}

extension StartBuyingSearchedRecipesView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return vc.ingredientsName?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StartBuyingIngredientsTableViewCell", for: indexPath) as! StartBuyingIngredientsTableViewCell
            cell.setNeedsLayout()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListOfIngredientsTableViewCell", for: indexPath) as! ListOfIngredientsTableViewCell
            cell.ingredientNamesLabel.text = vc.ingredientsName?[indexPath.row]
            if let weight = vc.ingredientsWeight?[indexPath.row] {
                cell.ingredientsWeightLabel.text = "\(String(format: "%.2f", weight)) \(vc.ingredientsAmount?[indexPath.row] ?? "Error")"
            }
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        } else {
            return UITableView.automaticDimension
        }
    }
    
}
