//
//  GuideLauncher.swift
//  TWiT
//
//  Created by Corey Baines on 6/11/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//
import Foundation
import UIKit
import AVKit
import AVFoundation

class GuideLauncher: NSObject {
    
    let blackView = UIView()
    var superplayer:AVPlayer?
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    var playPauseButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "likeButton"), for: .normal)
        return button
    }()
    
    var airPlayButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "likeButton"), for: .normal)
        return button
    }()
    
    func showGuide(offsetHeight: CGFloat?, videoHeight:CGFloat?, player:AVPlayer?) {
        //show menu
        
        if let window = UIApplication.shared.keyWindow {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            
            window.addSubview(collectionView)
            
            //TODO Show controls for video including pause and reload and airplay video.
            if (player != nil) {
                self.superplayer = player
                let tt = window.frame.width
                
                playPauseButton.frame = CGRect(x: (window.frame.width/2) - 25, y: (window.frame.width * 9/16)/2 - 25, width: 50, height: 50)
                airPlayButton.frame = CGRect(x: window.frame.width - 38, y: 15, width: 25, height: 25)
                
                blackView.addSubview(playPauseButton)
                blackView.addSubview(airPlayButton)
            }
            
            let height: CGFloat = window.frame.height - (offsetHeight! + videoHeight!)
            let y = (offsetHeight! + videoHeight!)
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            blackView.frame = CGRect(x: 0, y: offsetHeight!, width: window.frame.width, height: (window.frame.height - (offsetHeight!)))
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.blackView.alpha = 1
                
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
                
            }, completion: nil)
        }
    }
    
    func handleDismiss() {
        superplayer?.pause()
        
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }
    }
    
    override init() {
        super.init()
        //start doing something here maybe....
    }
    
}
