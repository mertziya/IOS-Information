//
//  ViewController.swift
//  NestedScrollViewExample
//
//  Created by Mert Ziya on 13.01.2025.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let horses = [
        Horse(name: "Horse 1", _image: UIImage.horse1),
        Horse(name: "Horse 2", _image: UIImage.horse2),
        Horse(name: "Horse 3", _image: UIImage.horse3),
        Horse(name: "Horse 4", _image: UIImage.horse4),
        Horse(name: "Horse 5", _image: UIImage.horse5),
    ]
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }
    
    private func setupTable(){
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        tableView.showsVerticalScrollIndicator = false
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return horses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else{
            print("DEQUEUE ERROR")
            return UITableViewCell()
        }
        
        cell.horses = horses
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

}


struct Horse {
    var name : String
    var _image : UIImage
    
    init(name: String, _image: UIImage) {
        self.name = name
        self._image = _image
    }
}
