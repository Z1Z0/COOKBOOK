//
//  UserTableViewCell.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 2/28/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutUI()
        let minHeight = 180
        let minHeightConstraint = contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: CGFloat(minHeight))
        minHeightConstraint.priority = UILayoutPriority(rawValue: 999)
        minHeightConstraint.isActive = true
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
    
    lazy var userPhoto: UIImageView = {
        let userPhoto = UIImageView()
        userPhoto.translatesAutoresizingMaskIntoConstraints = false
        userPhoto.layer.cornerRadius = frame.width / 6
        userPhoto.clipsToBounds = true
        return userPhoto
    }()
    
    lazy var username: UILabel = {
        let username = UILabel()
        username.textColor = .white
        username.text = "Ahmed Abd Elaziz"
        username.translatesAutoresizingMaskIntoConstraints = false
        return username
    }()
    
    func setupContainerViewConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func setupUserPhotoConstraints() {
        NSLayoutConstraint.activate([
            userPhoto.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            userPhoto.widthAnchor.constraint(equalToConstant: frame.width / 3),
            userPhoto.heightAnchor.constraint(equalToConstant: frame.width / 3),
            userPhoto.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16)
        ])
    }
    
    func setupUsernameConstraints() {
        NSLayoutConstraint.activate([
            username.topAnchor.constraint(lessThanOrEqualTo: userPhoto.bottomAnchor, constant: 16),
            username.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])
    }
    
    func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(userPhoto)
        containerView.addSubview(username)
    }
    
    func layoutUI() {
        
        addSubviews()
        setupContainerViewConstraints()
        setupUserPhotoConstraints()
        setupUsernameConstraints()
    }

}
