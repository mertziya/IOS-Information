// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let searchCoins = try? JSONDecoder().decode(SearchCoins.self, from: jsonData)

import Foundation

// MARK: - SearchCoins
struct SearchCoins: Codable {
    var coins: [SearchCoin]?
    var exchanges, icos, categories: [String]?
    var nfts: [SearchNft]?
}

// MARK: - Coin
struct SearchCoin: Codable {
    var id, name, apiSymbol, symbol: String?
    var marketCapRank: Int?
    var thumb, large: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case apiSymbol
        case symbol
        case marketCapRank
        case thumb, large
    }
}

// MARK: - Nft
struct SearchNft: Codable {
    var id, name, symbol: String?
    var thumb: String?
}
