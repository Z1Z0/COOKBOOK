//
//  ImageView + Ext.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 2/22/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation
import UIKit

enum AssetIdentifier: String {
    case success = "isSuccessIcon"
    case error = "isErrorIcon"
}

extension UIImageView {
    convenience init?(assetIdentifier: AssetIdentifier) {
        self.init(image: UIImage(named: assetIdentifier.rawValue))
    }
}


