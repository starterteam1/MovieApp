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
        let homeVC = MoviesViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        let profileVC = ProfileViewController()
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 1)
        
        setViewControllers([homeVC, profileVC], animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // 탭바를 화면 상단으로 이동
        var frame = tabBar.frame
        frame.origin.y = 0 // 상단 고정
        tabBar.frame = frame
        
        // 콘텐츠가 가려지지 않도록 inset 조정
        additionalSafeAreaInsets.top = tabBar.frame.height
    }
}
