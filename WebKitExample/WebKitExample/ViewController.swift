//
//  ViewController.swift
//  WebKitExample
//
//  Created by Mert Ziya on 10.01.2025.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    let tableView = UITableView()

    var titles = [
        "Google",
        "Bing",
        "Yahoo",
        "DuckDuckGo",
        "Ecosia",
        "Yandex",
        "Baidu",
        "Ask",
        "Startpage",
        "Qwant",
        "AOL Search",
        "Sogou",
        "WolframAlpha",
        "Seznam"
        
    ]
    var urls = [
        "https://www.google.com",
        "https://www.bing.com",
        "https://www.yahoo.com",
        "https://duckduckgo.com",
        "https://www.ecosia.org",
        "https://yandex.com",
        "https://www.baidu.com",
        "https://www.ask.com",
        "https://www.startpage.com",
        "https://www.qwant.com",
        "https://search.aol.com",
        "https://www.sogou.com",
        "https://www.wolframalpha.com",
        "https://www.seznam.cz",
    ]
    var images = [
        "https://www.google.com/favicon.ico",
        "https://www.bing.com/sa/simg/favicon-2x.ico",
        "https://s.yimg.com/rz/l/favicon.ico",
        "https://duckduckgo.com/favicon.ico",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSh1RY401lP8EKQnVoun1fHna5acaqZZP6q9Q&s",
        "https://yastatic.net/s3/home-static/_/nova/2ec936c8.png",
        "https://www.baidu.com/favicon.ico",
        "https://www.ask.com/favicon.ico",
        "https://www.startpage.com/favicon.ico",
        "https://www.qwant.com/favicon.ico",
        "https://search.aol.com/favicon.ico",
        "https://www.sogou.com/favicon.ico",
        "https://img.icons8.com/?size=512&id=13667&format=png",
        "https://www.seznam.cz/favicon.ico"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationItem.title = "SEARCH ENGINES"
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "SearchEngineCell")
        
    }
}



// MARK: - UI Configurations:
extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchEngineCell") as? SearchEngineCell else{
            print("SOME ERROR")
            return UITableViewCell()
        }
        
        cell.engineName.text = titles[indexPath.row]
        fetchImage(url: images[indexPath.row]) { engineImage in
            DispatchQueue.main.async {
                cell.searchEnginePic.image = engineImage
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = titles[indexPath.row]
        let url = urls[indexPath.row]
        openSearchEngine(title: title, urlStr: url)
    }
    
    
}



// MARK: - Actions:
extension ViewController{
    
    
    @objc private func openSearchEngine(title: String , urlStr: String){
        guard let url = URL(string: urlStr) else{
            print("search engine name error")
            return
        }
        let engineVC = WebSearch(url: url, webTitle: title)
    
        navigationController?.pushViewController(engineVC, animated: true)
    }
    
}


extension ViewController{
    
    private func fetchImage(url : String, completion : @escaping (UIImage?) -> () ){
        guard let url = URL(string: url) else{
            print("URL Error")
            completion(nil)
            return
        }
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            }else if let data = data {
                let theImage = UIImage(data: data)
                completion(theImage)
            }
        }.resume()
    }
    
}
