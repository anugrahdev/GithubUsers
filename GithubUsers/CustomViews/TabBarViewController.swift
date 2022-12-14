//
//  TabBarViewController.swift
//  GithubUsers
//
//  Created by Anang Nugraha on 16/09/22.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {

    let router = Module.container.resolve(Router.self)

    override func viewDidLoad() {
        super.viewDidLoad()

        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchNC(), createFavoritesNC()]
        NotificationCenter.default.addObserver(self, selector: #selector(showNoInternetAlert), name: .getNotification(with: .offline), object: nil)

    }
    
    @objc private func showNoInternetAlert() {
        showNoInternetConnectionAlert()
    }
    
    func createSearchNC() -> UINavigationController {
        let searchVC = router.setupSearchViewController()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createFavoritesNC() -> UINavigationController {
        let favoritesListVC = router.setupFavoritesViewController()
        favoritesListVC.title = "Favorites"
        favoritesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoritesListVC)
    }
}
