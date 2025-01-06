//
//  ViewController.swift
//  exampleService
//
//  Created by Mert Ziya on 6.01.2025.
//

import UIKit

class ViewController: UIViewController {
    
    let tableView = UITableView()
    
    // INFINITE SCROLL:
    var isScrolled = false
    
    var photos : [Model] = [] {
        didSet{
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupTableViewFooter()
        
        fetchMorePhotos(amount: 20)
    }


}




extension ViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell") as? photoCell else{print("DEBUG: Cell Error");return UITableViewCell()}
        cell.titleLabel.text = photos[indexPath.row].title
        Service.shared.fetchImage(from: photos[indexPath.row].thumbnailURL) { image in
            if let image = image {
                DispatchQueue.main.async {
                    cell.iv.image = image
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
   
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        let bottomOfTable = contentHeight - frameHeight

        // Identicates that user scrolled to the bottom of the table view and beyond.
        if offsetY > bottomOfTable + 100 && !isScrolled{
            isScrolled = true
            print("Bottom Reached")
            fetchMorePhotos(amount: 5)
            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                self.isScrolled = false
            }
        }
        
    }
    
    
    
    private func setupTableView(){
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "photoCell", bundle: nil), forCellReuseIdentifier: "photoCell")
        
        tableView.showsVerticalScrollIndicator = false
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
        ])
        
    }
    func setupTableViewFooter() {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.hidesWhenStopped = true
        spinner.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 44)
        tableView.tableFooterView = spinner
    }
    
    private func fetchMorePhotos(amount: Int){
        
        Service.shared.getMorePhotos(amount: amount) { result in
            switch result{
            case .failure(let error):
                print("DEBUG: \(error.localizedDescription)")
            case .success(let morePhotos):
                DispatchQueue.main.async{
                    self.photos.append(contentsOf: morePhotos)
                }
            }
        }
    }
    
}
