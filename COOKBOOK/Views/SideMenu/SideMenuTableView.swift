//
//  SideMenuTableView.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 4/14/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation
import UIKit
import Firebase

protocol LogoutDelegate: class {
    func logoutTapped()
}

class SideMenuTableView: UIView {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    weak var delegate: LogoutDelegate?
    let db = Firestore.firestore()
    let uid = Auth.auth().currentUser?.uid
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .CustomGreen()
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: "UserTableViewCell")
        tableView.register(SideMenuTableViewCell.self, forCellReuseIdentifier: "SideMenuTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func addSubviews() {
        addSubview(tableView)
    }
    
    func layoutUI() {
        addSubviews()
        setupTableViewConstraints()
    }
    
}

extension SideMenuTableView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 7
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            
        case 0:
            
            switch indexPath.row {
                
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
                if let uid = uid {
                    db.collection("Users").document(uid).addSnapshotListener { (snapshot, error) in
                        if error != nil {
                            print(error?.localizedDescription)
                        } else {
                            if let dbUsername = snapshot?["Username"] as? String {
                                cell.username.text = dbUsername
                            }
                        }
                    }
                }
                
                return cell
                
            default:
                return UITableViewCell()
            }
            
        case 1:
            
            switch indexPath.row {
                
            case 0:
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell", for: indexPath) as! SideMenuTableViewCell
                cell.titleLabel.text = "Home"
                return cell
                
            case 1:
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell", for: indexPath) as! SideMenuTableViewCell
                cell.titleLabel.text = "Search recipes by ingredients"
                return cell
                
            case 2:
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell", for: indexPath) as! SideMenuTableViewCell
                cell.titleLabel.text = "Profile"
                return cell
                
            case 3:
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell", for: indexPath) as! SideMenuTableViewCell
                cell.titleLabel.text = "Rate our app"
                return cell
                
            case 4:
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell", for: indexPath) as! SideMenuTableViewCell
                cell.titleLabel.text = "About application"
                return cell
                
            case 5:
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell", for: indexPath) as! SideMenuTableViewCell
                cell.titleLabel.text = "Contact us"
                return cell
                
            case 6:
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell", for: indexPath) as! SideMenuTableViewCell
                cell.titleLabel.text = "Logout"
                return cell
                
            default:
                return UITableViewCell()
            }
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            switch indexPath.row {
            case 8:
                delegate?.logoutTapped()
            default:
                print("default")
            }
        default:
            print("default")
        }
    }
    
}
