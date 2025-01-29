//
//  CoinListCellTableViewCell.swift
//  CryptoUIKitMadness
//
//  Created by Mert Ziya on 26.01.2025.
//

import UIKit
import SDWebImage

class CoinListCellTableViewCell: UITableViewCell {

    // MARK: - UI Elements:
    @IBOutlet weak var marketRatingLabel: UILabel!
    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var coinNameLabel: UILabel!
    @IBOutlet weak var coinMarketCapLabel: UILabel!
    @IBOutlet weak var coinPriceLabel: UILabel!
    @IBOutlet weak var arrowUpDown: UIImageView!
    @IBOutlet weak var dailyChangePercent: UILabel!
    
    static var identifier = "CoinListIdentifier"
    static var nibName = "CoinListCellTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
    
    func configureCell(with : Market){
        
        marketRatingLabel.text = String(describing: with.marketCapRank ?? 0)
        
        coinImage.sd_setImage(with:  URL(string : with.image ?? "")) { image, _, _, _ in
            if let resizedImage = image?.sd_resizedImage(with: CGSize(width: 30, height: 30), scaleMode: .aspectFit) {
                self.coinImage.image = resizedImage
                self.coinImage.layer.cornerRadius = 30 / 2
                self.coinImage.clipsToBounds = true
            }
        }
        
        coinNameLabel.text = with.symbol?.uppercased() ?? "ShitCoin"
        
        setMarketCap(marketCap: with.marketCap) { [self] makeupMarketCap in
            coinMarketCapLabel.text = makeupMarketCap
        }
        
        let formattedPrice = formatNumber(with.currentPrice ?? 0)
        coinPriceLabel.text = "$" + formattedPrice
        
        let formatted24hChange = String(format: "%.2f", with.priceChangePercentage24H ?? 0)
        dailyChangePercent.text = formatted24hChange + "%"
        
        if formatted24hChange.first == "-"{
            arrowUpDown.image = UIImage(systemName: "arrowtriangle.down.fill")
            arrowUpDown.tintColor = .systemRed
            dailyChangePercent.textColor = .systemRed
        }else{
            arrowUpDown.image = UIImage(systemName: "arrowtriangle.up.fill")
            arrowUpDown.tintColor = .systemGreen
            dailyChangePercent.textColor = .systemGreen
        }
        
    }
    
    private func setMarketCap(marketCap : Int? , completion : (String) -> ()){
        guard let marketCap = marketCap else{return}
        var resultString = ""
        
        // Trillion
        if marketCap >= 1000000000000{
            resultString = String(format: "%.3f", Double(Double(marketCap) / 1000000000000))
            resultString = resultString + " T"
        }
        
        // Billion
        else if marketCap >= 1000000000{
            resultString = String(format: "%.3f", Double(Double(marketCap) / 1000000000))
            resultString = resultString + " B"
        }
        
        // Million
        else if marketCap >= 1000000{
            resultString = String(format: "%.3f", Double(Double(marketCap) / 1000000))
            resultString = resultString + " M"
        }else{
            resultString = String(marketCap)
        }
        
        if resultString.first == "0" {resultString.removeFirst()}
        if resultString.first == "0" {resultString.removeFirst()}
        
        completion(resultString)
    }
    
    func formatNumber(_ value: Double) -> String {
        // Create a NumberFormatter
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "." // Separator for large numbers
        formatter.decimalSeparator = "," // Separator for decimal part
        
        // Format the number
        if let formattedNumber = formatter.string(from: NSNumber(value: value)) {
            return formattedNumber
        } else {
            return "\(value)" // Fallback to the original value as a string
        }
    }
    
}
