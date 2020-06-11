//
//  ContactUsViewController.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 4/24/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit
import MessageUI
import Firebase

class ContactUsViewController: UIViewController, MFMailComposeViewControllerDelegate, SendEmailDelegate {
    
    lazy var mainView: ContactUsView = {
        let view = ContactUsView(frame: self.view.frame)
        view.backgroundColor = .white
        view.delegate = self
        return view
    }()
    
    override func loadView() {
        super.loadView()
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSideMenu()
        preferedLargeTitle()
        self.title = "Contact us"
    }
    
    func sendEmail() {
        if Auth.auth().currentUser?.uid != nil {
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients(["ahmedabdelaziz500@icloud.com"])
                mail.setSubject(mainView.subjectTextField.text ?? "Subject")
                mail.setMessageBody(mainView.emailBodyTextView.text, isHTML: false)
                present(mail, animated: true)
            } else {
                Alert.showAlert(title: "Error", subtitle: "Check your internet connectivity", leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
            }
        } else {
            Alert.showAlert(title: "Error", subtitle: "Please login so you can send us email", leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }

}
