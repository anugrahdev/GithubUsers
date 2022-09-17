//
//  TabBarViewController.swift
//  GithubUsers
//
//  Created by Anang Nugraha on 16/09/22.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchNC(), createFavoritesNC()]
    }
    
    func createSearchNC() -> UINavigationController {
        let searchVC = SearchWireframe().createModule()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createFavoritesNC() -> UINavigationController {
        let favoritesListVC = FavoritesVC()
        favoritesListVC.title = "Favorites"
        favoritesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoritesListVC)
    }
}
