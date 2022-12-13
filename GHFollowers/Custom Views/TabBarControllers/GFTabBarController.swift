//
//  GFTabBarController.swift
//  GHFollowers
//
//  Created by Eugene Yehanovskiy on 26.11.2022.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
                
        if #available(iOS 15.0, *) {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
        
        UITabBar.appearance().tintColor = .systemGreen
        
        viewControllers = [
            createSearchNavigationViewController(),
            createFavoritesNavigationViewController()
        ]
    }

    func createSearchNavigationViewController() -> UINavigationController {
        let searchVC = SearchViewController()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        
        let searchNavController = UINavigationController(rootViewController: searchVC)
        
        return searchNavController
    }
    
    func createFavoritesNavigationViewController() -> UINavigationController {
        let favoritesVC = FavoritesViewController()
        favoritesVC.title = "Favorites"
        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        let favoritesNavVC = UINavigationController(rootViewController: favoritesVC)
        
        return favoritesNavVC
    }
}
