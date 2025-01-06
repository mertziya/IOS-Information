//
//  Service.swift
//  exampleService
//
//  Created by Mert Ziya on 6.01.2025.
//

import Foundation
import UIKit

enum ErrorCase: Error{
    case urlError
    case unknownError
}

class Service{
    
    static let shared = Service()
    init(){}
    
    var fetchedAmount = 0
    
    func getMorePhotos(amount: Int , completion : @escaping (Result<[Model],Error>) -> () ){
        let session = URLSession.shared
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else{completion(.failure(ErrorCase.urlError)) ; return}
        session.dataTask(with: url) { data, response, error in
            if let error = error{
                completion(.failure(error))
            }else if let data = data{
                do{
                    let decoder = JSONDecoder()
                    let modeledData = try decoder.decode([Model].self, from: data)
                    
                    
                    let initial = self.fetchedAmount // the last position that we were currently on.
                    var twentyMore : [Model] = [] // new array of Model to be inserted.
                    for row in modeledData[initial...initial+amount]{
                        twentyMore.append(row)
                    }
                    self.fetchedAmount += amount+1 // updating the final position
                    
                    completion(.success(twentyMore)) // return the 20 more data

                }catch{
                    completion(.failure(error))
                }
            }else{
                completion(.failure(ErrorCase.unknownError))
            }
        }
        .resume() // DON'T FORGET TO START THE GAS PEDAL //
    }
    
    func fetchImage(from urlString : String, completion : @escaping (UIImage?) -> ()){
        guard let url = URL(string: urlString) else{
            print("DEBUG: invalid URL")
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error{
                print(error.localizedDescription)
                completion(nil)
                return
            }
            guard let data = data, let image = UIImage(data: data) else{
                print("Failed to convert data to image")
                completion(nil)
                return
            }
            
            completion(image)
            
        }.resume()
    }
}
