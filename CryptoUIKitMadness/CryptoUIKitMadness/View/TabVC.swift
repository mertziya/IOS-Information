//
//  TabVC.swift
//  CryptoUIKitMadness
//
//  Created by Mert Ziya on 26.01.2025.
//

import Foundation
import UIKit

class TabVC : UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    
    private func setupTabs(){
        
        // Tabbar items:
        let homeNav = UINavigationController(rootViewController: HomeScreenVC())
        homeNav.tabBarItem = UITabBarItem(title: "List", image: UIImage(systemName: "list.bullet"), tag: 0)
        homeNav.tabBarItem.selectedImage = UIImage(systemName: "list.number")
        homeNav.navigationBar.isHidden = true
        
        let trackNav = UINavigationController(rootViewController: TrackListVC())
        trackNav.tabBarItem = UITabBarItem(title: "Track", image: UIImage(systemName: "eye"), tag: 1)
        trackNav.tabBarItem.selectedImage = UIImage(systemName: "eye.fill")
        trackNav.navigationBar.isHidden = true
        
        
        
        // TABBAR ITEM COLORS:
        self.viewControllers = [homeNav , trackNav]
        self.tabBar.tintColor = .systemPurple
        
        // TABBAR BACKGROUND COLORS:
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .systemBackground.withAlphaComponent(0.8)
        
        tabBar.scrollEdgeAppearance = appearance
        tabBar.standardAppearance = appearance
    }
    
}

