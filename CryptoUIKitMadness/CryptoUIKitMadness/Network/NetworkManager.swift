//
//  NetworkManager.swift
//  CryptoUIKitMadness
//
//  Created by Mert Ziya on 25.01.2025.
//

import Foundation

class NetworkManager{
    
    
    static func fetchMarket(pageNumber : Int , completion: @escaping (Result<[Market],Error>) -> () ){
        guard let url = URL(string: "\(Endpoints.get20FromMarket)&page=\(pageNumber)") else{
            completion(.failure(Errors.urlError))
            return
        }
        let request = URLRequest(url: url)
        let session = URLSession.shared
        session.dataTask(with: request) { data, _, error in
            if let error = error{
                completion(.failure(error))
            }else if let data = data{
                do{
                    let container = try JSONDecoder().decode([Market].self, from: data)
                    completion(.success(container))
                }catch{
                    completion(.failure(error))
                }
            }else{
                completion(.failure(Errors.responseError))
            }
        }.resume()
    }
    
    
    static func fetchCoinsWithParam(query : String , completion : @escaping (Result<SearchCoins,Error>) -> () ){
    
        guard let url = URL(string: "https://api.coingecko.com/api/v3/search?query=trump") else{
            completion(.failure(Errors.urlError))
            return
        }
       
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error{
                completion(.failure(error))
            }else if let data = data{
                do{
                    let searchedCoins = try JSONDecoder().decode(SearchCoins.self, from: data)
                    completion(.success(searchedCoins))
                }catch{
                    completion(.failure(error))
                }
            }else{
                completion(.failure(Errors.responseError))
            }
        }.resume()
        
    }
    
        
}
