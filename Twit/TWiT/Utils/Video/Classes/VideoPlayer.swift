//
//  VideoPlayer.swift
//  TWiT
//
//  Created by Corey Baines on 4/10/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import UIKit

var dragViewController: VideoVC?

struct VideoPlayer {
    
    static func initVideo(_ url: URL) {
        if (dragViewController == nil) {
            dragViewController = VideoVC(nibName: "YTFViewController", bundle: nil)
        }
        dragViewController?.urls = [url]
    }
    
    static func initVideo(_ urls: [URL], delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        if (dragViewController == nil) {
            dragViewController = VideoVC(nibName: "YTFViewController", bundle: nil)
        }
        dragViewController?.urls = urls
        dragViewController?.delegate = delegate
        dragViewController?.dataSource = dataSource
    }
    
    static func showYTFView() {
        if dragViewController!.isOpen == false {
            dragViewController!.view.frame = CGRect(x: (UIApplication.shared.keyWindow?.frame.size.width)!, y: (UIApplication.shared.keyWindow?.frame.size.height)!, width: (UIApplication.shared.keyWindow?.frame.size.width)!, height: (UIApplication.shared.keyWindow?.frame.size.height)!)
            dragViewController!.view.alpha = 0
            dragViewController!.view.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            dragViewController!.onView = UIApplication.shared.keyWindow?.rootViewController?.view //viewController.view
            
            
            
            UIApplication.shared.keyWindow?.addSubview(dragViewController!.view)
            
            UIView.animate(withDuration: 0.5, animations: {
                dragViewController!.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                dragViewController!.view.alpha = 1
                
                dragViewController!.view.frame = CGRect(x: 0, y: 0, width: UIApplication.shared.keyWindow!.bounds.width, height: UIApplication.shared.keyWindow!.bounds.height)
                
                dragViewController!.isOpen = true
            })
        }
    }

    
    static func changeURL(_ url: URL) {
        dragViewController?.urls = [url]
    }
    
    static func changeURLs(_ urls: [URL]) {
        dragViewController?.urls = urls
    }
    
    static func changeCurrentIndex(_ index: Int) {
        dragViewController?.currentUrlIndex = index
    }
    
    static func playIndex(_ index: Int) {
        dragViewController?.currentUrlIndex = index
        dragViewController?.playIndex(index)
        dragViewController?.hidePlayerControls(true)
    }
    
    static func getIndex() -> Int {
        return dragViewController!.currentUrlIndex
    }
    
    static func isOpen() -> Bool {
        return dragViewController?.isOpen == true ? true : false
    }
    
    static func getYTFViewController() -> UIViewController? {
        return dragViewController
    }
    
    static func finishYTFView(_ animated: Bool) {
        if(dragViewController != nil) {
            dragViewController?.isOpen = false
            dragViewController?.finishViewAnimated(animated)
            dragViewController = nil
        }
    }


    
}
