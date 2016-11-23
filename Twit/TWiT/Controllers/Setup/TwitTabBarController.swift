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
        
        // Featured viewController
        let homeLayout = UICollectionViewFlowLayout()
        let homeVC = FeaturedVC(collectionViewLayout: homeLayout)
        let homeNavController = UINavigationController(rootViewController: homeVC)
        homeNavController.tabBarItem.title = "Featured"
        homeNavController.tabBarItem.image = UIImage(named: "iconFeatured")
        
        // Subscriptions viewController
        let subscriptionLayout = UICollectionViewFlowLayout()
        let subscriptionVC = SubscriptionsVC(collectionViewLayout: subscriptionLayout)
        let subscriptionNavController = UINavigationController(rootViewController: subscriptionVC)
        subscriptionNavController.tabBarItem.title = "Subscriptions"
        subscriptionNavController.tabBarItem.image = UIImage(named: "iconSubscriptions")
        
        // Live viewController
        let liveViewController = LiveVC()
        let liveNavController = UINavigationController(rootViewController: liveViewController)
        liveNavController.tabBarItem.title = "Live"
        liveNavController.tabBarItem.image = UIImage(named: "iconLive")
        
        // Trending viewController
        let trendingLayout = UICollectionViewFlowLayout()
        let trendingVC = TrendingVC(collectionViewLayout: trendingLayout)
        let trendingNavController = UINavigationController(rootViewController: trendingVC)
        trendingNavController.tabBarItem.title = "Trending"
        trendingNavController.tabBarItem.image = UIImage(named: "iconTrending")
        
        // Accounts viewController
//        let accountLayout = UITableViewController()
        let accountVC = AccountVC()
        let accountNavController = UINavigationController(rootViewController: accountVC)
        accountNavController.tabBarItem.title = "Account"
        accountNavController.tabBarItem.image = UIImage(named: "iconAccount")
        
        viewControllers = [homeNavController, subscriptionNavController, liveNavController, trendingNavController, accountNavController]
    }
}
