//
//  BaseTabBarController.swift
//  AppstoreJsonApis
//
//  Created by Animesh on 19/06/24.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let todayViewController = UIViewController()
        let todayNavBarController = createNavController(viewController: todayViewController, title: "Today", tabBarTitle: "Today", imageName: "today_icon")
        
        let appsNavBarController = createNavController(viewController: AppsController(), title: "Apps", tabBarTitle: "Apps", imageName: "apps")
        
        let searchNavBarController = createNavController(viewController: AppsSearchController(), title: "Search", tabBarTitle: "Search", imageName: "search")
        
        viewControllers = [appsNavBarController, searchNavBarController, todayNavBarController]
    }
    
    func createNavController(viewController: UIViewController, title: String, tabBarTitle: String, imageName: String) -> UINavigationController {
        viewController.view.backgroundColor = .white
        viewController.navigationItem.title = title
        viewController.view.backgroundColor = .white
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = tabBarTitle
        navController.tabBarItem.image = UIImage(named: imageName)
        navController.navigationBar.prefersLargeTitles = true
        
        return navController
    }
    
    
}
