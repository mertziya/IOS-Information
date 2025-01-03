//
//  ViewController.swift
//  ViewModelWithProtocols
//
//  Created by Mert Ziya on 27.12.2024.
//

import UIKit
import Kingfisher

class UserController: UIViewController, UserViewModelDelegate{
    private let viewModel = UserViewModel()
    private var user: User?
    
    func didFetchUser(_ user: User) {
        self.user = user
        DispatchQueue.main.async {
            self.username.text = user.username ?? "nil"
            self.fullname.text = user.fullname ?? "nil"
            if let imageUrl = user.imageURL{
                self.profileImageView.contentMode = .scaleAspectFill
                self.profileImageView.kf.setImage(with: URL(string: imageUrl), placeholder: UIImage(systemName: "photo.circle"))
            }else{print("DEBUG: the url is nil")}
        }
    }
    
    func didFailWithError(_ error: any Error) {
        DispatchQueue.main.async {
            self.username.text = "Error while Fetching"
            self.fullname.text = "Error while Fetching"
            self.profileImageView.image = UIImage(systemName: "person.crop.circle.badge.exclamationmark") // Replace "placeholder" with your image asset name
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.delegate = self
        
        fetchButton.addTarget(self, action: #selector(fetchUserData), for: .touchUpInside)
        updateButton.addTarget(self, action: #selector(updateUserData), for: .touchUpInside)
    }
    @objc private func fetchUserData(){ // Updates the user on each click.
        viewModel.loadUser(withId: "u8GJi17IE79XL4ivcArl") // Example Firebase document ID, not suitable, used or simplicity.
                                                           // Because delegate of viewmodel is assigned to self, this line of code will call the related function wirh loadUser
                                                           // In our case it called didFetchUser since there was no error to call didFailWithError.
    }
    @objc private func updateUserData(){
        let vc = UpdateUserVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // MARK: - UI Configurations:
    let username = UILabel()
    let fullname = UILabel()
    let profileImageView = UIImageView()
    let fetchButton = UIButton()
    let updateButton = UIButton()
    
    private func setupUI() {
        // Set up dummy text and image
        username.text = "Default Username"
        fullname.text = "Default Fullname"
        profileImageView.image = UIImage(systemName: "photo")
        fetchButton.setTitle("Fetch Data", for: .normal)
        updateButton.setTitle("Update Data", for: .normal)

        // Customize appearance
        username.textAlignment = .center
        fullname.textAlignment = .center
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.layer.cornerRadius = 50 // Circular image
        profileImageView.clipsToBounds = true
        fetchButton.backgroundColor = .systemBlue
        fetchButton.setTitleColor(.white, for: .normal)
        fetchButton.layer.cornerRadius = 10
        updateButton.backgroundColor = .systemYellow
        updateButton.setTitleColor(.darkGray, for: .normal)
        updateButton.layer.cornerRadius = 10
        

        // Add subviews
        view.addSubview(username)
        view.addSubview(fullname)
        view.addSubview(profileImageView)
        view.addSubview(fetchButton)
        view.addSubview(updateButton)

        // Disable autoresizing masks
        username.translatesAutoresizingMaskIntoConstraints = false
        fullname.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        fetchButton.translatesAutoresizingMaskIntoConstraints = false
        updateButton.translatesAutoresizingMaskIntoConstraints = false

        // Add constraints
        NSLayoutConstraint.activate([
            // Profile image constraints
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 250),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),

            // Username label constraints
            username.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            username.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            username.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            username.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            // Fullname label constraints
            fullname.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fullname.topAnchor.constraint(equalTo: username.bottomAnchor, constant: 10),
            fullname.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            fullname.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            // Fetch button constraints
            fetchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fetchButton.topAnchor.constraint(equalTo: fullname.bottomAnchor, constant: 44),
            fetchButton.widthAnchor.constraint(equalToConstant: 150),
            fetchButton.heightAnchor.constraint(equalToConstant: 44),
            
            // Update button constraints
            updateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            updateButton.topAnchor.constraint(equalTo: fetchButton.bottomAnchor, constant: 20),
            updateButton.widthAnchor.constraint(equalToConstant: 150),
            updateButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

}

