//
//  ScaleVC.swift
//  CoreAnimationExample
//
//  Created by Mert Ziya on 1.01.2025.
//

import Foundation
import UIKit

class ScaleVC: UIViewController {
    
    let square = UIView()
    let animateButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        
        animateButton.addTarget(self, action: #selector(animateStart), for: .touchUpInside)
    }
    
    @objc private func animateStart(){
        animateSquare()
    }
}



// MARK: - UI Configurations:
extension ScaleVC{
    private func setupUI(){
        view.addSubview(square)
        view.addSubview(animateButton)
        square.frame = CGRect(x: view.bounds.midX - 100/2 , y: view.bounds.midY - 100/2 , width: 100, height: 100)
        animateButton.frame = CGRect(x: view.bounds.midX - 80/2 , y: view.bounds.maxY - 80/2 - 80/2, width: 80, height: 40)
        
        
        square.backgroundColor = .cyan
        square.layer.cornerRadius = square.bounds.width / 2
        
        animateButton.backgroundColor = .link
        animateButton.setTitle("Animate", for: .normal)
        animateButton.tintColor = .label
        animateButton.layer.cornerRadius = 8
        

        
       
    }
    
}


// MARK: - Animations:
extension ScaleVC{
    private func animateSquare(){
        let animation = CABasicAnimation()
        animation.keyPath = "transform.scale"
        animation.fromValue = 1
        animation.toValue = 2
        animation.duration = 0.4
        animation.repeatCount = 5
        
        square.layer.add(animation, forKey: "basic")
        square.layer.transform = CATransform3DMakeScale(2, 2, 2)
    }
}
