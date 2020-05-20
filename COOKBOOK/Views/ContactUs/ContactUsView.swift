//
//  ContactUsView.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 4/24/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation
import UIKit

@objc protocol SendEmailDelegate: class {
    @objc func sendEmail()
}

class ContactUsView: UIView, UITextViewDelegate {
    
    weak var delegate: SendEmailDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var subjectTextField: UITextField = {
        let subjectTextField = UITextField()
        subjectTextField.textColor = .customDarkGray()
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.customLightGray()]
        subjectTextField.attributedPlaceholder = NSAttributedString(string: "Email subject", attributes: attributes)
        subjectTextField.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        subjectTextField.layer.cornerRadius = 8.0
        let bordColor = UIColor(red: 28/255, green: 158/255, blue: 11/255, alpha: 1)
        subjectTextField.layer.borderColor = bordColor.cgColor
        subjectTextField.layer.borderWidth = 1.0
        subjectTextField.backgroundColor = .white
        subjectTextField.keyboardType = .alphabet
        subjectTextField.addPadding(padding: .left(15.0))
        subjectTextField.translatesAutoresizingMaskIntoConstraints = false
        return subjectTextField
    }()
    
    func setupSubjectLabelConstraints() {
        NSLayoutConstraint.activate([
            subjectTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            subjectTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            subjectTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            subjectTextField.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    lazy var emailBodyTextView: UITextView = {
        let emailBodyTextView = UITextView()
        emailBodyTextView.text = "Tell us a litte more about your issue or request"
        emailBodyTextView.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        emailBodyTextView.textColor = UIColor.customLightGray()
        let bordColor = UIColor(red: 28/255, green: 158/255, blue: 11/255, alpha: 1)
        emailBodyTextView.layer.borderColor = bordColor.cgColor
        emailBodyTextView.layer.borderWidth = 1.0
        emailBodyTextView.backgroundColor = .white
        emailBodyTextView.layer.cornerRadius = 8.0
        emailBodyTextView.delegate = self
        emailBodyTextView.textContainerInset = UIEdgeInsets(top: 16, left: 10, bottom: 16, right: 10)
        emailBodyTextView.translatesAutoresizingMaskIntoConstraints = false
        return emailBodyTextView
    }()
    
    func setupEmailBodyTextView() {
        NSLayoutConstraint.activate([
            emailBodyTextView.topAnchor.constraint(equalTo: subjectTextField.bottomAnchor, constant: 16),
            emailBodyTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            emailBodyTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            emailBodyTextView.heightAnchor.constraint(equalToConstant: self.frame.height / 3)
        ])
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.customLightGray() {
            textView.text = nil
            textView.textColor = UIColor.customDarkGray()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Tell us a litte more about your issue or request"
            textView.textColor = UIColor.customLightGray()
        }
    }
    
    lazy var sendEmailButton: UIButton = {
        let sendEmailButton = UIButton(type: .system)
        sendEmailButton.setTitle("Send email", for: .normal)
        sendEmailButton.setTitleColor(.white, for: .normal)
        sendEmailButton.backgroundColor = .customDarkGray()
        sendEmailButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 16)
        sendEmailButton.layer.cornerRadius = 8.0
        sendEmailButton.addTarget(delegate, action: #selector(delegate?.sendEmail), for: .touchUpInside)
        sendEmailButton.translatesAutoresizingMaskIntoConstraints = false
        return sendEmailButton
    }()
    
    func setupSendEmailButtonConstraints() {
        NSLayoutConstraint.activate([
            sendEmailButton.topAnchor.constraint(equalTo: emailBodyTextView.bottomAnchor, constant: 16),
            sendEmailButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            sendEmailButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            sendEmailButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    private func dismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)
    }
    
    func addSubviews() {
        addSubview(subjectTextField)
        addSubview(emailBodyTextView)
        addSubview(sendEmailButton)
    }
    
    func layoutUI() {
        addSubviews()
        setupSubjectLabelConstraints()
        setupEmailBodyTextView()
        setupSendEmailButtonConstraints()
        dismissKeyboard()
    }
    
}
