//
//  TwitPlayerAnimations.swift
//  TWiT
//
//  Created by Corey Baines on 31/12/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import UIKit

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}


enum UIPanGestureRecognizerDirection {
    case undefined
    case up
    case down
    case left
    case right
}

extension TwitVideoPlayer {
    
    //MARK: -- Player Controls Animations
    
    func showPlayerControls() {
        if (!isMinimized) {
            UIView.animate(withDuration: 0.6, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.backControlsContainerView.alpha = 0.55
                self.controlsContainerView.alpha = 1.0
                //self.minimizeButton.alpha = 1.0
                if !self.isFullscreen {
                    UIApplication.shared.setStatusBarHidden(false, with: .slide)
                }
                
            }, completion: nil)
            hideTimer?.invalidate()
            hideTimer = nil
            hideTimer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(TwitVideoPlayer.hidePlayerControls(_:)), userInfo: 1.0, repeats: false)
        }
    }
    
    func hidePlayerControls(_ dontAnimate: Bool) {
        if (dontAnimate) {
            self.backControlsContainerView.alpha = 0.0
            self.controlsContainerView.alpha = 0.0
        } else {
            if (isPlaying) {
                UIView.animate(withDuration: 0.6, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                    self.backControlsContainerView.alpha = 0.0
                    self.controlsContainerView.alpha = 0.0
                   // self.minimizeButton.alpha = 0.0
                    if self.isFullscreen {
                        UIApplication.shared.setStatusBarHidden(true, with: .slide)
                    }
                    
                }, completion: nil)
            }
        }
    }
    
    //MARK: -- Video Animations
    
    //MARK: --- Fullscreen
    
    func setPlayerToFullscreen() {
        self.hidePlayerControls(true)
        UIApplication.shared.setStatusBarHidden(true, with: .slide)
        //self.context?.navigationController?.setNavigationBarHidden(true, animated: true)
        setTabBarVisible(visible: false, animated: true)
        
        print( self.initialFirstViewFrame!.size.width)
        print( self.initialFirstViewFrame!.size.height)
        
        UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions(), animations: {
            //self.minimizeButton.isHidden = true
            self.player?.transform = CGAffineTransform(rotationAngle: CGFloat((M_PI_2)))
            self.backControlsContainerView.transform = CGAffineTransform(rotationAngle: CGFloat((M_PI_2)))
            self.controlsContainerView.transform = CGAffineTransform(rotationAngle: CGFloat((M_PI_2)))
            
            if UserDefaults.standard.bool(forKey: "isLiveTab") {
                self.player?.frame = CGRect(x: self.initialFirstViewFrame!.origin.x, y: self.initialFirstViewFrame!.origin.x - (self.navigationBarHeight! + self.statusBarHeight!), width: self.initialFirstViewFrame!.size.width, height: self.initialFirstViewFrame!.size.height)
            
                self.backControlsContainerView.frame = CGRect(x: self.initialFirstViewFrame!.origin.x, y: self.initialFirstViewFrame!.origin.x - (self.navigationBarHeight! + self.statusBarHeight!), width: self.initialFirstViewFrame!.size.width, height: self.initialFirstViewFrame!.size.height)
            
                self.controlsContainerView.frame = CGRect(x: self.initialFirstViewFrame!.origin.x, y: self.initialFirstViewFrame!.origin.x - (self.navigationBarHeight! + self.statusBarHeight!), width: self.initialFirstViewFrame!.size.width, height: self.initialFirstViewFrame!.size.height)
            } else {
                self.player?.frame = CGRect(x: self.initialFirstViewFrame!.origin.x, y: self.initialFirstViewFrame!.origin.x, width: self.initialFirstViewFrame!.size.width, height: self.initialFirstViewFrame!.size.height)
                
                self.backControlsContainerView.frame = CGRect(x: self.initialFirstViewFrame!.origin.x, y: self.initialFirstViewFrame!.origin.x, width: self.initialFirstViewFrame!.size.width, height: self.initialFirstViewFrame!.size.height)
                
                self.controlsContainerView.frame = CGRect(x: self.initialFirstViewFrame!.origin.x, y: self.initialFirstViewFrame!.origin.x, width: self.initialFirstViewFrame!.size.width, height: self.initialFirstViewFrame!.size.height)
            }
            
            self.isRotated = true
        }, completion: { finished in
            self.isFullscreen = true
            //self.fullscreen.setImage(UIImage(named: "unfullscreen"), for: UIControlState())
            
            self.rotateControls()
            self.showPlayerControls()
        })
    }
    
    func setPlayerToFullscreenLeft() {
        self.hidePlayerControls(true)
        UIApplication.shared.setStatusBarHidden(true, with: .slide)
        //self.context?.navigationController?.setNavigationBarHidden(true, animated: true)
        setTabBarVisible(visible: false, animated: true)
        
        UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions(), animations: {
            //self.minimizeButton.isHidden = true
            self.player?.transform = CGAffineTransform(rotationAngle: CGFloat(-(M_PI_2)))
            self.backControlsContainerView.transform = CGAffineTransform(rotationAngle: CGFloat(-(M_PI_2)))
            self.controlsContainerView.transform = CGAffineTransform(rotationAngle: CGFloat(-(M_PI_2)))
            
            if UserDefaults.standard.bool(forKey: "isLiveTab") {
                self.player?.frame = CGRect(x: self.initialFirstViewFrame!.origin.x, y: self.initialFirstViewFrame!.origin.x - (self.navigationBarHeight! + self.statusBarHeight!), width: self.initialFirstViewFrame!.size.width, height: self.initialFirstViewFrame!.size.height)
                
                self.backControlsContainerView.frame = CGRect(x: self.initialFirstViewFrame!.origin.x, y: self.initialFirstViewFrame!.origin.x - (self.navigationBarHeight! + self.statusBarHeight!), width: self.initialFirstViewFrame!.size.width, height: self.initialFirstViewFrame!.size.height)
                
                self.controlsContainerView.frame = CGRect(x: self.initialFirstViewFrame!.origin.x, y: self.initialFirstViewFrame!.origin.x - (self.navigationBarHeight! + self.statusBarHeight!), width: self.initialFirstViewFrame!.size.width, height: self.initialFirstViewFrame!.size.height)
            } else {
                self.player?.frame = CGRect(x: self.initialFirstViewFrame!.origin.x, y: self.initialFirstViewFrame!.origin.x, width: self.initialFirstViewFrame!.size.width, height: self.initialFirstViewFrame!.size.height)
                
                self.backControlsContainerView.frame = CGRect(x: self.initialFirstViewFrame!.origin.x, y: self.initialFirstViewFrame!.origin.x, width: self.initialFirstViewFrame!.size.width, height: self.initialFirstViewFrame!.size.height)
                
                self.controlsContainerView.frame = CGRect(x: self.initialFirstViewFrame!.origin.x, y: self.initialFirstViewFrame!.origin.x, width: self.initialFirstViewFrame!.size.width, height: self.initialFirstViewFrame!.size.height)
            }
            
            self.isRotated = true
        }, completion: { finished in
            self.isFullscreen = true
            //self.fullscreen.setImage(UIImage(named: "unfullscreen"), for: UIControlState())
            
            self.rotateControls()
            self.showPlayerControls()
        })
    }
    
    func setTabBarVisible(visible: Bool, animated: Bool) {
        //* This cannot be called before viewDidLayoutSubviews(), because the frame is not set before this time
        
        // bail if the current state matches the desired state
        print(isTabBarVisible)
        print(visible)
        if (isTabBarVisible == visible) { return }
        
        // get a frame calculation ready
        let frame = self.tabBarController?.tabBar.frame
        print(frame)
        let height = frame?.size.height
        let offsetY = (visible ? -height! : height)
        
        // zero duration means no animation
        let duration: TimeInterval = (animated ? 0.3 : 0.0)
        
        //  animate the tabBar
        if frame != nil {
            UIView.animate(withDuration: duration) {
                self.tabBarController?.tabBar.frame = frame!.offsetBy(dx: 0, dy: offsetY!)
                return
            }
        }
    }
    
    var isTabBarVisible: Bool {
        return (self.tabBarController?.tabBar.frame.origin.y ?? 0) < self.view.frame.maxY
    }
    
    func setPlayerToNormalScreen() {
        self.hidePlayerControls(true)
        UIApplication.shared.setStatusBarHidden(false, with: .slide)
       // self.context?.navigationController?.setNavigationBarHidden(false, animated: true)
        setTabBarVisible(visible: true, animated: true)
        UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions(), animations: {
            self.player?.transform = CGAffineTransform(rotationAngle: 0)
            self.backControlsContainerView.transform = CGAffineTransform(rotationAngle: 0)
            self.controlsContainerView.transform = CGAffineTransform(rotationAngle: 0)
            
            self.player?.frame = CGRect(x: self.playerViewFrame!.origin.x, y: self.playerViewFrame!.origin.y, width: self.playerViewFrame!.size.width, height: self.playerViewFrame!.size.height)
            
            self.backControlsContainerView.frame = CGRect(x: self.playerViewFrame!.origin.x, y: self.playerViewFrame!.origin.y, width: self.playerViewFrame!.size.width, height: self.playerViewFrame!.size.height)
            
            self.controlsContainerView.frame = CGRect(x: self.playerViewFrame!.origin.x, y: self.playerViewFrame!.origin.y, width: self.playerViewFrame!.size.width, height: self.playerViewFrame!.size.height)
        }, completion: { finished in
            self.isFullscreen = false
            self.rotateControls()
            self.showPlayerControls()
            //self.minimizeButton.isHidden = false
            //self.fullscreen.setImage(UIImage(named: "fullscreen"), for: UIControlState())
        })
    }
    
    //MARK: -- Dragging Animations and Panning functions
    
    func panAction(_ recognizer: UIPanGestureRecognizer) {
        if (!isFullscreen) {
            let yPlayerLocation = recognizer.location(in: self.view?.window).y
            
            switch recognizer.state {
            case .began:
                onRecognizerStateBegan(yPlayerLocation, recognizer: recognizer)
                break
            case .changed:
                onRecognizerStateChanged(yPlayerLocation, recognizer: recognizer)
                break
            default:
                onRecognizerStateEnded(yPlayerLocation, recognizer: recognizer)
            }
        }
    }
    
    func onRecognizerStateBegan(_ yPlayerLocation: CGFloat, recognizer: UIPanGestureRecognizer) {
        collectionViewContainer.backgroundColor = UIColor.white
        hidePlayerControls(true)
        panGestureDirection = UIPanGestureRecognizerDirection.undefined
        
        let velocity = recognizer.velocity(in: recognizer.view)
        detectPanDirection(velocity)
        
        touchPositionStartY = recognizer.location(in: self.player).y
        touchPositionStartX = recognizer.location(in: self.player).x
        
    }
    
    func onRecognizerStateChanged(_ yPlayerLocation: CGFloat, recognizer: UIPanGestureRecognizer) {
        if (panGestureDirection == UIPanGestureRecognizerDirection.down ||
            panGestureDirection == UIPanGestureRecognizerDirection.up) {
            let trueOffset = yPlayerLocation - touchPositionStartY!
            let xOffset = trueOffset * 0.35
            adjustViewOnVerticalPan(yPlayerLocation, trueOffset: trueOffset, xOffset: xOffset, recognizer: recognizer)
            
        } else {
            adjustViewOnHorizontalPan(recognizer)
        }
    }
    
    func onRecognizerStateEnded(_ yPlayerLocation: CGFloat, recognizer: UIPanGestureRecognizer) {
        if (panGestureDirection == UIPanGestureRecognizerDirection.down ||
            panGestureDirection == UIPanGestureRecognizerDirection.up) {
            if (self.view.frame.origin.y < 0) {
                expandViews()
                recognizer.setTranslation(CGPoint.zero, in: recognizer.view)
                return
                
            } else {
                if (self.view.frame.origin.y > (initialFirstViewFrame!.size.height / 2)) {
                    minimizeViews()
                    recognizer.setTranslation(CGPoint.zero, in: recognizer.view)
                    return
                } else {
                    expandViews()
                    recognizer.setTranslation(CGPoint.zero, in: recognizer.view)
                }
            }
            
        } else if (panGestureDirection == UIPanGestureRecognizerDirection.left) {
            if (collectionViewContainer.alpha <= 0) {
                if (self.view?.frame.origin.x < 0) {
                    removeViews()
                    
                } else {
                    animateViewToRightOrLeft(recognizer)
                    
                }
            }
            
        } else {
            if (collectionViewContainer.alpha <= 0) {
                if (self.view?.frame.origin.x > initialFirstViewFrame!.size.width - 50) {
                    removeViews()
                    
                } else {
                    animateViewToRightOrLeft(recognizer)
                    
                }
                
            }
            
        }
    }
    
    func detectPanDirection(_ velocity: CGPoint) {
        //minimizeButton.isHidden = true
        let isVerticalGesture = fabs(velocity.y) > fabs(velocity.x)
        
        if (isVerticalGesture) {
            
            if (velocity.y > 0) {
                panGestureDirection = UIPanGestureRecognizerDirection.down
            } else {
                panGestureDirection = UIPanGestureRecognizerDirection.up
            }
            
        } else {
            
            if (velocity.x > 0) {
                panGestureDirection = UIPanGestureRecognizerDirection.right
            } else {
                panGestureDirection = UIPanGestureRecognizerDirection.left
            }
        }
    }
    
    func adjustViewOnVerticalPan(_ yPlayerLocation: CGFloat, trueOffset: CGFloat, xOffset: CGFloat, recognizer: UIPanGestureRecognizer) {
        
        if (Float(trueOffset) >= (restrictTrueOffset! + 60) ||
            Float(xOffset) >= (restrictOffset! + 60)) {
            
            let trueOffset = initialFirstViewFrame!.size.height - 100
            let xOffset = initialFirstViewFrame!.size.width - 160
            
            //Use this offset to adjust the position of your view accordingly
            viewMinimizedFrame?.origin.y = trueOffset
            viewMinimizedFrame?.origin.x = xOffset - 6
            viewMinimizedFrame?.size.width = initialFirstViewFrame!.size.width
            
            playerViewMinimizedFrame!.size.width = self.view.bounds.size.width - xOffset
            playerViewMinimizedFrame!.size.height = 200 - xOffset * 0.5
            
            UIView.animate(withDuration: 0.05, delay: 0.0, options: UIViewAnimationOptions(), animations: {
                self.player?.frame = self.playerViewMinimizedFrame!
                self.view.frame = self.viewMinimizedFrame!
                self.collectionViewContainer.alpha = 0.0
            }, completion: { finished in
                self.isMinimized = true
            })
            recognizer.setTranslation(CGPoint.zero, in: recognizer.view)
            
        } else {
            //Use this offset to adjust the position of your view accordingly
            viewMinimizedFrame?.origin.y = trueOffset
            viewMinimizedFrame?.origin.x = xOffset - 6
            viewMinimizedFrame?.size.width = initialFirstViewFrame!.size.width
            print(viewMinimizedFrame)
            print("------------------")
            playerViewMinimizedFrame!.size.width = self.view.bounds.size.width - xOffset
            if UIDevice.current.userInterfaceIdiom == .pad {
                playerViewMinimizedFrame!.size.height = (self.view.bounds.size.width / (16/9)) - xOffset * 0.5
            } else {
                playerViewMinimizedFrame!.size.height = 200 - xOffset * 0.5
            }
            
            let restrictY = initialFirstViewFrame!.size.height - player!.frame.size.height - 10
            
            if (self.collectionView.frame.origin.y < restrictY && self.collectionView.frame.origin.y > 0) {
                UIView.animate(withDuration: 0.09, delay: 0.0, options: UIViewAnimationOptions(), animations: {
                    self.player?.frame = self.playerViewMinimizedFrame!
                    print(self.viewMinimizedFrame)
                    self.view.frame = self.viewMinimizedFrame!
                    
                    let percentage = (yPlayerLocation + 200) / self.initialFirstViewFrame!.size.height
                    self.collectionViewContainer.alpha = 1.0 - percentage
                    self.transparentView!.alpha = 1.0 - percentage
                    
                }, completion: { finished in
                    if (self.panGestureDirection == UIPanGestureRecognizerDirection.down) {
                        self.onView?.bringSubview(toFront: self.view)
                    }
                })
                
            } else if (viewMinimizedFrame!.origin.y < restrictY && viewMinimizedFrame!.origin.y > 0) {
                UIView.animate(withDuration: 0.09, delay: 0.0, options: UIViewAnimationOptions(), animations: {
                    self.player?.frame = self.playerViewMinimizedFrame!
                    self.view.frame = self.viewMinimizedFrame!
                    
                }, completion: nil)
            }
            
            recognizer.setTranslation(CGPoint.zero, in: recognizer.view)
        }
    }
    
    func adjustViewOnHorizontalPan(_ recognizer: UIPanGestureRecognizer) {
        let x = self.view.frame.origin.x
        
        if (panGestureDirection == UIPanGestureRecognizerDirection.left ||
            panGestureDirection == UIPanGestureRecognizerDirection.right) {
            if (self.collectionViewContainer.alpha <= 0) {
                let velocity = recognizer.velocity(in: recognizer.view)
                
                let isVerticalGesture = fabs(velocity.y) > fabs(velocity.x)
                
                let translation = recognizer.translation(in: self.view)
                self.view?.center = CGPoint(x: self.view!.center.x + translation.x, y: self.view!.center.y)
                
                if (!isVerticalGesture) {
                    recognizer.view?.alpha = detectHorizontalPanRecognizerViewAlpha(x, velocity: velocity, recognizer: recognizer)
                }
                recognizer.setTranslation(CGPoint.zero, in: recognizer.view)
            }
            
        }
    }
    
    func detectHorizontalPanRecognizerViewAlpha(_ x: CGFloat, velocity: CGPoint, recognizer: UIPanGestureRecognizer) -> CGFloat {
        let percentage = x / self.initialFirstViewFrame!.size.width
        
        if (panGestureDirection == UIPanGestureRecognizerDirection.left) {
            return percentage
            
        } else {
            if (velocity.x > 0) {
                return 1.0 - percentage
            } else {
                return percentage
            }
        }
    }
    
    func animateViewToRightOrLeft(_ recognizer: UIPanGestureRecognizer) {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions(), animations: {
            self.view.frame = self.viewMinimizedFrame!
            self.player!.frame = self.playerViewFrame!
            self.player?.frame = CGRect(x: self.player!.frame.origin.x, y: self.player!.frame.origin.x, width: self.playerViewMinimizedFrame!.size.width, height: self.playerViewMinimizedFrame!.size.height)
            self.collectionViewContainer.alpha = 0.0
            self.player?.alpha = 1.0
            
        }, completion: nil)
        
        recognizer.setTranslation(CGPoint.zero, in: recognizer.view)
        
    }
    
    
    //MARK: -- Global View States
    
    func minimizeViews() {
        collectionViewContainer.backgroundColor = UIColor.white
        //minimizeButton.isHidden = true
        hidePlayerControls(true)
        let trueOffset = initialFirstViewFrame!.size.height - 100
        let xOffset = initialFirstViewFrame!.size.width - 160
        
        viewMinimizedFrame!.origin.y = trueOffset - 46
        viewMinimizedFrame!.origin.x = xOffset - 6
        viewMinimizedFrame!.size.width = initialFirstViewFrame!.size.width
        
        playerViewMinimizedFrame!.size.width = self.view.bounds.size.width - xOffset
        playerViewMinimizedFrame!.size.height = playerViewMinimizedFrame!.size.width / (16/9)
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(TwitVideoPlayer.panAction(_:)))
        player?.addGestureRecognizer(gesture)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
            print(self.playerViewMinimizedFrame)
            print(self.viewMinimizedFrame)
            self.player?.frame = self.playerViewMinimizedFrame!
            self.view.frame = self.viewMinimizedFrame!
            
            self.player?.layer.borderWidth = 1
            self.player?.layer.borderColor = UIColor(red:255/255.0, green:255/255.0, blue:255/255.0, alpha: 0.5).cgColor
            
            self.collectionViewContainer.alpha = 0.0
            self.transparentView?.alpha = 0.0
        }, completion: { finished in
            self.isMinimized = true
            if let playerGesture = self.playerTapGesture {
                self.player?.removeGestureRecognizer(playerGesture)
            }
            self.playerTapGesture = nil
            self.playerTapGesture = UITapGestureRecognizer(target: self, action: #selector(TwitVideoPlayer.expandViews))
            self.player?.addGestureRecognizer(self.playerTapGesture!)
            
            self.view.frame.size.height = (self.player?.frame.height)!
            
            UIApplication.shared.setStatusBarHidden(false, with: .fade)
        })
    }

    
    func expandViews() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
