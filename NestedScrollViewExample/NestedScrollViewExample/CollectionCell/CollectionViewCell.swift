//
//  CollectionViewCell.swift
//  NestedScrollViewExample
//
//  Created by Mert Ziya on 13.01.2025.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var horseImage: UIImageView!
    @IBOutlet weak var horseName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .systemBackground
        horseImage.layer.cornerRadius = 40
        horseImage.layer.borderWidth = 1
        horseImage.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    

}
