//
//  photoCell.swift
//  exampleService
//
//  Created by Mert Ziya on 6.01.2025.
//

import UIKit

class photoCell: UITableViewCell {

    @IBOutlet weak var iv: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        iv.layer.cornerRadius = 8
        iv.image = UIImage(systemName: "exclamationmark")
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        
        titleLabel.text = "default"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
