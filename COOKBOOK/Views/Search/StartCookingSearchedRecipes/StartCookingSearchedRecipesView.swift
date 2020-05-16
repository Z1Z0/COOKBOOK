//
//  StartCookingSearchedRecipesView.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 4/9/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation
import UIKit

class StartCookingSearchedRecipesView: UIView {
    
    weak var delegate: StartCookingDelegateAction?
    private let widthConstant: CGFloat = 1.3
    var vc = StartCookingSearchedRecipesViewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    var sequence = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50"]
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var startCookingTableView: UITableView = {
        let startCookingTableView = UITableView()
        startCookingTableView.translatesAutoresizingMaskIntoConstraints = false
        startCookingTableView.delegate = self
        startCookingTableView.dataSource = self
        startCookingTableView.rowHeight = UITableView.automaticDimension
        startCookingTableView.estimatedRowHeight = 100
        startCookingTableView.showsVerticalScrollIndicator = false
        startCookingTableView.separatorStyle = .none
        startCookingTableView.backgroundColor = .clear
        startCookingTableView.register(RecipeInformationsTableViewCell.self, forCellReuseIdentifier: "RecipeInformationsTableViewCell")
        startCookingTableView.register(RecipeStepsTableViewCell.self, forCellReuseIdentifier: "RecipeStepsTableViewCell")
        return startCookingTableView
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
            startCookingTableView.topAnchor.constraint(equalTo: topAnchor),
            startCookingTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            startCookingTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            startCookingTableView.bottomAnchor.constraint(equalTo: finishCookingButton.topAnchor, constant: -16)
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
        addSubview(startCookingTableView)
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

extension StartCookingSearchedRecipesView: UITableViewDelegate, UITableViewDataSource {
    
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
            cell.numberofProcessLabel.text = sequence[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
