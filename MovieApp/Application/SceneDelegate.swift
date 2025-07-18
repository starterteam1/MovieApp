//
//  SceneDelegate.swift
//  MovieApp
//
//  Created by 김이든 on 7/15/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        setupGlobalTabBarAppearance()
//        setupGlobalNavigationBarAppearance()

        window = UIWindow(windowScene: windowScene)
        let navController = UINavigationController(rootViewController: LoginViewController())
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    private func setupGlobalTabBarAppearance() {
        // 탭바 타이틀 색상 설정 (전역 적용)
        UITabBarItem.appearance().setTitleTextAttributes(
            [.foregroundColor: Colors.tabBarUnselected],
            for: .normal
        )
        UITabBarItem.appearance().setTitleTextAttributes(
            [.foregroundColor: UIColor.white],
            for: .selected
        )

        // 아이콘 색상
        UITabBar.appearance().tintColor = .white
        UITabBar.appearance().unselectedItemTintColor = Colors.tabBarUnselected

        // 배경색 (UITabBarAppearance)
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = Colors.tabBarBackground

        // 선택 / 비선택 아이템에 대해 필요하면 추가 설정 가능
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = .white
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = Colors.tabBarUnselected

        UITabBar.appearance().standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }
    
//    private func setupGlobalNavigationBarAppearance() {
//        let navBarAppearance = UINavigationBarAppearance()
//        navBarAppearance.configureWithOpaqueBackground()
//        navBarAppearance.backgroundColor = Colors.tabBarBackground // 네비게이션 바 배경
//        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white] // 기본 타이틀 색상
//        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white] // Large Title 색상
//
//        // 글로벌 설정
//        UINavigationBar.appearance().standardAppearance = navBarAppearance
//        UINavigationBar.appearance().compactAppearance = navBarAppearance
//        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
//
//        UINavigationBar.appearance().tintColor = .white // Back 버튼 & BarButtonItem 색상
//    }
}

