//
//  privacyAcceptedVC.swift
//  pdfViewer
//
//  Created by Mert Ziya on 10.01.2025.
//

import Foundation
import UIKit

class PrivacyAcceptedVC : UIViewController{
    
    let label = UILabel()
    
    // Lifecycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupUI()
    }
    
    private func setupUI(){
        view.addSubview(label)
        
        label.text = "YOU ACCEPTED ALL YOUR DATA TO BE MANIPULATED BY THE EVIL CORP INC."
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.numberOfLines = 8
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.8)
        ])
    }
}
