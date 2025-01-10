//
//  pdfVC.swift
//  pdfViewer
//
//  Created by Mert Ziya on 10.01.2025.
//

import Foundation
import UIKit
import PDFKit

protocol PrivacyDelegate : AnyObject {
    func didAcceptPolicyWith(index: Int)
}

class pdfVC : UIViewController, PDFViewDelegate, UIScrollViewDelegate {
    
    var policyIndex : Int!
    var pdfURL : String!
    
    weak var delegate : PrivacyDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPDF()
    }
    
    let pdfView = PDFView()
    let agreeButton = UIButton()

    private func setupPDF(){
        view.backgroundColor = .systemBackground
        view.addSubview(pdfView)
        view.addSubview(agreeButton)
        
        pdfView.document = PDFDocument(url: URL(string: pdfURL )!)
        pdfView.delegate = self

        pdfView.backgroundColor = .systemBackground
        pdfView.displayMode = .singlePageContinuous
        pdfView.scaleFactor = 0.6
        pdfView.autoScales = true
       
        
        if let scrollView = findScrollView(in: pdfView){
            scrollView.delegate = self
        }
        
        
        
        
        agreeButton.setTitle("Agree Liscence and Agreements", for: .normal)
        agreeButton.setTitleColor(.label, for: .normal)
        agreeButton.backgroundColor = .link
        agreeButton.layer.cornerRadius = 8
        
        agreeButton.alpha = 0.2 ; agreeButton.isUserInteractionEnabled = false // DEFFAULT CONFIG
        
        agreeButton.addTarget(self, action: #selector(agreed), for: .touchUpInside)
        
        
        
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        agreeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            agreeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.bounds.height*0.1),
            agreeButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            agreeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            agreeButton.heightAnchor.constraint(equalToConstant: 52),
            
            pdfView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            pdfView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            pdfView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            pdfView.bottomAnchor.constraint(equalTo: agreeButton.topAnchor, constant: -view.bounds.height*0.05),
        ])
    }
    
    // RECURSIVE FUNCTION FOR CHECKING EACH SUBVIEW & SUBVIEW OF SUBVIEWS OF THE VIEW.
    private func findScrollView(in view: UIView) -> UIScrollView? {
        for subview in view.subviews{
            if let scrollView = subview as? UIScrollView {
                return scrollView
            }
            if let found = findScrollView(in: subview){
                return found
            }
        }
        return nil
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Check if the scrollView is at the bottom
        let contentOffsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.bounds.height
        
        let isScrolledToBottom = contentOffsetY >= contentHeight - scrollViewHeight
       
        if isScrolledToBottom{
            agreeButton.alpha = 1
            agreeButton.isUserInteractionEnabled = true
        }
    }
    
    
}




// MARK: - Actions:
extension pdfVC {
    
    @objc private func agreed(){
        self.delegate!.didAcceptPolicyWith(index: policyIndex)
        self.dismiss(animated: true)
    }
    
}
