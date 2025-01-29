//
//  HomeScreenVC.swift
//  CryptoUIKitMadness
//
//  Created by Mert Ziya on 26.01.2025.
//

import UIKit

class HomeScreenVC: UIViewController{
    

    // MARK: - Properties:
    var homeScreenVM = HomeScreenVM()
    var isLoading = false
    var fetchingError : Error?
    
    // The type of data that is being showed on the tableview can change:
    var currentMarket : [Market] = [] {didSet{ DispatchQueue.main.async { self.coinList.reloadData() }}}
    
    // Change the type of data that is being showed on the table and update accordingly:
    var dataSource : TableViewDataSource = .market {didSet{ DispatchQueue.main.async { self.coinList.reloadData() } }}

    
    // MARK: - UI Elements:
    @IBOutlet weak var coinlistHeader: CoinListHeaderView!
    @IBOutlet weak var coinList: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        homeScreenVM.delegate = self
        homeScreenVM.fetchMarketCap(page: 1)
    }
}

enum TableViewDataSource{
    case market
}

extension HomeScreenVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch dataSource{
        case .market:
            return currentMarket.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource{
        case .market:
            guard let cell = coinList.dequeueReusableCell(withIdentifier: CoinListCellTableViewCell.identifier, for: indexPath) as? CoinListCellTableViewCell else{
                print("DEQUEUE ERROR")
                return UITableViewCell()
            }
            cell.configureCell(with: currentMarket[indexPath.row])
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    
    private func setupView(){
        coinList.delegate = self
        coinList.dataSource = self
        coinList.register(UINib(nibName: CoinListCellTableViewCell.nibName , bundle: nil), forCellReuseIdentifier: CoinListCellTableViewCell.identifier)
        
     
    }
    
}


// MARK: - Handling the network calls:
extension HomeScreenVC: HomeScreenDelegate {
    func isLoadingMarket(isLoading: Bool) {
        self.isLoading = isLoading
    }
    
    func didFetchMarketWithError(error: any Error) {
        self.fetchingError = error
    }
    
    func didFetchMarketWithSuccess(market: [Market]) {
        self.currentMarket = market
    }
    
}
