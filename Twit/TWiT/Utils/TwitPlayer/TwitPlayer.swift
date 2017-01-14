//
//  TwitPlayer.swift
//  TWiT
//
//  Created by Corey Baines on 31/12/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import UIKit

var twitVideoVC: TwitVideoPlayer?
var viewControllerLoaded:Bool = false

struct TwitPlayer {
    
//    static func initLiveTabVideo(_ url: URL) -> TwitVideoPlayer? {
//        if (twitVideoVC == nil) {
//            twitVideoVC = TwitVideoPlayer()
//        } else if (twitVideoVC?.isMinimized)! {
//            twitVideoVC?.viewControllerView()
//        }
//        twitVideoVC?.urls = [url]
//        viewControllerLoaded = true
//        return twitVideoVC!
//    }
    
    static func initTwitVideo(_ url: URL, liveVC:Bool, navHeight:CGFloat?, tabHeight:CGFloat?) {
        if (twitVideoVC == nil) {
            twitVideoVC = TwitVideoPlayer()
        }
        
        if (twitVideoVC?.urls?[0]) != nil {
            if (twitVideoVC?.urls![0]) != url {
                twitVideoVC?.urls = [url]
            }
        } else {
            twitVideoVC?.urls = [url]
        }
        twitVideoVC?.tabBarHeight = tabHeight!
        twitVideoVC?.navigationBarHeight = navHeight!
        viewControllerLoaded = liveVC
    }
    
//    static func showLiveTabVideo(_ url: URL) {
//        if ((twitVideoVC != nil) && viewControllerLoaded && (twitVideoVC?.isMinimized)!) {
//            twitVideoVC?.viewControllerView()
//            viewControllerLoaded = true
//            if !(twitVideoVC?.isLive)! {
//                twitVideoVC?.urls = [url]
//            }
//        }
//    }
    
    
    
    static func showTwitView(navHeight:CGFloat?, tabHeight:CGFloat?) {
        if UserDefaults.standard.bool(forKey: "isLiveTab") {
            if twitVideoVC?.isOpen == false {
                twitVideoVC!.view.frame = CGRect(x: 0, y: (UIApplication.shared.statusBarFrame.height + navHeight!), width: (UIApplication.shared.keyWindow?.frame.size.width)!, height: ((UIApplication.shared.keyWindow?.frame.height)! - ((UIApplication.shared.statusBarFrame.height + navHeight!) + tabHeight!)))
                twitVideoVC!.view.backgroundColor = UIColor.clear
                twitVideoVC!.onView = UIApplication.shared.keyWindow?.rootViewController?.view
                twitVideoVC!.activeLiveStream = true
                twitVideoVC!.isOpen = true
                
                UIApplication.shared.keyWindow?.addSubview(twitVideoVC!.view)
            } else if UserDefaults.standard.bool(forKey: "isLiveStream") == true  {
                twitVideoVC!.viewControllerView(viewFrame: CGRect(x: 0, y: (UIApplication.shared.statusBarFrame.height + navHeight!), width: (UIApplication.shared.keyWindow?.frame.size.width)!, height: ((UIApplication.shared.keyWindow?.frame.height)! - ((UIApplication.shared.statusBarFrame.height + navHeight!) + tabHeight!))))
            }
            
        }
    }
    
    static func showYTFView() {
        if twitVideoVC!.isOpen == false {
            twitVideoVC!.view.frame = CGRect(x: (UIApplication.shared.keyWindow?.frame.size.width)!, y: (UIApplication.shared.keyWindow?.frame.size.height)!, width: (UIApplication.shared.keyWindow?.frame.size.width)!, height: (UIApplication.shared.keyWindow?.frame.size.height)!)
            twitVideoVC!.view.alpha = 0
            twitVideoVC!.view.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            twitVideoVC!.onView = UIApplication.shared.keyWindow?.rootViewController?.view //viewController.view
            
            
            
            UIApplication.shared.keyWindow?.addSubview(twitVideoVC!.view)
            
            UIView.animate(withDuration: 0.5, animations: {
                twitVideoVC!.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                twitVideoVC!.view.alpha = 1
                
                twitVideoVC!.view.frame = CGRect(x: 0, y: 0, width: UIApplication.shared.keyWindow!.bounds.width, height: UIApplication.shared.keyWindow!.bounds.height)
                
                twitVideoVC!.isOpen = true
            })
        }
    }
    
    
    static func changeURL(_ url: URL) {
        twitVideoVC?.urls = [url]
    }
    
    static func changeURLs(_ urls: [URL]) {
        twitVideoVC?.urls = urls
    }
    
    static func changeCurrentIndex(_ index: Int) {
        twitVideoVC?.currentUrlIndex = index
    }
    
    static func playIndex(_ index: Int) {
        twitVideoVC?.currentUrlIndex = index
        twitVideoVC?.playURLIndex(index)
        //twitVideoVC?.hidePlayerControls(true)
    }
    
    static func getIndex() -> Int {
        return twitVideoVC!.currentUrlIndex
    }
    
    static func isOpen() -> Bool {
        return twitVideoVC?.isOpen == true ? true : false
    }
    
    static func minimizeLiveView() {
        twitVideoVC?.minimizeViews()
    }
    
    static func getYTFViewController() -> UIViewController? {
        return twitVideoVC
    }
    
    static func finishYTFView(_ animated: Bool) {
        if(twitVideoVC != nil) {
            twitVideoVC?.isOpen = false
            //twitVideoVC?.finishViewAnimated(animated)
            twitVideoVC = nil
        }
    }

    
}
