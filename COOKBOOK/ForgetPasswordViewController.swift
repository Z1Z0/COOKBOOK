//
//  ForgetPasswordViewController.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 2/12/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit
import Material

class ForgetPasswordViewController: UIViewController {
    
    let forgetPasswordStackView = UIStackView()
    fileprivate let widthConstant: CGFloat = 1.3
    fileprivate let height: CGFloat = 55
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupForgetPasswordStackView()
        setupViewName()
        setupEmailConstraints()
        setupForgetPasswordConstraints()
        dismissKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    let viewName: UILabel = {
        let viewName = UILabel()
        viewName.text = "Forget your \nPassword!"
        viewName.numberOfLines = 2
        viewName.font = UIFont(name: "AvenirNext-Bold", size: 36)
        viewName.textColor = .customDarkGray()
        viewName.textAlignment = .left
        return viewName
    }()
    
    func setupViewName() {
        view.addSubview(viewName)
        viewName.translatesAutoresizingMaskIntoConstraints = false
        viewName.bottomAnchor.constraint(equalTo: forgetPasswordStackView.topAnchor, constant: -25).isActive = true
        viewName.leadingAnchor.constraint(equalTo: forgetPasswordStackView.leadingAnchor).isActive = true
        viewName.trailingAnchor.constraint(equalTo: forgetPasswordStackView.trailingAnchor).isActive = true
    }
    
    let emailTxtField: UITextField = {
        let emailTextField = ErrorTextField()
        emailTextField.backgroundColor = .white
        emailTextField.placeholder = "Email"
        emailTextField.layer.sublayerTransform = CATransform3DMakeTranslation(16,0,0)
        emailTextField.keyboardType = .emailAddress
        emailTextField.layer.cornerRadius = 8.0
        emailTextField.isClearIconButtonEnabled = true
        emailTextField.isPlaceholderUppercasedWhenEditing = false
        emailTextField.placeholderAnimation = .default
        emailTextField.placeholderActiveColor = .gray
        emailTextField.detailColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        emailTextField.dividerActiveColor = #colorLiteral(red: 0.1098039216, green: 0.6196078431, blue: 0.0431372549, alpha: 1)
        emailTextField.autocapitalizationType = .none
        emailTextField.placeholderLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        emailTextField.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        emailTextField.placeholderNormalColor = .customDarkGray()
        return emailTextField
    }()
    
    func setupEmailConstraints() {
        emailTxtField.leadingAnchor.constraint(equalTo: forgetPasswordStackView.leadingAnchor).isActive = true
        emailTxtField.trailingAnchor.constraint(equalTo: forgetPasswordStackView.trailingAnchor).isActive = true
        emailTxtField.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    let forgetPasswordButton: UIButton = {
        let forgetPasswordButton = UIButton()
        forgetPasswordButton.setTitle("Send email", for: .normal)
        forgetPasswordButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 14)
        forgetPasswordButton.backgroundColor = .customDarkGray()
        forgetPasswordButton.setTitleColor(.white, for: .normal)
        forgetPasswordButton.layer.cornerRadius = 8.0
        return forgetPasswordButton
    }()
    
    func setupForgetPasswordConstraints() {
        forgetPasswordButton.heightAnchor.constraint(equalToConstant: height).isActive = true
        forgetPasswordButton.widthAnchor.constraint(equalToConstant: view.frame.width / widthConstant).isActive = true
    }
    
    func setupForgetPasswordStackView() {
        view.addSubview(forgetPasswordStackView)
        forgetPasswordStackView.addArrangedSubview(emailTxtField)
        forgetPasswordStackView.addArrangedSubview(forgetPasswordButton)
        forgetPasswordStackView.axis = .vertical
        forgetPasswordStackView.distribution = .fillEqually
        forgetPasswordStackView.alignment = .center
        forgetPasswordStackView.spacing = 25
        setupForgetPasswordViewConstraint()
    }
    
    func setupForgetPasswordViewConstraint() {
        forgetPasswordStackView.translatesAutoresizingMaskIntoConstraints = false
        forgetPasswordStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        forgetPasswordStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        forgetPasswordStackView.widthAnchor.constraint(equalToConstant: view.frame.width / widthConstant).isActive = true
    }
    
    func dismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
}

extension ForgetPasswordViewController: TextFieldDelegate {
    public func textFieldDidEndEditing(_ textField: UITextField) {
        (textField as? ErrorTextField)?.isErrorRevealed = false
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        (textField as? ErrorTextField)?.isErrorRevealed = false
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        (textField as? ErrorTextField)?.isErrorRevealed = true
        return true
    }
}
