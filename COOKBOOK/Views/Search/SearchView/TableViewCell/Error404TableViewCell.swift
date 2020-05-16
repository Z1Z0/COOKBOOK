//
//  Error404TableViewCell.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 4/18/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit

class Error404TableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutUI()
        selectionStyle = .none
        self.backgroundColor = .customVeryLightGray()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let stackView = UIStackView()
    
    func setupStackView() {
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var errorImage: UIImageView = {
        let errorImage = UIImageView()
        errorImage.contentMode = .scaleAspectFit
        errorImage.image = UIImage(named: "error")
        errorImage.translatesAutoresizingMaskIntoConstraints = false
        return errorImage
    }()
    
    lazy var errorTitle: UILabel = {
        let errorTitle = UILabel()
        errorTitle.text = "Oops! You're lost"
        errorTitle.textColor = .CustomGreen()
        errorTitle.textAlignment = .center
        errorTitle.translatesAutoresizingMaskIntoConstraints = false
        errorTitle.numberOfLines = 0
        errorTitle.font = UIFont(name: "AvenirNext-Bold", size: 25)
        return errorTitle
    }()
    
    lazy var errorTitleDescription: UILabel = {
        let errorTitle = UILabel()
        errorTitle.text = "The recipe you enterted \nmight be incorrect \nor \nwe doesn't have the recipe in our database"
        errorTitle.textColor = .CustomGreen()
        errorTitle.textAlignment = .center
        errorTitle.translatesAutoresizingMaskIntoConstraints = false
        errorTitle.numberOfLines = 0
        errorTitle.font = UIFont(name: "AvenirNext-Regular", size: 16)
        return errorTitle
    }()
    
    func setupStackViewConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    func setupErrorImageConstraints() {
        NSLayoutConstraint.activate([
            errorImage.heightAnchor.constraint(equalToConstant: frame.height / 5)
        ])
    }
    
    func addSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(errorImage)
        stackView.addArrangedSubview(errorTitle)
        stackView.addArrangedSubview(errorTitleDescription)
    }
    
    func layoutUI() {
        addSubviews()
        setupStackView()
        setupStackViewConstraints()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
