//
//  GradientBackground.swift
//  CryptoUIKitMadness
//
//  Created by Mert Ziya on 26.01.2025.
//

import Foundation
import UIKit

import UIKit

class GradientBackground: UIView {
    
    private let gradientLayer = CAGradientLayer()
    
    // Configurable properties
    @IBInspectable public var startColor: UIColor = UIColor.systemBlue { didSet {updateGradientColors()} }
    
    @IBInspectable public var endColor: UIColor = UIColor.systemTeal { didSet {updateGradientColors()} }
    
    @IBInspectable public var startPoint: CGPoint = CGPoint(x: 0, y: 0) { didSet { gradientLayer.startPoint = startPoint } }
    
    @IBInspectable public var endPoint: CGPoint = CGPoint(x: 1, y: 1) { didSet { gradientLayer.endPoint = endPoint } }
    
    
    
    // View Lifecylce:
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }
    
    private func setupGradient() {
        updateGradientColors()
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func updateGradientColors() {
        gradientLayer.colors = [startColor.cgColor , endColor.cgColor]
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds // Update the frame when the view's bounds change
    }
}