//            let height:CGFloat = (view.frame.height - ((view.frame.width * 9/16) + (tabBarHeight! * 2) + navigationBarHeight! + UIApplication.shared.statusBarFrame.height))
            self.player?.frame = self.playerViewFrame!
            self.view.frame = self.initialFirstViewFrame!
            self.player?.alpha = 1.0
            self.collectionView.alpha = 1.0
            self.collectionViewContainer.alpha = 1.0
//            self.collectionViewContainer.frame = CGRect(x: self.collectionViewContainer.frame.origin.x, y: self.collectionViewContainer.frame.origin.y, width: self.collectionViewContainer.frame.width, height: (self.initialFirstViewFrame!.height - self.playerViewFrame!.height))
//            self.collectionView.frame = CGRect(x: self.collectionViewContainer.frame.origin.x, y: self.collectionViewContainer.frame.origin.y, width: self.collectionViewContainer.frame.width, height: (self.initialFirstViewFrame!.height - self.playerViewFrame!.height))
            self.transparentView?.alpha = 1.0
            self.player?.layer.borderWidth = 0
        }, completion: { finished in
            self.isMinimized = false
            //self.minimizeButton.isHidden = false
            if self.playerTapGesture != nil {
                self.player?.removeGestureRecognizer(self.playerTapGesture!)
            }
            self.playerTapGesture = nil
            self.playerTapGesture = UITapGestureRecognizer(target: self, action: #selector(TwitVideoPlayer.showPlayerControls))
            self.player?.addGestureRecognizer(self.playerTapGesture!)
            //self.collectionView.backgroundColor = UIColor.black
            self.showPlayerControls()
        })
    }
    
    func viewControllerView(viewFrame:CGRect) {
        self.player?.frame = self.playerViewFrame!
        self.view.frame = viewFrame
        self.player?.alpha = 1.0
        self.collectionView.alpha = 1.0
        self.collectionViewContainer.alpha = 1.0
        self.player?.layer.borderWidth = 0
        self.isMinimized = false
        if self.playerTapGesture != nil {
            self.player?.removeGestureRecognizer(self.playerTapGesture!)
        }
        self.playerTapGesture = nil
        self.playerTapGesture = UITapGestureRecognizer(target: self, action: #selector(TwitVideoPlayer.showPlayerControls))
        self.player?.addGestureRecognizer(self.playerTapGesture!)
        self.showPlayerControls()
    }
    
    
    
    func finishViewAnimated(_ animated: Bool) {
        if (animated) {
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions(), animations: {
                self.view.frame = CGRect(x: 0.0, y: self.view!.frame.origin.y, width: self.view!.frame.size.width, height: self.view!.frame.size.height)
                self.view.alpha = 0.0
                
            }, completion: { finished in
                self.removeViews()
            })
        } else {
            removeViews()
        }
    }
    
    func removeViews() {
        self.view.removeFromSuperview()
        self.player?.resetPlayer()
        self.player?.removeFromSuperview()
        self.collectionView.removeFromSuperview()
        self.collectionViewContainer.removeFromSuperview()
        self.transparentView?.removeFromSuperview()
        self.controlsContainerView.removeFromSuperview()
        self.backControlsContainerView.removeFromSuperview()
        twitVideoVC = nil
    }


}
