//
//  UINavigationController + Ext.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 4/20/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    func setTransparentNavagtionBar(_ barColor: UIColor = .white, _ title:String = "",_ isTranslucent:Bool = false){
        self.navigationController?.navigationBar.isTranslucent = isTranslucent
        self.navigationController?.navigationBar.barTintColor = barColor
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.title = title
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setCustomNavagationBar(_ barColor: UIColor = .white, _ title:String = "",_ isTranslucent:Bool = false){
        self.navigationController?.navigationBar.isTranslucent = isTranslucent
        self.navigationController?.navigationBar.barTintColor = barColor
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.title = title
    }
    
    func hideNavigationBar(){
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func hideStatusBar(){
        if #available(iOS 13.0, *) {
            let statusBar = UIView(frame: UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
            statusBar.isHidden = true
        } else {
            (UIApplication.shared.value(forKey: "statusBar")  as? UIView )?.isHidden = true
        }
    }
    
    func setStatusBarBackgroundColor(_ color: UIColor = .white) {
        
        if #available(iOS 13.0, *) {
            let statusBar = UIView(frame: UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
            statusBar.backgroundColor = color
            UIApplication.shared.keyWindow?.addSubview(statusBar)
        } else {
            (UIApplication.shared.value(forKey: "statusBar")  as? UIView )?.backgroundColor = color
        }
        
    }
}
