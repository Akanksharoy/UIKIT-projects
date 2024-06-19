//
//  CustomTabBarController.swift
//  FacebookFeed
//
//  Created by Animesh on 16/06/24.
//

import UIKit

class CustomTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let feedController = ViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let navigationController = UINavigationController(rootViewController: feedController)
        navigationController.title = "News Feed"
        
        
        let friendRequestController = UIViewController()
        let secondNavigatiopnController = UINavigationController(rootViewController: friendRequestController)
        secondNavigatiopnController.title = "Requests"
        viewControllers = [navigationController, secondNavigatiopnController]
        
        // To decrease the thickness of the tab bar line at the top 
        
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: 1000, height: 0.5)
        topBorder.backgroundColor = UIColor.rgb(red: 229, green: 231, blue: 235).cgColor
        tabBar.layer.addSublayer(topBorder)
        tabBar.clipsToBounds = true
    }
}
