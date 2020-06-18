//
//  AlertViewController.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 6/17/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class AlertViewController: UIViewController, AlertDelegateAction {
    
    let activity = ActivityIndicator()
    
    lazy var mainView: AlertView = {
        let view = AlertView(frame: self.view.frame)
        view.delegate = self
        view.backgroundColor = .clear
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
    
    func dismissVC() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromBottom
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
    
    func signinUser() {
        activity.setupIndicatorView(view, containerColor: .white, indicatorColor: .customDarkGray())
        let username = mainView.userEmail
        let password = mainView.userPassword
        
        Auth.auth().signIn(withEmail: username, password: password) { (result, error) in
            if error != nil {
                self.activity.hideIndicatorView(self.view)
                Alert.showAlert(title: "Error", subtitle: "Incorrect email or password.", leftView: UIImageView(assetIdentifier: AssetIdentifier.error)!, style: .danger)
            } else {
                self.activity.hideIndicatorView(self.view)
                let transition = CATransition()
                transition.duration = 0.3
                transition.type = CATransitionType.fade
                transition.subtype = CATransitionSubtype.fromBottom
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
                self.view.window!.layer.add(transition, forKey: nil)
                self.dismiss(animated: false, completion: nil)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
