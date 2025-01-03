//
//  RotateVC.swift
//  CoreAnimationExample
//
//  Created by Mert Ziya on 1.01.2025.
//

import UIKit

class RotateVC: UIViewController {

    
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
extension RotateVC{
    private func setupUI(){
        view.addSubview(square)
        view.addSubview(animateButton)
        square.frame = CGRect(x: view.bounds.midX - 200/2 , y: view.bounds.midY - 100/2 , width: 200, height: 100)
        animateButton.frame = CGRect(x: view.bounds.midX - 80/2 , y: view.bounds.maxY - 80/2 - 80/2, width: 80, height: 40)
        
        
        square.backgroundColor = .cyan
        
        animateButton.backgroundColor = .link
        animateButton.setTitle("Animate", for: .normal)
        animateButton.tintColor = .label
        animateButton.layer.cornerRadius = 8
        

        
       
    }
    
}


// MARK: - Animations:
extension RotateVC{
    private func animateSquare(){
        let animation = CABasicAnimation()
        animation.keyPath = "transform.rotation.z"
        animation.fromValue = 0
        animation.toValue = CGFloat.pi / 4
        animation.duration = 0.5
        
        animation.fillMode = .forwards // Ensures the animation keeps the final state
        
        square.layer.add(animation, forKey: "basic")
        square.layer.transform = CATransform3DMakeRotation(CGFloat.pi / 4, 0, 0, 1)
        
    }
}
