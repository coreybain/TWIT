//
//  VideoPlayer.swift
//  TWiT
//
//  Created by Corey Baines on 31/12/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit
import AVKit

class TwitVideoPlayer: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //MARK: -- UI Elements
    var player: TwitPlayerView?
    
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    let backControlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(red: 22/255, green: 22/255, blue: 22/255, alpha: 1.0)
        return cv
    }()
    
    let collectionViewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 22/255, green: 22/255, blue: 22/255, alpha: 1.0)
        return view
    }()
    
    let chatEntryTab: UIScrollView = {
        let layout = UIScrollView()
        layout.backgroundColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1.0)
        layout.isScrollEnabled = true
        layout.addBorder(edge: .top, color: UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5), thickness: 10.0)
        layout.showsVerticalScrollIndicator = false
        layout.showsHorizontalScrollIndicator = false
        return layout
    }()
    
    let chatTextBar: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor.clear
        //tf.placeholder = "Tap to enter text..."
        tf.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        tf.attributedPlaceholder = NSAttributedString(string: "Tap to enter text...", attributes: [NSForegroundColorAttributeName: UIColor.white])
        return tf
    }()
    
    let chatShareButton: UIButton = {
        let button = UIButton()
        button.setTitle("Share", for: .normal)
        return button
    }()
    
    let chatSendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Send", for: .normal)
        return button
    }()
    
    let chatLikeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "likeButton"), for: .normal)
        return button
    }()
    
    let chatLoveButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "likeButton"), for: .normal)
        return button
    }()
    
    let chatDislikeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "likeButton"), for: .normal)
        return button
    }()
    
    let chatLolButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "likeButton"), for: .normal)
        return button
    }()
    
    let chatSupriseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "likeButton"), for: .normal)
        return button
    }()
    
    let chatSadButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "likeButton"), for: .normal)
        return button
    }()
    
    let chatIconView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "chatIcon")
        return image
    }()
    
    var playPauseButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "pause"), for: .normal)
        return button
    }()
    
    var airPlayButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "settings"), for: .normal)
        return button
    }()
    
    var scheduleButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "calendar"), for: .normal)
        return button
    }()
    
    var progressIndicatorView:UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        return indicator
    }()
    
    var slider:TwitVideoSlider = {
        let slider = TwitVideoSlider()
        return slider
    }()
    
    var progress:TwitVideoSliderProgress = {
        let progress = TwitVideoSliderProgress()
        return progress
    }()
    
    var entireTime:UILabel = {
        let entireTime = UILabel()
        entireTime.text = "-00:00"
        entireTime.font = UIFont.systemFont(ofSize: 9, weight: UIFontWeightRegular)
        entireTime.textColor = UIColor.white
        return entireTime
    }()
    
    var currentTime:UILabel = {
        let currentTime = UILabel()
        currentTime.text = "00:00"
        currentTime.font = UIFont.systemFont(ofSize: 9, weight: UIFontWeightRegular)
        currentTime.textColor = UIColor.white
        return currentTime
    }()
    
    let chatUsernameBar: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1.0)
        //tf.placeholder = "Choose your username"
        tf.attributedPlaceholder = NSAttributedString(string: "Choose your username", attributes: [NSForegroundColorAttributeName: UIColor.white.withAlphaComponent(0.5)])
        tf.textColor = UIColor.white
        return tf
    }()
    
    let chatJoinButton: UIButton = {
        let button = UIButton()
        button.setTitle("Join", for: .normal)
        button.backgroundColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1.0)
        button.isUserInteractionEnabled = true
        
        return button
    }()
    
    
    //MARK: -- Variables
    var isRotated:Bool = false
    var isLive:Bool = false
    var isLiveTab:Bool = false
    var activeLiveStream:Bool = false
    var tableCellNibName:String = "VideoCell"
    var isOpen: Bool = false
    let guideLuncher = GuideLauncher()
    var irc: GMIRCClient!
    var cellSize: [CGSize] = []
    var twitPlaying:Bool?
    var scheduleShowing:Bool = false
    var isFullscreen: Bool = false
    var context:CGFloat?
    
    var isPlaying: Bool = false
    var dragginSlider: Bool = false
    var isMinimized: Bool = false
    var hideTimer: Timer?
    var currentUrlIndex: Int = 0 {
        didSet {
            if (player != nil) {
                // Finish playing all items
                if (currentUrlIndex >= (urls?.count)!) {
                    // Go back to first tableView item to loop list
                    currentUrlIndex = 0
                    //selectFirstRowOfTable()
                } else {
                    playURLIndex(currentUrlIndex)
                }
            }
        }
    }
    var urls: [URL]? {
        didSet {
            if (player != nil) {
                currentUrlIndex = 0
            }
        }
    }
    
    var navigationBarHeight:CGFloat?
    var tabBarHeight:CGFloat?
    let videoHeight = UIApplication.shared.statusBarFrame.width * 9/16
    var statusBarHeight:CGFloat?
    
    //MARK: -- Initial fame params
    var playerControlsFrame: CGRect?
    var playerViewFrame: CGRect?
    var collectionViewContainerFrame: CGRect?
    var playerViewMinimizedFrame: CGRect?
    var minimizedPlayerFrame: CGRect?
    var initialFirstViewFrame: CGRect?
    var viewMinimizedFrame: CGRect?
    var restrictOffset: Float?
    var restrictTrueOffset: Float?
    var restictYaxis: Float?
    var transparentView: UIView?
    var onView: UIView?
    var playerTapGesture: UITapGestureRecognizer?
    var panGestureDirection: UIPanGestureRecognizerDirection?
    var touchPositionStartY: CGFloat?
    var touchPositionStartX: CGFloat?
    
    //Size of items
    let playButtonSize:CGFloat = 50
    let airPlayButtonSize:CGFloat = 25
    let scheduleButtonSize:CGFloat = 25
    
    //MARK: -- CollectionView Cell Info
    let liveCellID = "liveCell"
    let videoCellID = "videoCell"
    
    //MARK: -- Pan Guesture Recognizers
    enum UIPanGestureRecognizerDirection {
        case undefined
        case up
        case down
        case left
        case right
    }
    
    //MARK: -- Twit Player Lifecycle
    
    //MARK: --- View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setupSystemNotifications()
        initViews()
        player!.delegate = self
        print(view.frame.width)
        print(view.frame.height)
        if UserDefaults.standard.bool(forKey: "isLiveTab") {
            print(view.frame.origin.x)
            self.initialFirstViewFrame = view.frame
            self.statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        initPlayerWithURLs()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        calculateFrames()
    }
    
    func setupSystemNotifications() {
        NotificationCenter.default.addObserver(self, selector:#selector(rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TwitVideoPlayer.keyboardWillAppear), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TwitVideoPlayer.keyboardWillDisappear), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        if (isLive || UserDefaults.standard.bool(forKey: "isLiveTab")) && !isMinimized {
            NotificationCenter.default.addObserver(self, selector: #selector(TwitVideoPlayer.receivedIRCMessage), name: Notification.Name("NewTwitMessage"), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(TwitVideoPlayer.reloadCollectionView), name: Notification.Name("reloadCollectionView"), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(TwitVideoPlayer.IRCLoginSuccess(_:)), name: Notification.Name("isLoggedIn"), object: nil)
        }
    }
    
    func initPlayerWithURLs() {
        if isMinimized && !isLive {
            expandViews()
        }
        playURLIndex(currentUrlIndex)
    }
    
    func initViews() {
        
        //MARK: -- Init Views and setup Collection.
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //Calculate Heights and frames
        var offsetHeight:CGFloat = 0
        var containerHeight:CGFloat = view.frame.height
        var collectionFrameTab:CGRect = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        var collectionFramePopup:CGRect = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        
        //(view.frame.height - (offsetHeight + height + (tabBarController?.tabBar.frame.size.height)!) - (tabBarController?.tabBar.frame.size.height)!)
        
        if UserDefaults.standard.bool(forKey: "isLiveTab") {
            view.backgroundColor = UIColor(red: 22/255, green: 22/255, blue: 22/255, alpha: 1.0)
            collectionViewContainer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: (view.frame.height - tabBarHeight! - navigationBarHeight! - UIApplication.shared.statusBarFrame.height))
            collectionView.register(LiveChatCell.self, forCellWithReuseIdentifier: liveCellID)
        } else if isLive {
            self.view.backgroundColor = UIColor.clear
            collectionViewContainer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
            collectionView.register(LiveChatCell.self, forCellWithReuseIdentifier: liveCellID)
            self.view.alpha = 0.0
        } else {
            collectionView.register(LiveChatCell.self, forCellWithReuseIdentifier: videoCellID)
            collectionViewContainer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
            self.view.backgroundColor = UIColor.clear
            self.view.alpha = 0.0
        }
        
        view.addSubview(collectionViewContainer)
        
        controlsContainerView.alpha = 0.0
        backControlsContainerView.alpha = 0.0
        
        if UserDefaults.standard.bool(forKey: "isLiveTab") {
            setupVideoPlayer(videoFrameInit: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width * 9/16))
        } else {
            setupVideoPlayer(videoFrameInit: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width * 9/16))
            let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(TwitVideoPlayer.panAction(_:)))
            player?.addGestureRecognizer(gesture)
            
        }
        
        if let username = UserDefaults.standard.object(forKey: "username") {
            if UserDefaults.standard.bool(forKey: "isLiveTab") {
                setupLiveChatView(collectionFrameInit: collectionFrameTab)
            } else {
                setupLiveChatView(collectionFrameInit: collectionFramePopup)
            }
            if !IRCService.shared.connected {
                //IRCService.shared.setupIRC(username as! String)
            }
        } else {
            if UserDefaults.standard.bool(forKey: "isLiveTab") {
                setupLiveChatView(collectionFrameInit: collectionFrameTab)
                setupChatUsernameView()
            } else {
                setupLiveChatView(collectionFrameInit: collectionFramePopup)
            }
        }
        
    }
    
    func calculateFrames() {
        
        if !UserDefaults.standard.bool(forKey: "isLiveTab") {
            self.initialFirstViewFrame = self.view.frame
        }
        
        self.playerViewFrame = self.player?.frame
        self.collectionViewContainerFrame = self.activityIndicatorView.frame
        self.playerViewMinimizedFrame = self.player?.frame
        self.viewMinimizedFrame = self.activityIndicatorView.frame
        self.playerControlsFrame = self.controlsContainerView.frame
        
        
        player?.translatesAutoresizingMaskIntoConstraints = true
        collectionViewContainer.translatesAutoresizingMaskIntoConstraints = true
        controlsContainerView.translatesAutoresizingMaskIntoConstraints = true
        backControlsContainerView.translatesAutoresizingMaskIntoConstraints = true
//        collectionViewContainer.frame = self.initialFirstViewFrame!
        self.controlsContainerView.frame = self.playerControlsFrame!
        
        transparentView = UIView.init(frame: initialFirstViewFrame!)
        transparentView?.backgroundColor = UIColor.black
        transparentView?.alpha = 0.0
        onView?.addSubview(transparentView!)
        
        self.restrictOffset = Float(self.initialFirstViewFrame!.size.width) - 200
        self.restrictTrueOffset = Float(self.initialFirstViewFrame!.size.height) - 180
        self.restictYaxis = Float(self.initialFirstViewFrame!.size.height - (player?.frame.size.height)!)

    }
}

