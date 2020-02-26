//
//  ForgetPasswordView.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 2/19/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation
import UIKit
import Material

@objc protocol forgetPasswordDelegate: class {
    @objc func forgetPasswordTapped()
}

class ForgetPasswordView: UIView {
        
    let forgetPasswordStackView = UIStackView()
    fileprivate let widthConstant: CGFloat = 1.3
    fileprivate let height: CGFloat = 55
    let indicator = UIActivityIndicatorView()
    
    weak var delegate: forgetPasswordDelegate!
        
    init(delegate: forgetPasswordDelegate, frame: CGRect) {
        super.init(frame: frame)
        self.delegate = delegate
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var userEmail: String {
        return emailTxtField.text!
    }
    
    let viewName: UILabel = {
        let viewName = UILabel()
        viewName.text = "Forget your \nPassword!"
        viewName.numberOfLines = 0
        viewName.font = UIFont(name: "AvenirNext-Bold", size: 36)
        viewName.textColor = .customDarkGray()
        viewName.textAlignment = .left
        return viewName
    }()
    
    func setupViewNameConstraints() {
        NSLayoutConstraint.activate([
            viewName.leadingAnchor.constraint(equalTo: forgetPasswordStackView.leadingAnchor),
            viewName.trailingAnchor.constraint(equalTo: forgetPasswordStackView.trailingAnchor)
        ])
    }
    
    let emailTxtField: UITextField = {
        let emailTextField = ErrorTextField()
        emailTextField.backgroundColor = .white
        emailTextField.placeholder = "Email"
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
        NSLayoutConstraint.activate([
            emailTxtField.leadingAnchor.constraint(equalTo: forgetPasswordStackView.leadingAnchor),
            emailTxtField.trailingAnchor.constraint(equalTo: forgetPasswordStackView.trailingAnchor),
            emailTxtField.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    lazy var forgetPasswordButton: UIButton = {
        let forgetPasswordButton = UIButton()
        forgetPasswordButton.setTitle("Send email", for: .normal)
        forgetPasswordButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 14)
        forgetPasswordButton.backgroundColor = .customDarkGray()
        forgetPasswordButton.setTitleColor(.white, for: .normal)
        forgetPasswordButton.layer.cornerRadius = 8.0
        forgetPasswordButton.addTarget(delegate, action: #selector(delegate.forgetPasswordTapped), for: .touchUpInside)
        return forgetPasswordButton
    }()
    
    func setupForgetPasswordConstraints() {
        NSLayoutConstraint.activate([
            forgetPasswordButton.heightAnchor.constraint(equalToConstant: height),
            forgetPasswordButton.widthAnchor.constraint(equalToConstant: frame.width / widthConstant)
        ])
        
    }
    
    func setupForgetPasswordStackView() {
        addSubview(forgetPasswordStackView)
        forgetPasswordStackView.addArrangedSubview(viewName)
        forgetPasswordStackView.addArrangedSubview(emailTxtField)
        forgetPasswordStackView.addArrangedSubview(forgetPasswordButton)
        forgetPasswordStackView.axis = .vertical
        forgetPasswordStackView.distribution = .fill
        forgetPasswordStackView.alignment = .fill
        forgetPasswordStackView.spacing = 25
        forgetPasswordStackView.translatesAutoresizingMaskIntoConstraints = false
        setupForgetPasswordViewConstraint()
    }
    
    func setupForgetPasswordViewConstraint() {
        NSLayoutConstraint.activate([
            forgetPasswordStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            forgetPasswordStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            forgetPasswordStackView.widthAnchor.constraint(equalToConstant: frame.width / widthConstant)
        ])
        
    }
    
    func layoutUI() {
        addSubview(indicator)
        setupForgetPasswordStackView()
        setupViewNameConstraints()
        setupEmailConstraints()
        setupForgetPasswordConstraints()
        dismissKeyboard()
        checkTxtFields()
        setupIndicatorConstraints()
    }
    
    func setupIndicator() {
        indicator.style = .medium
        indicator.center = self.center
        indicator.color = .white
        indicator.backgroundColor = .clear
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
    }
    
    func setupIndicatorConstraints() {
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func dismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)
    }
    
    private func checkTxtFields() {
        forgetPasswordButton.isEnabled = false
        forgetPasswordButton.alpha = 0.4
        emailTxtField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        forgetPasswordButton.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
    }
    
    @objc private func editingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let email = emailTxtField.text, !email.isEmpty
            else {
                forgetPasswordButton.isEnabled = false
                forgetPasswordButton.alpha = 0.4
                return
        }
        forgetPasswordButton.isEnabled = true
        forgetPasswordButton.alpha = 1.0
    }
    
}

extension ForgetPasswordView: TextFieldDelegate {
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
