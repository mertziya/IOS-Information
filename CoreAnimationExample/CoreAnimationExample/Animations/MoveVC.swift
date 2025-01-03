//
//  MoveVC.swift
//  CoreAnimationExample
//
//  Created by Mert Ziya on 1.01.2025.
//

import Foundation
import UIKit

class MoveVC : UIViewController {
    
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
extension MoveVC{
    private func setupUI(){
        view.addSubview(square)
        view.addSubview(animateButton)
        
        
        square.backgroundColor = .cyan
        
        animateButton.backgroundColor = .link
        animateButton.setTitle("Animate", for: .normal)
        animateButton.tintColor = .label
        animateButton.layer.cornerRadius = 8
        
        square.frame = CGRect(x: view.bounds.midX - 100/2 , y: view.bounds.midY - 100/2 , width: 100, height: 100)
        
        
        
        //square.translatesAutoresizingMaskIntoConstraints = false
        
        animateButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            animateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animateButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            animateButton.heightAnchor.constraint(equalToConstant: 40),
            animateButton.widthAnchor.constraint(equalToConstant: 92),
        ])
    }
    
}


// MARK: - Animations:
extension MoveVC{
    private func animateSquare(){
        let animation = CABasicAnimation()
        animation.keyPath = "position.x"
        animation.fromValue = 0 - square.bounds.width
        animation.toValue = view.bounds.width + square.bounds.width
        animation.duration = 1
        
        square.layer.add(animation, forKey: "basic")
        // square.layer.position = CGPoint(x: 300, y: 175) // For updating the position that view is going to end up after the animation.
    }
}