//MARK: - Player Setup

extension TwitVideoPlayer {
    
    //MARK: -- Setup Video Player
    
    func setupVideoPlayer(videoFrameInit: CGRect) {
        
        //MARK: --- Initiate video player
        
        player = TwitPlayerView()
        if player != nil {
            view.addSubview(player!)
            player?.layer.backgroundColor = UIColor.black.cgColor
            player?.frame = videoFrameInit
            view.addSubview(backControlsContainerView)
            view.addSubview(controlsContainerView)
            backControlsContainerView.frame = videoFrameInit
            controlsContainerView.frame = videoFrameInit
            setupControlls()
            view.addSubview(progressIndicatorView)
            progressIndicatorView.frame = CGRect(x: (videoFrameInit.width/2) - (25/2), y: ((videoFrameInit.height/2) - (25/2)) + (videoFrameInit.origin.y), width: 25, height: 25)
        }
//        player?.allowsExternalPlayback = true
//        player?.usesExternalPlaybackWhileExternalScreenIsActive = true
//        let playerLayer = AVPlayerLayer(player: player)
//        playerLayer.backgroundColor = UIColor.black.cgColor
//        view.layer.addSublayer(playerLayer)
        
    }
    
    //MARK: -- Setup Live Chat View
    func setupLiveChatView(collectionFrameInit: CGRect) {
       
        //MARK: --- Initial live Chat View
        
        
        //Live Chat frame
        
        
        let y:CGFloat = ((view.frame.width * 9/16))
        let height:CGFloat = (view.frame.height - ((view.frame.width * 9/16) + (tabBarHeight! * 2) + navigationBarHeight! + UIApplication.shared.statusBarFrame.height))
        
        collectionView.frame = CGRect(x: 0, y: (view.frame.width * 9/16), width: view.frame.width, height: height)
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 14, 0)
        chatEntryTab.frame = CGRect(x: 0, y: ((view.frame.width * 9/16) + height), width: view.frame.width, height: tabBarHeight!)
        
