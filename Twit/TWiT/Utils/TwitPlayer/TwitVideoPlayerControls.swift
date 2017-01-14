//
//  TwitVideoPlayerControls.swift
//  TWiT
//
//  Created by Corey Baines on 31/12/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

//MARK: -- Setup Controls

extension TwitVideoPlayer {
 
    func setupControlls() {
        if player != nil {
            
            let videoHeight = view.frame.width * 9/16
            
            controlsContainerView.addSubview(playPauseButton)
            controlsContainerView.addSubview(airPlayButton)
            controlsContainerView.addSubview(scheduleButton)
            controlsContainerView.addSubview(progress)
            
            if !UserDefaults.standard.bool(forKey: "isLiveStream") {
                controlsContainerView.addSubview(slider)
                controlsContainerView.addSubview(currentTime)
                controlsContainerView.addSubview(entireTime)
                slider.frame = CGRect(x: (14 + 8), y: (videoHeight - 14), width: (view.frame.width - (64 + 44)), height: 5)
                currentTime.frame = CGRect(x: 14, y: (videoHeight - 23), width: 32, height: 11)
                entireTime.frame = CGRect(x: (view.frame.width - 46), y: (videoHeight - 23), width: 32, height: 11)
            }
            
            playPauseButton.frame = CGRect(x: (view.frame.width/2) - (playButtonSize/2), y: (videoHeight/2) - (playButtonSize/2), width: playButtonSize, height: playButtonSize)
            airPlayButton.frame = CGRect(x: (view.frame.width - 14 - airPlayButtonSize), y: 14, width: airPlayButtonSize, height: airPlayButtonSize)
            scheduleButton.frame = CGRect(x: 14, y: 14, width: scheduleButtonSize, height: scheduleButtonSize)
            progress.frame = CGRect(x: (14 + 32 + 8), y: (videoHeight - (14 + 5)), width: (view.frame.width - (64 + 44)), height: 5)
        }
    }
    
    func rotateControls() {
        
        if player != nil {
            let videoHeight = view.frame.width * 9/16
            if isRotated {
                
                if !isLive && !isLiveTab {
                    slider.frame = CGRect(x: (14 + 32 + 8), y: (controlsContainerView.frame.width - (14 + 5)), width: (controlsContainerView.frame.height - (currentTime.frame.width + entireTime.frame.width + ((14+8)*2))), height: 5)
                }
                
                playPauseButton.frame = CGRect(x: (controlsContainerView.frame.height/2) - (playButtonSize/2), y: (controlsContainerView.frame.width/2) - (playButtonSize/2), width: playButtonSize, height: playButtonSize)
                airPlayButton.frame = CGRect(x: (controlsContainerView.frame.height - 14 - airPlayButtonSize), y: 14, width: airPlayButtonSize, height: airPlayButtonSize)
                scheduleButton.frame = CGRect(x: 14, y: 14, width: scheduleButtonSize, height: scheduleButtonSize)
                currentTime.frame = CGRect(x: 14, y: (controlsContainerView.frame.width - (14 + 11)), width: 32, height: 11)
                entireTime.frame = CGRect(x: (controlsContainerView.frame.height - (14 + 32)), y: (controlsContainerView.frame.width - (14 + 11)), width: 32, height: 11)
                progress.frame = CGRect(x: (14 + 32 + 8), y: (controlsContainerView.frame.width - (14 + 5)), width: (controlsContainerView.frame.height - (currentTime.frame.width + entireTime.frame.width + ((14+8)*2))), height: 5)
                
                isRotated = false
            } else {
                
                if !isLive && !isLiveTab {
                    slider.frame = CGRect(x: (14 + 8), y: (videoHeight - 14), width: (view.frame.width - (64 + 44)), height: 5)
                }
                
                playPauseButton.frame = CGRect(x: (view.frame.width/2) - (playButtonSize/2), y: (videoHeight/2) - (playButtonSize/2), width: playButtonSize, height: playButtonSize)
                airPlayButton.frame = CGRect(x: (view.frame.width - 14 - airPlayButtonSize), y: 14, width: airPlayButtonSize, height: airPlayButtonSize)
                scheduleButton.frame = CGRect(x: 14, y: 14, width: scheduleButtonSize, height: scheduleButtonSize)
                currentTime.frame = CGRect(x: 14, y: (videoHeight - 14), width: 32, height: 11)
                entireTime.frame = CGRect(x: (view.frame.width - (14 + 32)), y: (videoHeight - (14 + 11)), width: 32, height: 11)
                progress.frame = CGRect(x: (14 + 32 + 8), y: (videoHeight - (14 + 5)), width: (view.frame.width - (64 + 44)), height: 5)
                
            }
        }
    }
    
}

extension TwitVideoPlayer {
    
    func playURLIndex(_ index:Int) {
        player?.url = urls![index]
        player?.play()
        progressIndicatorView.isHidden = false
        progressIndicatorView.startAnimating()
    }
}

extension TwitVideoPlayer: TwitPlayerViewDelegate {
    
    func playerVideo(_ player: TwitPlayerView, statusPlayer: PVStatus, error: NSError?) {
        
        switch statusPlayer {
        case AVPlayerStatus.unknown:
            print("Unknown")
            break
        case AVPlayerStatus.failed:
            print("Failed")
            break
        default:
            readyToPlay()
        }
    }
    
    func readyToPlay() {
        progressIndicatorView.stopAnimating()
        progressIndicatorView.isHidden = true
        playerTapGesture = UITapGestureRecognizer(target: self, action: #selector(TwitVideoPlayer.showPlayerControls))
        player?.addGestureRecognizer(playerTapGesture!)
        print("Ready to Play")
        self.player?.play()
    }
    
    func playerVideo(_ player: TwitPlayerView, statusItemPlayer: PVItemStatus, error: NSError?) {
    }
    
    func playerVideo(_ player: TwitPlayerView, loadedTimeRanges: [PVTimeRange]) {
        if (progressIndicatorView.isHidden == false) {
            progressIndicatorView.stopAnimating()
            progressIndicatorView.isHidden = true
        }
        
        if let first = loadedTimeRanges.first {
            let bufferedSeconds = Float(CMTimeGetSeconds(first.start) + CMTimeGetSeconds(first.duration))
            progress.progress = bufferedSeconds / slider.maximumValue
        }
    }
    
    func playerVideo(_ player: TwitPlayerView, duration: Double) {
        var duration = 0
        if !isLive {
            duration = Int(duration)
            self.entireTime.text = timeFormatted(duration)
            slider.maximumValue = Float(duration)
        } else {
            self.entireTime.text = "00:00"
            slider.isHidden = true
        }
    }
    
    func playerVideo(_ player: TwitPlayerView, currentTime: Double) {
        let curTime = Int(currentTime)
        self.currentTime.text = timeFormatted(curTime)
        if (!dragginSlider && (Int(slider.value) != curTime)) { // Change every second
            slider.value = Float(currentTime)
        }
    }
    
    func playerVideo(_ player: TwitPlayerView, rate: Float) {
        print(rate)
        if (rate == 1.0) {
            isPlaying = true
            playPauseButton.setImage(UIImage(named: "pause-button"), for: UIControlState())
            hideTimer?.invalidate()
            showPlayerControls()
        } else {
            isPlaying = false
            playPauseButton.setImage(UIImage(named: "play-button"), for: UIControlState())
        }
    }
    
    func playerVideo(playerFinished player: TwitPlayerView) {
        currentUrlIndex += 1
        playURLIndex(currentUrlIndex)
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
