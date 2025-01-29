//
//  HomeScreenVM.swift
//  CryptoUIKitMadness
//
//  Created by Mert Ziya on 26.01.2025.
//

import Foundation

protocol HomeScreenDelegate : AnyObject{
    
    func isLoadingMarket(isLoading : Bool)
    func didFetchMarketWithError(error: Error)
    func didFetchMarketWithSuccess(market : [Market])
    
}

class HomeScreenVM{
    
    weak var delegate : HomeScreenDelegate?
    
    
    func fetchMarketCap(page: Int){
        delegate?.isLoadingMarket(isLoading: true)
        NetworkManager.fetchMarket(pageNumber: page) { result in
            switch result{
            case .failure(let error):
                self.delegate?.didFetchMarketWithError(error: error)
            case .success(let market):
                self.delegate?.didFetchMarketWithSuccess(market: market)
            }
            self.delegate?.isLoadingMarket(isLoading: false)
        }
    }
    
    
    
}
