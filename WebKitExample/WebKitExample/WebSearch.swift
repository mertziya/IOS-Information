//
//  GoogleSearch.swift
//  WebKitExample
//
//  Created by Mert Ziya on 10.01.2025.
//

import Foundation
import UIKit
import WebKit

class WebSearch : UIViewController{
    
    let webView : WKWebView = {
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preferences
        
        var webView = WKWebView(frame: .zero, configuration: configuration)
        return webView
    }()
    
    
    private let url : URL
    private let webTitle : String
    
    init(url: URL , webTitle: String) {
        self.url = url
        self.webTitle = webTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        webView.load(URLRequest(url: self.url))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .done, target: self, action: #selector(endSearching))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.counterclockwise"), style: .done, target: self, action: #selector(reloadData))
        
        navigationItem.title = webTitle
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(popNav))
        swipeGesture.direction = .right
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(swipeGesture)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    @objc private func endSearching(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func reloadData(){
        webView.reload()
    }
    
    @objc private func popNav(){
        navigationController?.popViewController(animated: true)
    }
}
