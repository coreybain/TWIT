//
//  TwitTabBarController.swift
//  TWiT
//
//  Created by Corey Baines on 24/9/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import UIKit

class TwitTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Home viewController
        let homeLayout = UICollectionViewFlowLayout()
        let homeVC = FeaturedVC(collectionViewLayout: homeLayout)
        let homeNavController = UINavigationController(rootViewController: homeVC)
        homeNavController.tabBarItem.title = "Featured"
        homeNavController.tabBarItem.image = UIImage(named: "iconFeatured")
        
        // Shows viewController
        let notificationLayout = UIViewController()
        let notificationNavController = UINavigationController(rootViewController: notificationLayout)
        notificationNavController.tabBarItem.title = "Subscriptions"
        notificationNavController.tabBarItem.image = UIImage(named: "iconSubscriptions")
        
        // Live viewController
        let showLayout = UIViewController()
        let showNavController = UINavigationController(rootViewController: showLayout)
        showNavController.tabBarItem.title = "Live"
        showNavController.tabBarItem.image = UIImage(named: "iconLive")
        
        // Twit viewController
        let twitController = UIViewController()
        let twitNavController = UINavigationController(rootViewController: twitController)
        twitNavController.tabBarItem.title = "Trending"
        twitNavController.tabBarItem.image = UIImage(named: "iconTrending")
        
        // Accounts viewController
        let accountController = UIViewController()
        let accountNavController = UINavigationController(rootViewController: accountController)
        accountNavController.tabBarItem.title = "Account"
        accountNavController.tabBarItem.image = UIImage(named: "iconAccount")
        
        viewControllers = [homeNavController, notificationNavController, showNavController, twitNavController, accountNavController]
    }
}
