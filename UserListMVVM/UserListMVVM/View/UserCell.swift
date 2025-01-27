//
//  UserCell.swift
//  UserListMVVM
//
//  Created by Mert Ziya on 27.01.2025.
//

import UIKit

class UserCell: UITableViewCell {
    
    static let nibName = "UserCell"
    static let identifier = "Identifier"

    @IBOutlet weak var rowNumber: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
 
    override func layoutSubviews() {
        super.layoutSubviews()
        
        clipsToBounds = true
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
        
    }
    
    func configureCell(with user : User){
        
        rowNumber.text = String(describing: user.id ?? 10)
        nameLabel.text = user.name ?? "None"
        emailLabel.text = user.email ?? "None"
    }
    
  
    
}
