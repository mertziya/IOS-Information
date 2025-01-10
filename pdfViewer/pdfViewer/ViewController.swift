//
//  ViewController.swift
//  pdfViewer
//
//  Created by Mert Ziya on 10.01.2025.
//

import UIKit


class ViewController: UIViewController{
    
    
    // PROPERTIES:
    var isFirstAccepted : Bool = false {
        didSet{
            checkboxButton1.alpha = 1
            checkboxButton1.isUserInteractionEnabled = false
            checkboxButton1.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        }
    }
    var isSecondAccepted : Bool = false{
        didSet{
            checkboxButton2.alpha = 1
            checkboxButton2.isUserInteractionEnabled = false
            checkboxButton2.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        }
    }
    
    // UI ELEMENTS:
    let evilCorp = UIImageView()
    
    lazy var continueButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Continue", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .link
        btn.layer.cornerRadius = 12
        
        btn.isUserInteractionEnabled = false
        btn.alpha = 0.45
        btn.addTarget(self, action: #selector(showPrivacyAcceptedVC), for: .touchUpInside)
        return btn
    }()
    
   
    lazy var checkboxButton1: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "square"), for: .normal) // Unchecked state
        button.setAttributedTitle(NSAttributedString(string: "I Accept the Terms of use and Privacy Policy", attributes: [
            .font : UIFont.systemFont(ofSize: 12, weight: .light)
        ]), for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.alpha = 0.45
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(showfirstPDF), for: .touchUpInside)
        return button
    }()
    
    lazy var checkboxButton2 : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "square"), for: .normal) // Unchecked state
        button.setAttributedTitle(NSAttributedString(string: "I Accept to share my data with Evil Corp, anonymously to improve the app performance", attributes: [
            .font : UIFont.systemFont(ofSize: 12, weight: .light),
            
        ]), for: .normal)
        button.titleLabel?.numberOfLines = 2
        
        button.setTitleColor(.label, for: .normal)
        button.alpha = 0.45
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(showsecondPDF), for: .touchUpInside)
        return button
    }()
    
    
    // LIFECYCLES:
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupUI()
        
    }
    
}



// MARK: - Setup UI
extension ViewController {
    private func setupUI(){
        view.addSubview(evilCorp)
        
        view.addSubview(checkboxButton1)
        view.addSubview(checkboxButton2)
        
        view.addSubview(continueButton)
        
        
        
        
        
        let imageURL = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse3.mm.bing.net%2Fth%3Fid%3DOIP.p5zAnQOPcYa3NXPGzYrdHwHaEK%26pid%3DApi&f=1&ipt=5ed3812b4531d8b6603c4143a9a054dbc18614d9e0a24a3de353bee945bb87ab&ipo=images"
        ImageService.shared.fetchImage(imageURL: imageURL) { evilImage in
            DispatchQueue.main.async {
                self.evilCorp.image = evilImage
            }
        }
        evilCorp.contentMode = .scaleAspectFill
        evilCorp.clipsToBounds = true
        evilCorp.tintColor = .label
        
        evilCorp.translatesAutoresizingMaskIntoConstraints = false
        checkboxButton1.translatesAutoresizingMaskIntoConstraints = false
        checkboxButton2.translatesAutoresizingMaskIntoConstraints = false
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
     
            evilCorp.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            evilCorp.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            evilCorp.heightAnchor.constraint(equalToConstant: 200),
            evilCorp.widthAnchor.constraint(equalToConstant: 200),
            
            checkboxButton1.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            checkboxButton1.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.bounds.height * -0.3),
            checkboxButton1.heightAnchor.constraint(equalToConstant: 24),
            checkboxButton1.widthAnchor.constraint(equalToConstant: view.bounds.width - 48),

                    
            checkboxButton2.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            checkboxButton2.topAnchor.constraint(equalTo: checkboxButton1.bottomAnchor, constant: 24),
            checkboxButton2.heightAnchor.constraint(equalToConstant: 24),
            checkboxButton2.widthAnchor.constraint(equalToConstant: view.bounds.width - 48),
            
            continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.bounds.height * -0.15),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.heightAnchor.constraint(equalToConstant: 44),
            continueButton.widthAnchor.constraint(equalToConstant: view.bounds.width*0.6),
            
        ])
    }
}



// MARK: - Actions:
extension ViewController : PrivacyDelegate {
    func didAcceptPolicyWith(index: Int) {
        if index == 1{
            isFirstAccepted = true
        }else if index == 2{
            isSecondAccepted = true
        }
        if isFirstAccepted && isSecondAccepted {
            continueButton.alpha = 1
            continueButton.isUserInteractionEnabled = true
        }
    }
    
    @objc private func showfirstPDF(_ button : UIButton){
        let vc = pdfVC()
        vc.pdfURL =  "https://www.termsfeed.com/public/uploads/2021/12/sample-privacy-policy-template.pdf"
        vc.policyIndex = 1
        vc.delegate = self
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true)
    }
    @objc private func showsecondPDF(_ button : UIButton){
        let vc = pdfVC()
        vc.pdfURL =  "https://eworldfulfillment.com/wp-content/uploads/2021/01/Privacy-Policy-Example-Template.pdf"
        vc.policyIndex = 2
        vc.delegate = self
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true)
    }
    
    @objc private func showPrivacyAcceptedVC(){
        let vc = PrivacyAcceptedVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}




