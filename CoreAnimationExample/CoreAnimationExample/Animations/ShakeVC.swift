//
//  ShakeVC.swift
//  CoreAnimationExample
//
//  Created by Mert Ziya on 1.01.2025.
//

import UIKit

class ShakeVC: UIViewController {

    
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
extension ShakeVC{
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
extension ShakeVC{
    private func animateSquare(){
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0,10,-10,10,0]
        animation.keyTimes = [0, 0.16, 0.5 , 0.83, 1]
        animation.duration = 0.4
        
        animation.isAdditive = true
        
        square.layer.add(animation, forKey: "shake")
        
    }
}
