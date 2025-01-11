//
//  TableViewCell.swift
//  WebKitExample
//
//  Created by Mert Ziya on 11.01.2025.
//

import UIKit

class SearchEngineCell: UITableViewCell {

    @IBOutlet weak var searchEnginePic: UIImageView!
    @IBOutlet weak var engineName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        searchEnginePic.clipsToBounds = true
        searchEnginePic.contentMode = .scaleAspectFit
        searchEnginePic.backgroundColor = .systemBackground
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
