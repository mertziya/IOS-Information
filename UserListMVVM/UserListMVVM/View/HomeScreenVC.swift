//
//  ViewController.swift
//  UserListMVVM
//
//  Created by Mert Ziya on 27.01.2025.
//

import UIKit

class HomeScreenVC: UIViewController{
    
    // MARK: - Properties:
    let homeVM = HomeScreenVM()
    
    // Table view is updated each time the user array changes
    var users : [User] = [] {didSet{ DispatchQueue.main.async { self.userTableView.reloadData() }}}
    
    
    // MARK: - UI Elements:
    let userTableView = UITableView()
    let loadingIndicator = UIActivityIndicatorView()
    let errorMessage = UILabel()

    // MARK: - Lifecycles:
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        homeVM.delegate = self
        homeVM.fetchAllUsers()
    }

}

// MARK: - UI & Table View Configurations:
extension HomeScreenVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return users.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = userTableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as? UserCell else{
            print("DEBUG: dequeue error")
            return UITableViewCell()
        }
        
        cell.configureCell(with: users[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailVCViewController()
        vc.selectedUser = users[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    // Setup the UI Elements:
    private func setupUI(){
        view.backgroundColor = .systemBackground
        
        view.addSubview(userTableView)
        view.addSubview(loadingIndicator)
        view.addSubview(errorMessage)
        
        userTableView.delegate = self
        userTableView.dataSource = self
        userTableView.backgroundColor = .systemBackground
        userTableView.register(UINib(nibName: UserCell.nibName, bundle: nil), forCellReuseIdentifier: UserCell.identifier)
        
        loadingIndicator.hidesWhenStopped = true
        errorMessage.text = ""
        
        navigationItem.title = "Users"
        
        userTableView.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        errorMessage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            userTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            userTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            userTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: userTableView.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: userTableView.centerYAnchor),
            
            errorMessage.centerXAnchor.constraint(equalTo: userTableView.centerXAnchor),
            errorMessage.centerYAnchor.constraint(equalTo: userTableView.centerYAnchor),
        ])
    }
}



// MARK: - Network Binding:
extension HomeScreenVC : HomeScreenDelegate {
    
    func didFailWithError(error: any Error) {
        Alerts.showAler(at: self, title: "Error", message: error.localizedDescription)
        errorMessage.text = error.localizedDescription
    }
    
    func isLoadingWith(isLoading: Bool) {
        DispatchQueue.main.async {
            if isLoading{ self.loadingIndicator.startAnimating() }
            else{ self.loadingIndicator.stopAnimating() }
        }
    }
    
    func didFetchWithSuccess(users: [User]) {
        self.users = users
    }
    
}
