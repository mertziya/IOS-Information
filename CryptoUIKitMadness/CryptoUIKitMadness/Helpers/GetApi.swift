//
//  GetApi.swift
//  CryptoUIKitMadness
//
//  Created by Mert Ziya on 25.01.2025.
//

import Foundation

class GetApi{
    
    static let apiKey :String = {
        if let path = Bundle.main.path(forResource: "PrivacyInfo", ofType: "xcprivacy"),
           let keys = NSDictionary(contentsOfFile: path),
           let apiKey = keys["APIKEY"] as? String{
            return apiKey
        }
        return "ERROR API"
    }()
}
