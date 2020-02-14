//
//  Alert.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 2/13/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation
import CFAlertViewController
import Firebase

extension UIViewController {
    
    func errorAlert (title: String, message: String, actionTitle: String) {
        let alert = CFAlertViewController(title: title, message: message, textAlignment: .left, preferredStyle: .alert, didDismissAlertHandler: nil)
        alert.backgroundStyle = .blur
        let action = CFAlertAction(title: actionTitle, style: .Destructive, alignment: .center, backgroundColor: .red, textColor: .white) { (action) in
            print("Button \(action) tapped")
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func correctSignupAlert (title: String, message: String, actionTitle: String) {
        let alert = CFAlertViewController(title: title, message: message, textAlignment: .left, preferredStyle: .alert, didDismissAlertHandler: nil)
        alert.backgroundStyle = .blur
        let action = CFAlertAction(title: actionTitle, style: .Default, alignment: .center, backgroundColor: .CustomGreen(), textColor: .white) { (action) in
            let vc = SignInViewController()
            self.show(vc, sender: nil)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func resendActivationLinkAlert (title: String, message: String, actionTitle: String) {
        let alert = CFAlertViewController(title: title, message: message, textAlignment: .left, preferredStyle: .alert, didDismissAlertHandler: nil)
        alert.backgroundStyle = .blur
        let action = CFAlertAction(title: actionTitle, style: .Destructive, alignment: .center, backgroundColor: .red, textColor: .white) { (action) in
            
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
}
