//
//  ScreenViewBuilder.swift
//  FoodDeliveryApp
//
//  Created by Admin on 14.10.2022.
//

import UIKit

protocol Builder {
    static func createTabBar() -> UITabBarController
    static func createMainView() -> UIViewController
}

class ScreenViewBuilder: Builder {
    static func createTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        tabBar.viewControllers = [createMainView()]
        return tabBar
    }
    
    static func createMainView() -> UIViewController {
        let view = MainViewController()
        let networkService = NetworkService()
        let presenter = MainViewPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        let navBar = UINavigationController(rootViewController: view)
        navBar.isNavigationBarHidden = true
        navBar.tabBarItem.title = "Main"
        navBar.tabBarItem.image = UIImage(systemName: "cart")
        return navBar
    }
    
}

extension UIView {
    @discardableResult func prepareForAutoLayout() -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}
