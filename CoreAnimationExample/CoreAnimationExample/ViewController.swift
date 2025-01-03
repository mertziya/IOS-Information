//
//  ViewController.swift
//  CoreAnimationExample
//
//  Created by Mert Ziya on 1.01.2025.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView = UITableView()
    
    var animationTypes : [String] = ["Move" ,"Scale" , "Rotate", "Shake", "Circling"]
    var vcs : [UIViewController] = [MoveVC(), ScaleVC(), RotateVC(), ShakeVC(), CirclingVC()]
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animationTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = animationTypes[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(vcs[indexPath.row], animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

}




// MARK: - UI configurations:
extension ViewController {
    
    private func setupUI(){
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.title = "Animations"

        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
        ])
    }
}
