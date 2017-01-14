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
    
    var liveViewController: TwitVideoPlayer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Featured viewController
        let homeLayout = UICollectionViewFlowLayout()
        let homeVC = FeaturedVC(collectionViewLayout: homeLayout)
        let homeNavController = UINavigationController(rootViewController: homeVC)
        homeNavController.tabBarItem.title = "Featured"
        homeNavController.tabBarItem.tag = 1
        homeNavController.tabBarItem.image = UIImage(named: "iconFeatured")
        
        // Subscriptions viewController
        let subscriptionLayout = UICollectionViewFlowLayout()
        let subscriptionVC = SubscriptionsVC(collectionViewLayout: subscriptionLayout)
        let subscriptionNavController = UINavigationController(rootViewController: subscriptionVC)
        subscriptionNavController.tabBarItem.title = "Subscriptions"
        subscriptionNavController.tabBarItem.tag = 2
        subscriptionNavController.tabBarItem.image = UIImage(named: "iconSubscriptions")
        
        // Live viewController
        let liveNavController = UINavigationController(rootViewController: LiveInitVC())
        liveNavController.tabBarItem.title = "Live"
        liveNavController.tabBarItem.tag = 3
        liveNavController.tabBarItem.image = UIImage(named: "iconLive")
        
        // Trending viewController
        let trendingLayout = UICollectionViewFlowLayout()
        let trendingVC = TrendingVC(collectionViewLayout: trendingLayout)
        let trendingNavController = UINavigationController(rootViewController: trendingVC)
        trendingNavController.tabBarItem.title = "Trending"
        trendingNavController.tabBarItem.tag = 4
        trendingNavController.tabBarItem.image = UIImage(named: "iconTrending")
        
        // Accounts viewController
//        let accountLayout = UITableViewController()
        let accountVC = AccountVC()
        let accountNavController = UINavigationController(rootViewController: accountVC)
        accountNavController.tabBarItem.title = "Account"
        accountNavController.tabBarItem.tag = 5
        accountNavController.tabBarItem.image = UIImage(named: "iconAccount")
        
        viewControllers = [homeNavController, subscriptionNavController, liveNavController, trendingNavController, accountNavController]
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 1 {
            print("HEHEHEHE 1")
            
            if TwitPlayer.isOpen() == true && UserDefaults.standard.bool(forKey: "isLiveTab") {
                TwitPlayer.minimizeLiveView()
                UserDefaults.standard.set(false, forKey: "isLiveTab")
            }
            
        } else if item.tag == 2 {
            print("HEHEHEHE 2")
            if TwitPlayer.isOpen() == true && UserDefaults.standard.bool(forKey: "isLiveTab") {
                TwitPlayer.minimizeLiveView()
                UserDefaults.standard.set(false, forKey: "isLiveTab")
            }
            
        } else if item.tag == 3 {
            print("HEHEHEHE 3")
//            if TwitPlayer.isOpen() == true && UserDefaults.standard.bool(forKey: "isLiveStream") {
//                TwitPlayer.showTwitView(navHeight: nil, tabHeight: nil)
//                UserDefaults.standard.set(false, forKey: "isLiveTab")
//            }
            
        } else if item.tag == 4 {
            print("HEHEHEHE 4")
            if TwitPlayer.isOpen() == true && UserDefaults.standard.bool(forKey: "isLiveTab") {
                TwitPlayer.minimizeLiveView()
                UserDefaults.standard.set(false, forKey: "isLiveTab")
            }
            
        } else if item.tag == 5 {
            print("HEHEHEHE 5")
            if TwitPlayer.isOpen() == true && UserDefaults.standard.bool(forKey: "isLiveTab") {
                TwitPlayer.minimizeLiveView()
                //TwitPlayer.showTwitView(navHeight: nil, tabHeight: nil)
                UserDefaults.standard.set(false, forKey: "isLiveTab")
            }
            
        }
    }
}
