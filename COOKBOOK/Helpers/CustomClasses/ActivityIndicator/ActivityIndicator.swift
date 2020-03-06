//
//  ActivityIndicator.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 2/21/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation
import UIKit

class ActivityIndicator {
    
    static let shared = ActivityIndicator()
    
    let indicator = UIActivityIndicatorView()
    let indicatorContainer = UIView()
    let containerView = UIView()
    
    func setupIndicatorView(_ view: UIView, containerColor: UIColor, indicatorColor: UIColor) {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        view.alpha = 0.5
        containerView.isHidden = false
        indicator.style = .large
        indicator.color = indicatorColor
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.backgroundColor = .clear
        containerView.frame = window.frame
        containerView.center = window.center
        
        indicatorContainer.backgroundColor = containerColor
        indicatorContainer.alpha = 1.0
        indicatorContainer.layer.cornerRadius = 8.0
        indicatorContainer.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(indicatorContainer)
        indicatorContainer.addSubview(indicator)
        UIApplication.shared.keyWindow?.addSubview(containerView)
        
        func setupIndicatorContainerConstraints() {
            NSLayoutConstraint.activate([
                indicatorContainer.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                indicatorContainer.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                indicatorContainer.widthAnchor.constraint(equalToConstant: containerView.frame.width / 5),
                indicatorContainer.heightAnchor.constraint(equalToConstant: containerView.frame.width / 5)
            ])
        }
        
        func setupIndicatorViewConstraints() {
            NSLayoutConstraint.activate([
                indicator.centerXAnchor.constraint(equalTo: indicatorContainer.centerXAnchor),
                indicator.centerYAnchor.constraint(equalTo: indicatorContainer.centerYAnchor)
            ])
        }
        
        setupIndicatorContainerConstraints()
        setupIndicatorViewConstraints()
    }
    
    func hideIndicatorView(_ view: UIView) {
        DispatchQueue.main.async {
            view.alpha = 1.0
            self.indicator.stopAnimating()
            self.containerView.isHidden = true
            self.containerView.removeFromSuperview()
        }
    }
}
