//
//  updateUserVC.swift
//  ViewModelWithProtocols
//
//  Created by Mert Ziya on 27.12.2024.
//

import Foundation
import UIKit

class UpdateUserVC : UIViewController{
    
    
    // MARK: - Properties:
    private var viewModel = UserViewModel()
    
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        
        updateButton.addTarget(self, action: #selector(updateData), for: .touchUpInside)
    }
    @objc private func updateData() {
        var user = User()
        if textField1.text != "" {user.username = textField1.text}
        if textField2.text != "" {user.fullname = textField2.text}
        viewModel.updateUser(userId: "u8GJi17IE79XL4ivcArl", user: user)
        
        self.navigationController?.popViewController(animated: true)
    }
    
  
       
    
    
    
    // MARK: - UI Configuartions:
    private let textField1: UITextField = {
       let textField = UITextField()
       textField.placeholder = "Update username"
       textField.borderStyle = .roundedRect
       textField.translatesAutoresizingMaskIntoConstraints = false
       return textField
    }()
   
    private let textField2: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Update Fullname"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
   
    private let updateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Update Data", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func setupUI() {
       // Add subviews
       view.addSubview(textField1)
       view.addSubview(textField2)
       view.addSubview(updateButton)
       
       // Set constraints
       NSLayoutConstraint.activate([
           // TextField 1
           textField1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
           textField1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
           textField1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
           textField1.heightAnchor.constraint(equalToConstant: 40),
           
           // TextField 2
           textField2.topAnchor.constraint(equalTo: textField1.bottomAnchor, constant: 20),
           textField2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
           textField2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
           textField2.heightAnchor.constraint(equalToConstant: 40),
           
           // Update Button
           updateButton.topAnchor.constraint(equalTo: textField2.bottomAnchor, constant: 40),
           updateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           updateButton.widthAnchor.constraint(equalToConstant: 200),
           updateButton.heightAnchor.constraint(equalToConstant: 50)
       ])
            
    }
       
       
}
