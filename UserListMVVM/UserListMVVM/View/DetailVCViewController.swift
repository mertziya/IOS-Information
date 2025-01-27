//
//  DetailVCViewController.swift
//  UserListMVVM
//
//  Created by Mert Ziya on 27.01.2025.
//

import UIKit

class DetailVCViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    
    var selectedUser : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDetailsData(with: selectedUser)
    }
    

}



// MARK: - Set the data of the View:
extension DetailVCViewController{
    
    private func configureDetailsData(with user : User?){
        nameLabel.text = user?.name ?? ""
        emailLabel.text = user?.email ?? ""
        phoneLabel.text = user?.phone ?? ""
        websiteLabel.text = user?.website ?? ""
        companyLabel.text = user?.company?.name ?? ""
        formatAdress(address: user?.address) { formattedAdress in
            adressLabel.text = formattedAdress
        }
        
    }
    
    private func formatAdress(address : Address? , completion : (String) -> ()) {
        guard let address = address else{print("DEBUG: adress is nil") ; return}
        
        var addressString = ""
    
        addressString.append("\(address.street ?? ""), ")
        addressString.append("\(address.suite ?? ""), ")
        addressString.append("\(address.city ?? ""), ")
        addressString.append("\(address.zipcode ?? "")")

        completion(addressString)
    }
    
}
