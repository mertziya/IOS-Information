//
//  User.swift
//  ViewModelWithProtocols
//
//  Created by Mert Ziya on 27.12.2024.
//

import Foundation

struct User : Codable , Identifiable{
    var id: String?
    
    var email: String?
    var fullname : String?
    var username : String?
    var password: String?
    var imageURL : String?
    
    init(id: String? = nil, email: String?, fullname: String?, username: String?, password: String?, imageURL: String?) {
        self.id = id
        self.email = email
        self.fullname = fullname
        self.username = username
        self.password = password
        self.imageURL = imageURL
    }
    init(){}
}
