//
//  TwitMain.swift
//  Twit
//
//  Created by Corey Baines on 4/09/2016.
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
        let window = UIWindow(frame: UIScreen.mainScreen().bounds);
        window.backgroundColor = UIColor.whiteColor()
        presentInWindow(window)
        window.makeKeyAndVisible()
    }
    
    func presentInWindow(window: UIWindow) {
        
        //This beings the following view code to this window ref -> presentInNewWindow()
        self.bindedToWindow = window
        
        //Initiate tabViewController
        window.rootViewController = TwitTabBarController()
        
    }

}