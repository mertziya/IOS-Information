//
//  UserViewModel.swift
//  ViewModelWithProtocols
//
//  Created by Mert Ziya on 27.12.2024.
//

import Foundation

// The reasoning for inheriting the AnyObject here is, saying that this protocol can only
// be adopted by classes. So this protocol can only be adopted by classes.
// The reason for that is Only classes can have 'weak var' and we want our delegate to be weak
// So Using AnyObject for that reasons simply improves the performance of the applicaton.

protocol UserViewModelDelegate : AnyObject{
    func didFetchUser(_ user : User)
    func didFailWithError(_ error: Error)
}

class UserViewModel{
    
    weak var delegate: UserViewModelDelegate?
        
    func loadUser(withId id : String) {
        UserService.FetchUser(withid: id) { [weak self] result in
            switch result {
            case .success(let user):
                self?.delegate?.didFetchUser(user)
            case .failure(let error):
                self?.delegate?.didFailWithError(error)
            }
        }
    }
    
    func updateUser(userId : String , user : User){
        UserService.updateUser(userId: userId , userToUpdate: user) { result in
            switch result{
            case .failure(let error):
                self.delegate?.didFailWithError(error)
            case .success(_):
                print("DEBUG: updated the user")
            }
        }
    }
    
}
