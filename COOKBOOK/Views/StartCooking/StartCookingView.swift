//
//  StartCookingView.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 3/25/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

@objc protocol StartCookingDelegateAction: class {
    @objc func dismissButtonTapped()
}

class StartCookingView: UIView {
    
    weak var delegate: StartCookingDelegateAction?
    private let widthConstant: CGFloat = 1.3
    var vc = StartCookingViewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(RecipeInformationsTableViewCell.self, forCellReuseIdentifier: "RecipeInformationsTableViewCell")
        tableView.register(RecipeStepsTableViewCell.self, forCellReuseIdentifier: "RecipeStepsTableViewCell")
        return tableView
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
    
    lazy var finishCookingButton: UIButton = {
        let finishCookingButton = UIButton(type: .system)
        finishCookingButton.setTitle("Finish", for: .normal)
        finishCookingButton.setTitleColor(.white, for: .normal)
        finishCookingButton.backgroundColor = .CustomGreen()
        finishCookingButton.layer.cornerRadius = 8.0
        finishCookingButton.translatesAutoresizingMaskIntoConstraints = false
        finishCookingButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 14)
        finishCookingButton.addTarget(delegate, action: #selector(delegate?.dismissButtonTapped), for: .touchUpInside)
        return finishCookingButton
    }()
    
    func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: finishCookingButton.topAnchor, constant: -16)
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
            finishCookingButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            finishCookingButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            finishCookingButton.widthAnchor.constraint(equalToConstant: frame.width / widthConstant),
            finishCookingButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    func addSubviews() {
        addSubview(tableView)
        addSubview(dismissButton)
        addSubview(finishCookingButton)
    }
    
    func layoutUI() {
        addSubviews()
        setupTableViewConstraints()
        setupDismissButtonConstraints()
        setupFinishCookingButtonConstraints()
    }
    
}

extension StartCookingView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return vc.instructionsSteps?.count ?? 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeInformationsTableViewCell", for: indexPath) as! RecipeInformationsTableViewCell
            cell.recipeTitleLabel.text = vc.recipeTitle
            cell.timerLabel.text = vc.recipeTime
            let url = URL(string: vc.recipeImage ?? "Error")
            cell.recipeImage.kf.setImage(with: url)
            cell.numberOfProcessLabel.text = "\(vc.instructionsSteps?.count ?? 1) steps"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeStepsTableViewCell", for: indexPath) as! RecipeStepsTableViewCell
            cell.nameOfProcessLabel.text = vc.instructionsSteps?[indexPath.row]
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
