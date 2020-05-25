//
//  AboutUsViewController.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 4/25/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit
import Firebase

class AboutUsViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    lazy var mainView: AboutUsView = {
        let view = AboutUsView(frame: self.view.frame)
        view.backgroundColor = .white
        view.banner.rootViewController = self
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
        self.title = "About us"
        getAboutUsData()
    }
    
    func getAboutUsData() {
        db.collection("AppInfo").document("AboutUs").addSnapshotListener { (snapshot, error) in
            if error != nil {
                Alert.showAlert(title: "Error", subtitle: "Check your internet connection", leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
            } else {
                if let aboutUs = snapshot?["AboutUs"] as? String {
                    self.mainView.aboutCookbookLabel.text = aboutUs
                }
            }
        }
        
        db.collection("AppInfo").document("inquiry").addSnapshotListener { (snapshot, error) in
            if error != nil {
                Alert.showAlert(title: "Error", subtitle: "Check your internet connection", leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
            } else {
                
                if let inquiry = snapshot?["inquiry"] as? String {
                    self.mainView.informationLabel.text = inquiry
                }
                
            }
        }
    }

}

extension AboutUsViewController: GoToAboutUsDelegate {
    
    func goToAboutUs() {
        let vc = ContactUsViewController()
        self.show(vc, sender: nil)
    }
    
}
