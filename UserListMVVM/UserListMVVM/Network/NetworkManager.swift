//
//  NetworkManager.swift
//  UserListMVVM
//
//  Created by Mert Ziya on 27.01.2025.
//

import Foundation

enum ErrorTypes : Error{
    case urlError
    case responseError
}

class NetworkManager{
    
    static func fetchAllUsers(completion: @escaping (Result<[User],Error>) -> () ){
        guard let url = URL(string: Endpoints.getallUsers) else{
            completion(.failure(ErrorTypes.urlError))
            return
        }
        let request = URLRequest(url: url)
        let session = URLSession.shared
        
        session.dataTask(with: request) { data, _, error in
            if let error = error{
                completion(.failure(error))
            }else if let data = data{
                do{
                    let container = try JSONDecoder().decode([User].self, from: data)
                    completion(.success(container))
                    
                }catch{
                    completion(.failure(error))
                }
            }else{
                completion(.failure(ErrorTypes.responseError))
            }
        }.resume()
    }
    
}
