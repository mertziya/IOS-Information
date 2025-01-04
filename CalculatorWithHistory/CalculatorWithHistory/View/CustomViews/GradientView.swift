//
//  GradientView.swift
//  IBInspectibletryingtoinitialize
//
//  Created by Mert Ziya on 17.12.2024.
//

import Foundation
import UIKit

class GradientView : UIView{
    
    // BackGround gradient colors:
    @IBInspectable
    var startColor : UIColor = .clear {
        didSet{
            updateGradientBackground()
        }
    }
    @IBInspectable
    var middleColor: UIColor = .clear {
        didSet {
            updateGradientBackground()
        }
    }
    @IBInspectable
    var endColor: UIColor = .clear {
        didSet {
            updateGradientBackground()
        }
    }
    
    private func updateGradientBackground() {
        // Remove existing gradients if any
        self.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [startColor.cgColor, middleColor.cgColor, endColor.cgColor]
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.layer.cornerRadius
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5) // Left to Right
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)   // Left to Right
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateGradientBackground() // Ensure gradient updates with frame changes
    }
    
    
}
