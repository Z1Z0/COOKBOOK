//
//  SideMenuTableViewCell.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 2/26/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit
import SideMenu

class SideMenuTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutUI()
        backgroundColor = .CustomGreen()
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
    
    lazy var viewTitle: UILabel = {
        let viewTitle = UILabel()
        viewTitle.font = UIFont(name: "AvenirNext-Regular", size: 20)
        viewTitle.textColor = .white
        viewTitle.numberOfLines = 0
        viewTitle.translatesAutoresizingMaskIntoConstraints = false
        return viewTitle
    }()
    
    func setupContainerViewConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func setupFoodTitle() {
        NSLayoutConstraint.activate([
            viewTitle.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            viewTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
        ])
    }
    
    func addSubview() {
        addSubview(containerView)
        containerView.addSubview(viewTitle)
    }
    
    func layoutUI() {
        addSubview()
        setupContainerViewConstraints()
        setupFoodTitle()
    }

}
