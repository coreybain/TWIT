//
//  LiveInitVC.swift
//  TWiT
//
//  Created by Corey Baines on 4/1/17.
//  Copyright © 2017 Corey Baines. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation
import MediaPlayer

class LiveInitVC: UIViewController{
    
    var twitVideoVC: TwitVideoPlayer?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        navigationItem.title = "Live"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UserDefaults.standard.set(true, forKey: "isLiveTab")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UserDefaults.standard.set(true, forKey: "isLiveStream")
        
        TwitPlayer.initTwitVideo(URL(string: "http://hls.twit.tv/flosoft/smil:twitStreamHi.smil/playlist.m3u8")!, liveVC: true, navHeight: (navigationController?.navigationBar.frame.size.height)!, tabHeight: (tabBarController?.tabBar.frame.size.height)!)
        TwitPlayer.showTwitView(navHeight: (navigationController?.navigationBar.frame.size.height)!, tabHeight: (tabBarController?.tabBar.frame.size.height)!)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
