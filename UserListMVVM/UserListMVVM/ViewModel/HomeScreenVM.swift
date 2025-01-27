//
//  HomeScreenVM.swift
//  UserListMVVM
//
//  Created by Mert Ziya on 27.01.2025.
//

import Foundation

protocol HomeScreenDelegate : AnyObject{
    
    func didFailWithError(error: Error)
    func isLoadingWith(isLoading : Bool)
    func didFetchWithSuccess(users: [User])
    
}

class HomeScreenVM{
    
    weak var delegate : HomeScreenDelegate?
    
    func fetchAllUsers(){
        delegate?.isLoadingWith(isLoading: true)
        
        // Stimulating the network call for better seeing loading state.
        // Since the User data is so small it feels like data is being fetched in an instant.
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
            NetworkManager.fetchAllUsers { res in
                switch res{
                case .failure(let error):
                    self.delegate?.didFailWithError(error: error)
                case .success(let users):
                    self.delegate?.didFetchWithSuccess(users: users)
                }
                self.delegate?.isLoadingWith(isLoading: false)
            }
        }
        
    }
    
}
