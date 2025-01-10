//
//  ImagesERVİCE.swift
//  pdfViewer
//
//  Created by Mert Ziya on 10.01.2025.
//

import Foundation
import UIKit

class ImageService{
    
    static let shared = ImageService()
    
    func fetchImage(imageURL : String , completion : @escaping (UIImage?) -> () ){
        guard let url = URL(string: imageURL) else{
            print("Image Error")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared

        session.dataTask(with: request) { [weak self] data, response, error in
            guard self != nil else{return}
            
            if let _ = error{
                print("ERROR IMAGE")
                completion(nil)
            }
            else if let data = data {
                print("Success")
                let targetImage = UIImage(data: data)
                completion(targetImage)
                
            }
        }.resume()
        
    }
    
}
