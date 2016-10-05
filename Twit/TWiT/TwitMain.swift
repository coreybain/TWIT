//
//  TwitMain.swift
//  TWiT
//
//  Created by Corey Baines on 24/9/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import UIKit

class TwitMain {
    
    static let shared = TwitMain()
    
    static func st() -> TwitMain {
        return shared
    }
    
    // MARK: - Variables
    
    // Setup and Binding to window
    private(set) var bindedToWindow: UIWindow!
    
    func startTwit() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        presentInWindow(window: window)
    }
    
    func presentInWindow(window: UIWindow) {
        
        //This beings the following view code to this window ref -> presentInNewWindow()
        self.bindedToWindow = window
        
        //Initiate tabViewController
        window.rootViewController = TwitTabBarController()
//        let layout = UICollectionViewFlowLayout()
//        let featuredController = FeaturedVC(collectionViewLayout: layout)
//        window.rootViewController = UINavigationController(rootViewController: featuredController)
        
    }
    
}
