//
//  VideoLauncher.swift
//  TWiT
//
//  Created by Corey Baines on 28/9/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AVKit


class VideoPlayerView: UIView {
    
    var player: AVPlayer?
    
    var isPlaying = false
    var wasPaused = false
    
    init(frame: CGRect, urlString:String?) {
        super.init(frame: frame)
        
        NotificationCenter.default.addObserver(self, selector:#selector(VideoPlayerView.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        backgroundColor = .black
        
        //warning: use your own video url here, the bandwidth for google firebase storage will run out as more and more people use this file
        
        if urlString != nil {
            if let url = URL(string: urlString!) {
                
                UserDefaults.standard.set(true, forKey: "videoplaying")
                UserDefaults.standard.set(true, forKey: "videoplayingLandscape")
                
                setupPlayerView(url: url)
                
                setupGradientLayer()
                
                controlsContainerView.frame = frame
                
                addSubview(controlsContainerView)
                
                
                
                controlsContainerView.addSubview(activityIndicatorView)
                activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
                activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
                
                controlsContainerView.addSubview(pausePlayButton)
                pausePlayButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
                pausePlayButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
                pausePlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
                pausePlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
                
                controlsContainerView.addSubview(cancelPlayerButton)
                cancelPlayerButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
                cancelPlayerButton.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
                cancelPlayerButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
                cancelPlayerButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
                
                controlsContainerView.addSubview(videoLengthLabel)
                videoLengthLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
                videoLengthLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
                videoLengthLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
                videoLengthLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
                
                controlsContainerView.addSubview(currentTimeLabel)
                currentTimeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
                currentTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
                currentTimeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
                currentTimeLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
                
                controlsContainerView.addSubview(videoSlider)
                videoSlider.rightAnchor.constraint(equalTo: videoLengthLabel.leftAnchor).isActive = true
                videoSlider.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
                videoSlider.leftAnchor.constraint(equalTo: currentTimeLabel.rightAnchor).isActive = true
                videoSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true
            }
        }
    }
    
    func rotated() {
        if(UIDeviceOrientationIsLandscape(UIDevice.current.orientation)) {
            print("landscape")
           // videoLauncher.showVideoPlayerLandscape()
            if let keyWindow = UIApplication.shared.keyWindow {
          
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    
                    self.frame = keyWindow.frame
                    if ((self.layer.sublayers?.count)! > 0) {
                        for layers in self.layer.sublayers! {
                            layers.frame = keyWindow.frame
                        }
                    }
                    if ((self.controlsContainerView.layer.sublayers?.count)! > 0) {
                        for layers in self.controlsContainerView.layer.sublayers! {
                            layers.frame = keyWindow.frame
                        }
                    }
                    
                    }, completion: { (completedAnimation) in
                        //maybe we'll do something here later...
                        UIApplication.shared.setStatusBarHidden(true, with: .slide)
                        self.window?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(VideoPlayerView.landscapeShowUI)))
                })
            }
            
        }
        
        if(UIDeviceOrientationIsPortrait(UIDevice.current.orientation)) {
            print("Portrait")
            //videoLauncher.showVideoPlayer()
            if let keyWindow = UIApplication.shared.keyWindow {
               
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    
                    let height = keyWindow.frame.width * 9 / 16
                    self.frame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
                    
                    if ((self.layer.sublayers?.count)! > 0) {
                        for layers in self.layer.sublayers! {
                            layers.frame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
                        }
                    }
                    if ((self.controlsContainerView.layer.sublayers?.count)! > 0) {
                        for layers in self.controlsContainerView.layer.sublayers! {
                            layers.frame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
                        }
                    }
                    
                    }, completion: { (completedAnimation) in
                        //maybe we'll do something here later...
                        UIApplication.shared.setStatusBarHidden(true, with: .slide)
                        
                        for recogniser in (self.window?.gestureRecognizers)! {
                            self.window?.removeGestureRecognizer(recogniser)
                        }
                })
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func landscapeShowUI() {
        if(UIDeviceOrientationIsLandscape(UIDevice.current.orientation)) {
            if self.controlsContainerView.isHidden {
                showUI()
            } else {
                resetTimer()
            }
        }
    }
    
    func showUI() {
        
        layer.removeAllAnimations()
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.controlsContainerView.alpha = 1.0
            self.controlsContainerView.isHidden = false
            
            }, completion: { (completedAnimation) in
                self.resetTimer()
        })

    }
    
    func hideUI() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(6)) {
            self.fadeUI()
        }

    }
    
    var timer: Timer?
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 6.0, target: self, selector: #selector(VideoPlayerView.fadeUI), userInfo: "timer", repeats: true)
    }
    
    func resetTimer(){
        
        timer?.invalidate()
        startTimer()
    }
    
    func stopTimer(){
        
        timer?.invalidate()
    }
    
    
    func fadeUI() {
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.controlsContainerView.alpha = 0.0
            
            }, completion: { (completedAnimation) in
                self.controlsContainerView.isHidden = true
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(UIDeviceOrientationIsPortrait(UIDevice.current.orientation)) {
            if self.controlsContainerView.isHidden {
                showUI()
            } else {
                resetTimer()
            }
        }
    }
    
    
    
    fileprivate func setupPlayerView(url:URL) {
        
        player = AVPlayer(url: url)
        
        let playerLayer = AVPlayerLayer(player: player)
        self.layer.addSublayer(playerLayer)
        playerLayer.frame = self.frame
        
        
        player?.play()
        
        player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        
        //track player progress
        
        let interval = CMTime(value: 1, timescale: 2)
        player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
            
            let seconds = CMTimeGetSeconds(progressTime)
            let secondsString = String(format: "%02d", Int(seconds.truncatingRemainder(dividingBy: 60)))
            let minutesString = String(format: "%02d", Int(seconds / 60))
            
            self.currentTimeLabel.text = "\(minutesString):\(secondsString)"
            
            //lets move the slider thumb
            if let duration = self.player?.currentItem?.duration {
                let durationSeconds = CMTimeGetSeconds(duration)
                
                self.videoSlider.value = Float(seconds / durationSeconds)
                
            }
            
        })
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        //this is when the player is ready and rendering frames
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = .clear
            pausePlayButton.isHidden = false
            if !isPlaying && !wasPaused {
                isPlaying = true
                startTimer()
            }
            
            if let duration = player?.currentItem?.duration {
                let seconds = CMTimeGetSeconds(duration)
                
                let secondsText = Int(seconds) % 60
                let minutesText = String(format: "%02d", Int(seconds) / 60)
                videoLengthLabel.text = "\(minutesText):\(secondsText)"
            }
        }
    }
    
    fileprivate func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.7, 1.2]
        controlsContainerView.layer.addSublayer(gradientLayer)
    }
    
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    lazy var pausePlayButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "pause")
        button.setImage(image, for: UIControlState())
        button.tintColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        
        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        button.addTarget(self, action: #selector(resetTimer), for: .touchUpInside)
        
        return button
    }()
    
    lazy var cancelPlayerButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "downArrow")
        button.setImage(image, for: UIControlState())
        button.tintColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let featureVC = FeaturedVC()
        button.addTarget(self, action: #selector(stopTimer), for: .touchUpInside)
        button.addTarget(self, action: #selector(hideVideo), for: .touchUpInside)
        return button
    }()
    
    func hideVideo() {
        if let keyWindow = UIApplication.shared.keyWindow {
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                UIApplication.shared.setStatusBarHidden(false, with: .slide)
                keyWindow.viewWithTag(1)?.frame = CGRect(x: keyWindow.frame.width - 5, y: keyWindow.frame.height - 5, width: 5, height: 5)
                self.player?.pause()
                
                UserDefaults.standard.removeObject(forKey: "videoplaying")
                UserDefaults.standard.removeObject(forKey: "videoplayingLandscape")
                NotificationCenter.default.removeObserver(self)
                let value = UIInterfaceOrientation.portrait.rawValue
                UIDevice.current.setValue(value, forKey: "orientation")
                
                }, completion: { (completedAnimation) in
                    //maybe we'll do something here later...
                    keyWindow.viewWithTag(1)?.removeFromSuperview()
//                    UIApplication.shared.setStatusBarHidden(false, with: .slide)
            })
            
            
        }
    }
    
    func handlePause() {
        if isPlaying {
            player?.pause()
            wasPaused = true
            pausePlayButton.setImage(UIImage(named: "play"), for: UIControlState())
        } else {
            player?.play()
            wasPaused = false
            pausePlayButton.setImage(UIImage(named: "pause"), for: UIControlState())
        }
        
        isPlaying = !isPlaying
    }
    
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    let videoLengthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textAlignment = .right
        return label
    }()
    
    let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    let airPlayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.image = UIImage(named: "downArrow")
        return button
    }()
    
    lazy var videoSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .white
        slider.setThumbImage(UIImage(named: "thumb"), for: UIControlState())
        
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        slider.addTarget(self, action: #selector(resetTimer), for: .valueChanged)
        
        return slider
    }()
    
    func handleSliderChange() {
        
        if let duration = player?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            
            let value = Float64(videoSlider.value) * totalSeconds
            
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            
            player?.seek(to: seekTime, completionHandler: { (completedSeek) in
                //perhaps do something later here
            })
        }
    }

}

class VideoLauncher: NSObject {
    
    var urlString:String = ""
    
    func showVideoPlayer() {
        
        if let keyWindow = UIApplication.shared.keyWindow {
            
            
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = UIColor.white
            
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            //16 x 9 is the aspect ratio of all HD videos
            let height = keyWindow.frame.width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
            
            
            print(urlString)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame, urlString: urlString)
            view.isUserInteractionEnabled = true
            view.addSubview(videoPlayerView)
            view.tag = 1
            
            keyWindow.addSubview(view)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                view.frame = keyWindow.frame
                
                }, completion: { (completedAnimation) in
                    //maybe we'll do something here later...
                    UIApplication.shared.setStatusBarHidden(true, with: .slide)
            })
        }
    }
    
}
