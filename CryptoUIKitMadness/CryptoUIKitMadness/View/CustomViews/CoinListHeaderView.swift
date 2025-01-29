//
//  CoinListHeaderView.swift
//  CryptoUIKitMadness
//
//  Created by Mert Ziya on 26.01.2025.
//

import Foundation
import UIKit

class CoinListHeaderView : UIView{
    
    // MARK: - Properties:
    
    @IBInspectable var rank : String = ""           {didSet{ rankLabel.text = rank }}
    @IBInspectable var cryptoCurrency : String = "" {didSet{ cryptoCurrencyLabel.text = cryptoCurrency }}
    @IBInspectable var price : String = ""          {didSet{ priceLabel.text = price }}
    @IBInspectable var percentage24h : String = ""  {didSet{ percentage24hLabel.text = percentage24h }}
    
    
    // MARK: - UI Elements:
    var rankLabel = UILabel()
    var cryptoCurrencyLabel = UILabel()
    var priceLabel = UILabel()
    var percentage24hLabel = UILabel()
    
    // MARK: - Lifecycles:
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
}


extension CoinListHeaderView{
    private func setupView(){
        backgroundColor = .clear
        let stackView = UIStackView()
        addSubview(stackView)
        
        
        rankLabel.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        cryptoCurrencyLabel.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        priceLabel.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        percentage24hLabel.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        
        rankLabel.textColor = .label
        cryptoCurrencyLabel.textColor = .label
        priceLabel.textColor = .label
        percentage24hLabel.textColor = .label
        
        stackView.addArrangedSubview(rankLabel)
        stackView.addArrangedSubview(cryptoCurrencyLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(percentage24hLabel)
        
        stackView.alignment = .bottom
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 65
        stackView.backgroundColor = .clear
        

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 4),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -4),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
}
