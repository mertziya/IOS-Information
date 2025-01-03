//
//  ViewController.swift
//  DragAndDrop
//
//  Created by Mert Ziya on 3.01.2025.
//

import UIKit

class ViewController: UIViewController {
    
    
    var _width: CGFloat!
    var _height: CGFloat!
    
    
    // containts the views that will divide the screen in 8 in the code.
    var views : [UIView] = [UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView(),UIView()]
    
    var draggingView = UIView()
    var centerOfDraggingView = UIView()
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _width = (view.bounds.width-12)/2
        _height = view.bounds.height/6
        
        setupDividedViews()
        
        setupUI()
        addPanGesture()
    }
    
  
}





// MARK: - UI Configuarations:
extension ViewController{
    private func setupDividedViews(){
        view.backgroundColor = .systemBackground
        for v in 0...views.count-1{
            view.addSubview(views[v])
            views[v].backgroundColor = .clear
            
            views[v].layer.cornerRadius = 8
            views[v].layer.borderWidth = 1
            views[v].layer.borderColor = UIColor.label.cgColor
                    
            // Setting our constraints by using CoreGraphics instead of autolayout. Since CoreGraphics value will be needed while animating the pan gesture.
            if v == 0{
                views[0].frame = CGRect(x: view.bounds.minX+4, y: view.bounds.minY+100, width: _width, height: _height)
            }else if v==1{
                views[1].frame = CGRect(x: view.bounds.midX+4, y: view.bounds.minY+100, width: _width, height: _height)
            }else if v % 2 == 0{
                views[v].frame = CGRect(x: view.bounds.minX+4, y: views[v-2].frame.maxY+4, width: _width, height: _height)
            }else if v % 2 == 1{
                views[v].frame = CGRect(x: views[v-1].frame.maxX+4, y: views[v-2].frame.maxY+4, width: _width, height: _height)
            }
        }
    }
    
    private func setupUI(){
        view.addSubview(draggingView)
        draggingView.addSubview(centerOfDraggingView)
        
        draggingView.backgroundColor = .blue
        draggingView.layer.cornerRadius = 8
        draggingView.alpha = 0.7
        
        centerOfDraggingView.backgroundColor = .red // For showing that dragged view goes to the view according to the center position.
        centerOfDraggingView.layer.cornerRadius = 4/2
        
        draggingView.translatesAutoresizingMaskIntoConstraints = false
        centerOfDraggingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            draggingView.heightAnchor.constraint(equalToConstant: _height),
            draggingView.widthAnchor.constraint(equalToConstant: _width ),
            draggingView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 4),
            draggingView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            centerOfDraggingView.heightAnchor.constraint(equalToConstant: 4),
            centerOfDraggingView.widthAnchor.constraint(equalToConstant: 4),
            centerOfDraggingView.centerXAnchor.constraint(equalTo: draggingView.centerXAnchor),
            centerOfDraggingView.centerYAnchor.constraint(equalTo: draggingView.centerYAnchor),
        ])
        
        navigationItem.title = "Drag and Drop"
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func addPanGesture(){
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(dragView(_:)))
        draggingView.isUserInteractionEnabled = true
        draggingView.addGestureRecognizer(panGesture)
    }
    
    @objc private func dragView(_ sender: UIPanGestureRecognizer){
        let field = sender.view
        let translation = sender.translation(in: view)
        
        switch sender.state{
        case .began , .changed: // Identifies that the user is currently holding the view.
            field?.center = CGPoint(x: (field?.center.x)! + translation.x, y: (field?.center.y)! + translation.y)
            sender.setTranslation(CGPoint.zero, in: view)
        case .ended: // Identifies that user stops holding the view.
            for selectedView in views{
                
                // Center is assigned to CGRect for using the .intersects function since it can only be used with CGRect values.
                // Also drag and drop is aimed relative to the center of the dragged view. That's why center variable is crucial here.
                let center = CGRect(origin: field!.center, size: CGSize(width: 2, height: 2))
                if center.intersects(selectedView.frame) == true{
                    
                    animateDraggingFrame(from: field!, to: selectedView) // Sets the old frame to the new frame with a neat animation.
                }
            }
            
        default:
            break
        }
        
    }
}




// MARK: - Animations:
extension ViewController{
    private func animateDraggingFrame(from: UIView, to: UIView) {
        // Ensure the `to` view's layout is up to date
        to.superview?.layoutIfNeeded()
        
        // Get the final frame of the `to` view
        let finalFrame = to.frame
        
        // Create a basic animation for the position and bounds
        let positionAnimation = CABasicAnimation(keyPath: "position")
        positionAnimation.fromValue = from.layer.position
        positionAnimation.toValue = CGPoint(x: finalFrame.midX, y: finalFrame.midY)

        let boundsAnimation = CABasicAnimation(keyPath: "bounds")
        boundsAnimation.fromValue = from.layer.bounds
        boundsAnimation.toValue = CGRect(origin: .zero, size: finalFrame.size)
        
        // Create an animation group to combine animations
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [positionAnimation, boundsAnimation]
        animationGroup.duration = 0.18
        animationGroup.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        // Update the layer's properties to the final state
        from.layer.position = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
        from.layer.bounds = CGRect(origin: .zero, size: finalFrame.size)
        
        // Add the animation group to the `from` view's layer
        from.layer.add(animationGroup, forKey: "frameChange")
    }
}

