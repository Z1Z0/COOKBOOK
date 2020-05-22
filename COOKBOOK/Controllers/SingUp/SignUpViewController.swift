//
//  SignUpViewController.swift
//  COOKBOOK
//
//  Created by Ahmed Abd Elaziz on 2/12/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import UIKit
import Material
import Firebase

class SignUpViewController: UIViewController, SignupDelegate {
    
    let indicator = ActivityIndicator()
    let db = Firestore.firestore()
    var image: UIImage? = nil
    
    lazy var mainView: SignupView = {
        let view = SignupView(delegate: self, frame: self.view.frame)
        view.backgroundColor = .white
        view.imageDelegate = self
        return view
    }()
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    func registerBtnTapped() {
        indicator.setupIndicatorView(view, containerColor: .white, indicatorColor: .CustomGreen())
        self.view.alpha = 0.7
        let name = mainView.username
        let email = mainView.userEmail
        let password = mainView.userPassword
        let confirmPassword = mainView.userConfirmPassword
        guard let imageSelected = self.image else { return }
        guard let imageData = imageSelected.jpegData(compressionQuality: 0.4) else { return }
        
        let validateEmail = isValidEmail(emailStr: email)
        
        var data = [
            "Username": name,
            "Email": email,
            "ProfileImage": ""
        ]
        
        if validateEmail == true {
            if isValidPassword(testStr: password) == true {
                if confirmPassword == password {
                    Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                        if error == nil {
                            if let uid = Auth.auth().currentUser?.uid {
                                let storageRef = Storage.storage().reference(forURL: "gs://cookbook-5a8f7.appspot.com")
                                
                                let storageProfileRef = storageRef.child("profile").child(uid).child(uid)
                                
                                let metadata = StorageMetadata()
                                
                                metadata.contentType = "image/jpg"
                                
                                storageProfileRef.putData(imageData, metadata: metadata) { (storage, error) in
                                    if error != nil {
                                        Alert.showAlert(title: "Error", subtitle: error?.localizedDescription ?? "Error", leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
                                        return
                                    }
                                    storageProfileRef.downloadURL { (url, error) in
                                        if let metaImageUrl = url?.absoluteString {
                                            data["ProfileImage"] = metaImageUrl
                                            self.db.collection("Users").document(uid).setData(data)
                                        }
                                    }
                                }
                            }
                            
                            self.view.alpha = 1.0
                            self.indicator.hideIndicatorView(self.view)
                            Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                                
                            })
                            
                            self.view.alpha = 1.0
                            self.indicator.hideIndicatorView(self.view)
                            Alert.showAlert(title: "Email created", subtitle: "You have created your account. Please check your email and activate the account", leftView: UIImageView(image: #imageLiteral(resourceName: "isSuccessIcon")), style: .success)
                            let signinVC = SignInViewController()
                            self.show(signinVC, sender: nil)
                        } else {
                            self.view.alpha = 1.0
                            self.indicator.hideIndicatorView(self.view)
                            Alert.showAlert(title: "Error", subtitle: error!.localizedDescription, leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
                        }
                    }
                } else {
                    self.view.alpha = 1.0
                    self.indicator.hideIndicatorView(self.view)
                    Alert.showAlert(title: "Error", subtitle: "Password doesn't match", leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
                }
            } else {
                self.view.alpha = 1.0
                self.indicator.hideIndicatorView(self.view)
                Alert.showAlert(title: "Error", subtitle: "Please enter password that contains at least one uppercase, at least one digit, at least one lowercase, 8 characters total.", leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
            }
        } else {
            self.view.alpha = 1.0
            self.indicator.hideIndicatorView(self.view)
            Alert.showAlert(title: "Error", subtitle: "Please enter a valid email", leftView: UIImageView(image: #imageLiteral(resourceName: "isErrorIcon")), style: .danger)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        setupNavigation()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
}

extension SignUpViewController: UserImageDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func userImageTapped() {
        showImagePickerControllerActionSheet()
    }
    
    func showImagePickerControllerActionSheet() {
        let photoLibraryAction = UIAlertAction(title: "Choose from Library", style: .default) { (action) in
            self.showImagePickerController(sourceType: .photoLibrary)
        }
        let cameraAction = UIAlertAction(title: "Take from Camera", style: .default) { (action) in
            self.showImagePickerController(sourceType: .camera)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        AlertService.showAlert(style: .actionSheet, title: "Choose your image", message: nil, actions: [photoLibraryAction, cameraAction, cancelAction], completion: nil)
    }
    
    func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            mainView.userImage.image = editedImage
            image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            mainView.userImage.image = originalImage
            image = originalImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}
