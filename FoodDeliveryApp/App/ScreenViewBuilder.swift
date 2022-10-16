//
//  ScreenViewBuilder.swift
//  FoodDeliveryApp
//
//  Created by Admin on 14.10.2022.
//

import UIKit

protocol Builder {
    static func createTabBar() -> UITabBarController
    static func createMenuView() -> UIViewController
}

class ScreenViewBuilder: Builder {
    static func createTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        tabBar.tabBar.tintColor = UIColor(named: "MainAccentColor")
        tabBar.viewControllers = [createMenuView(),
                                  createContactsView(),
                                  createProfileView(),
                                  createBagView()]
        return tabBar
    }
    
    static func createMenuView() -> UIViewController {
        let view = MenuViewController()
        let networkService = NetworkService()
        let presenter = MenuViewPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        let navBar = UINavigationController(rootViewController: view)
        navBar.isNavigationBarHidden = true
        navBar.tabBarItem.title = "Menu"
        navBar.tabBarItem.image = UIImage(systemName: "scroll")
        return navBar
    }
    static func createContactsView() -> UIViewController {
        let view = UIViewController()
        view.view.backgroundColor = .systemBackground
        let navBar = UINavigationController(rootViewController: view)
        navBar.isNavigationBarHidden = true
        navBar.tabBarItem.title = "Contacts"
        navBar.tabBarItem.image = UIImage(systemName: "map")
        return navBar
    }
    static func createProfileView() -> UIViewController {
        let view = UIViewController()
        view.view.backgroundColor = .systemBackground
        let navBar = UINavigationController(rootViewController: view)
        navBar.isNavigationBarHidden = true
        navBar.tabBarItem.title = "Profile"
        navBar.tabBarItem.image = UIImage(systemName: "person.fill")
        return navBar
    }
    static func createBagView() -> UIViewController {
        let view = UIViewController()
        view.view.backgroundColor = .systemBackground
        let navBar = UINavigationController(rootViewController: view)
        navBar.isNavigationBarHidden = true
        navBar.tabBarItem.title = "Bag"
        navBar.tabBarItem.image = UIImage(systemName: "bag")
        return navBar
    }
}

extension UIView {
    @discardableResult func prepareForAutoLayout() -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}
