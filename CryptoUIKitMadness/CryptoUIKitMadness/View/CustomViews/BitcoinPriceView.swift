//
//  BitcoinPriceView.swift
//  CryptoUIKitMadness
//
//  Created by Mert Ziya on 26.01.2025.
//

import UIKit

class BitcoinPriceView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let gradientBackground = GradientBackground(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height))
        gradientBackground.startColor = .systemIndigo
        gradientBackground.endColor = .systemBackground
        gradientBackground.startPoint = CGPoint(x: 0, y: 0)
        gradientBackground.endPoint = CGPoint(x: 1, y: 1)
        
        insertSubview(gradientBackground, at: 0)
    }
    
   
    
    private func setupView(){
        layer.cornerRadius = 48
        clipsToBounds = true
    }
    
   
    
}
