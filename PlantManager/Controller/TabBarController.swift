//
//  TabBarController.swift
//  PlantManager
//
//  Created by Elizaveta Shelemekh on 09.12.2022.
//

import UIKit
import FirebaseAuth

final class TabBarController: UITabBarController {
    
    private enum TabBarItem: Int {
        case reminders
        case plantsCollection
        case discover
        
        var title: String {
            switch self {
            case .reminders:
                return "Reminders"
            case .plantsCollection:
                return "My Plants"
            case .discover:
                return "Discover"
            }
        }
        
        var iconName: String {
            switch self {
            case .reminders:
                return "bell"
            case .plantsCollection:
                return "leaf"
            case .discover:
                return "magnifyingglass"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .black
        setupTabBar()
    }
    
    private func setupTabBar() {
        let dataSource: [TabBarItem] = [.reminders, .plantsCollection, .discover]
        self.viewControllers = dataSource.map {
            switch $0 {
            case .reminders:
                let remindersViewController = RemindersViewController()
                return self.wrappedInNavigationController(with: remindersViewController, title: $0.title)
                
            case .plantsCollection:
                let plantsCollectionViewController = PlantsCollectionViewController()
                return self.wrappedInNavigationController(with: plantsCollectionViewController, title: $0.title)
                
            case .discover:
                let discoverViewController = DiscoverViewController()
                return self.wrappedInNavigationController(with: discoverViewController, title: $0.title)
            }
        }
        
        self.viewControllers?.enumerated().forEach {
            $1.tabBarItem.title = dataSource[$0].title
            $1.tabBarItem.image = UIImage(systemName: dataSource[$0].iconName)
            $1.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: .zero, bottom: -5, right: .zero)
        }
    }
    
    private func wrappedInNavigationController(with: UIViewController, title: Any?) -> UINavigationController {
        return UINavigationController(rootViewController: with)
    }
    
}