        collectionViewContainer.addSubview(collectionView)
        collectionViewContainer.addSubview(chatEntryTab)
        chatBarSetup()
        chatBarType(typing: false)
        
    }
    
    func setupChatUsernameView() {
        
        chatIconView.frame = CGRect(x: (view.frame.width / 2) - 50, y: (view.frame.height / 2), width: 100, height: 100)
        chatUsernameBar.frame = CGRect(x: (view.frame.width / 2) - 125, y: (view.frame.height / 2) + 120, width: 200, height: 30)
        chatJoinButton.frame = CGRect(x: (view.frame.width / 2) + 85, y: (view.frame.height / 2) + 120, width: 50, height: 30)
        
        collectionViewContainer.addSubview(chatIconView)
        collectionViewContainer.addSubview(chatUsernameBar)
        collectionViewContainer.addSubview(chatJoinButton)
        
        chatJoinButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TwitVideoPlayer.joinIRC)))
        
        collectionView.isHidden = true
        chatEntryTab.isHidden = true
    }
    
    
    func rotated() {
        if(UIDeviceOrientationIsLandscape(UIDevice.current.orientation)) {
            print("landscape")
            if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft{
                setPlayerToFullscreen()
            } else {
                setPlayerToFullscreenLeft()
            }
            
        }
        
        if(UIDeviceOrientationIsPortrait(UIDevice.current.orientation)) {
            print("Portrait")
            setPlayerToNormalScreen()
        }
        
    }
    
    func keyboardWillAppear(notification: NSNotification){
        UserDefaults.standard.set(true, forKey: "keyboardVisable")
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let y = (((UIApplication.shared.statusBarFrame.height) + (view.frame.width * 9/16) + (self.collectionView.frame.height)) - (keyboardFrame.size.height - (tabBarHeight)!))
        
        chatBarType(typing: true)
        UIView.animate(withDuration: 0.8, animations: { () -> Void in
            self.chatEntryTab.frame = CGRect(x: 0,
                                             y: y,
                                             width: self.view.frame.height,
                                             height: (self.tabBarHeight)!)
            //self.bottomConstraint.constant = keyboardFrame.size.height + 20
        })
    }
    
    func keyboardWillDisappear(notification: NSNotification){
        UserDefaults.standard.set(false, forKey: "keyboardVisable")
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let y = (((UIApplication.shared.statusBarFrame.height) + (view.frame.width * 9/16) + (self.collectionView.frame.height)))
        
        chatBarType(typing: false)
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.chatEntryTab.frame = CGRect(x: 0,
                                             y: y,
                                             width: self.view.frame.height,
                                             height: (self.tabBarHeight)!)
            //self.bottomConstraint.constant = keyboardFrame.size.height + 20
        })
    }

}
