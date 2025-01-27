//
//  Alerts.swift
//  UserListMVVM
//
//  Created by Mert Ziya on 27.01.2025.
//

import Foundation
import UIKit

class Alerts{
    
    static func showAler(at: UIViewController , title: String , message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        
        at.present(alert, animated: true)
    }
    
}
