//
//  Alert.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 2/17/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation
import UIKit
import NotificationBannerSwift

class Alert {

    class func showAlert(title: String, subtitle: String, leftView: UIView, style: BannerStyle) {
        
        let alert = GrowingNotificationBanner(title: title, subtitle: subtitle, leftView: leftView, style: style, iconPosition: .center)
        alert.show()
    }
}
