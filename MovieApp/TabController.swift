//
//  TabController.swift
//  MovieApp
//
//  Created by 김이든 on 7/17/25.
//

import UIKit

class TabController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    private func setupTabs() {
        let home = createNav(with: "Home", and: UIImage(systemName: "house"), vc: MoviesViewController())
//        let search = createNav(with: "Search", and: UIImage(systemName: "magnifyingglass"), vc: TestViewController2())
        let profile = createNav(with: "Profile", and: UIImage(systemName: "person"), vc: ProfileViewController())
        
        setViewControllers([home, profile], animated: true)
    }
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        nav.viewControllers.first?.navigationItem.title = title
            
        return nav
    }
}
