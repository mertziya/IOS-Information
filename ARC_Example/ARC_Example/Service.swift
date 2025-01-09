//
//  Service.swift
//  ARC_Example
//
//  Created by Mert Ziya on 9.01.2025.
//

import Foundation

class DataFetcher{
    
    var identifier : String?

    func strongFetchData() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            // This closure captures `self` strongly, creating a retain cycle

            if let error = error {
                print("Error: \(error)")
                return
            }
            if let data = data {
                print("Data received: \(data)")
            }
        }.resume()
    }
    
    func weakFetchData() {
       let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1")!
       
       URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
           if let error = error {
               print("Error: \(error)")
               return
           }
           if let data = data {
               print("Data received: \(data)")
           }
       }.resume()
   }
    

    deinit {
        print("Data Fetcher \(identifier ?? "no_id") is cleaned")
    }
    
        
}
