//
//  LiveVC.swift
//  TWiT
//
//  Created by Corey Baines on 31/10/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation

class LiveVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //MARK: -- Variables:
    var player: AVPlayer?
    let guideLuncher = GuideLauncher()
    var irc: GMIRCClient!
    var messages: [TwitLiveMessage] = []
    var cellSize: [CGSize] = []
    fileprivate let liveCellID = "liveCell"
    
    //MARK: -- UI Elements
    
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
       // NotificationCenter.default.addObserver(self, selector:Selector("keyboardWillAppear:"), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
       // NotificationCenter.default.addObserver(self, selector:Selector("keyboardWillDisappear:"), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(LiveVC.keyboardWillAppear), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LiveVC.keyboardWillDisappear), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        navigationItem.title = "Live"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .black
        
        view.backgroundColor = UIColor(red: 22/255, green: 22/255, blue: 22/255, alpha: 1.0)
        
        collectionView.register(LiveChatCell.self, forCellWithReuseIdentifier: liveCellID)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        showLiveView()
        showChatView()
    }
    
    func showChatView() {
        
        if let username = UserDefaults.standard.object(forKey: "username") {
            setupChatView()
            let socket = GMSocket(host: "irc.twit.tv", port: 6667)
            irc = GMIRCClient(socket: socket)
            irc.delegate = self
            irc.register((username as! String), user: (username as! String), realName: (username as! String))
        } else {
            setupChatView()
            setupChatUsernameView()
        }
        
    }
    
    func keyboardWillAppear(notification: NSNotification){
        UserDefaults.standard.set(true, forKey: "keyboardVisable")
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let y = (((UIApplication.shared.statusBarFrame.height + (navigationController?.navigationBar.frame.size.height)!) + (view.frame.width * 9/16) + (self.collectionView.frame.height)) - (keyboardFrame.size.height - (tabBarController?.tabBar.frame.size.height)!))
        
        chatBarType(typing: true)
        UIView.animate(withDuration: 0.8, animations: { () -> Void in
            self.chatEntryTab.frame = CGRect(x: 0,
                                             y: y,
                                             width: self.view.frame.height,
                                             height: (self.tabBarController?.tabBar.frame.size.height)!)
            //self.bottomConstraint.constant = keyboardFrame.size.height + 20
        })
    }
    
    func keyboardWillDisappear(notification: NSNotification){
        UserDefaults.standard.set(false, forKey: "keyboardVisable")
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let y = (((UIApplication.shared.statusBarFrame.height + (navigationController?.navigationBar.frame.size.height)!) + (view.frame.width * 9/16) + (self.collectionView.frame.height)))
        
        chatBarType(typing: false)
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.chatEntryTab.frame = CGRect(x: 0,
                                             y: y,
                                             width: self.view.frame.height,
                                             height: (self.tabBarController?.tabBar.frame.size.height)!)
            //self.bottomConstraint.constant = keyboardFrame.size.height + 20
        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        player?.pause()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        player?.play()
    }
    
    func showLiveView() {
        let height = view.frame.width * 9/16
        let offsetHeight = UIApplication.shared.statusBarFrame.height + (navigationController?.navigationBar.frame.size.height)!
        let videoFrame = CGRect(x: 0, y: offsetHeight, width: view.frame.width, height: height)
        //let playerVideoView = playerView(frame: videoFrame)
        
        let tempUrl = URL(string: "http://twit.live-s.cdn.bitgravity.com/cdn-live/_definst_/twit/live/twit_demo.smil/playlist.m3u8")
        
        player = AVPlayer(url: tempUrl!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.backgroundColor = UIColor.blue.cgColor
        
        view.layer.addSublayer(playerLayer)
        playerLayer.frame = videoFrame
        
        player?.play()
        player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        
        controlsContainerView.frame = videoFrame
        
        view.addSubview(controlsContainerView)
        
        controlsContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LiveVC.touching)))
        
        controlsContainerView.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: controlsContainerView.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: controlsContainerView.centerYAnchor).isActive = true
        
        
    }
    
    
    func setupChatView() {
        
        let height = view.frame.width * 9/16
        let offsetHeight = UIApplication.shared.statusBarFrame.height + (navigationController?.navigationBar.frame.size.height)!
        let videoFrame = CGRect(x: 0, y: offsetHeight, width: view.frame.width, height: height)
        
        collectionView.frame = CGRect(x: 0, y: (offsetHeight + height), width: view.frame.width, height: (view.frame.height - (offsetHeight + height + (tabBarController?.tabBar.frame.size.height)!) - (tabBarController?.tabBar.frame.size.height)!))
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 14, 0)
        chatEntryTab.frame = CGRect(x: 0, y: (offsetHeight + height + (collectionView.frame.height)), width: view.frame.height, height: (tabBarController?.tabBar.frame.size.height)!)
        
        
        chatBarType(typing: false)
        
        let rightY = (((tabBarController?.tabBar.frame.size.height)! / 2) - (((tabBarController?.tabBar.frame.size.height)! - 15) / 2))
        
        chatShareButton.frame = CGRect(x: 10, y: rightY, width: 50, height: ((tabBarController?.tabBar.frame.size.height)! - 15))
        
        chatSendButton.frame = CGRect(x: (view.frame.width - 60), y: rightY, width: 50, height: ((tabBarController?.tabBar.frame.size.height)! - 15))
        chatSendButton.isHidden = true
        
        chatLikeButton.frame = CGRect(x: (70 + (view.frame.width - 150) + 10), y: rightY, width: ((tabBarController?.tabBar.frame.size.height)! - 15), height: ((tabBarController?.tabBar.frame.size.height)! - 15))
        chatLoveButton.frame = CGRect(x: (70 + (view.frame.width - 150) + 20 + ((tabBarController?.tabBar.frame.size.height)! - 15)), y: rightY, width: ((tabBarController?.tabBar.frame.size.height)! - 15), height: ((tabBarController?.tabBar.frame.size.height)! - 15))
        chatDislikeButton.frame = CGRect(x: (70 + (view.frame.width - 150) + 30 + ((tabBarController?.tabBar.frame.size.height)! - 15) + ((tabBarController?.tabBar.frame.size.height)! - 15)), y: rightY, width: ((tabBarController?.tabBar.frame.size.height)! - 15), height: ((tabBarController?.tabBar.frame.size.height)! - 15))
        chatLolButton.frame = CGRect(x: (70 + (view.frame.width - 150) + 40 + ((tabBarController?.tabBar.frame.size.height)! - 15) + ((tabBarController?.tabBar.frame.size.height)! - 15) + ((tabBarController?.tabBar.frame.size.height)! - 15)), y: rightY, width: ((tabBarController?.tabBar.frame.size.height)! - 15), height: ((tabBarController?.tabBar.frame.size.height)! - 15))
        chatSupriseButton.frame = CGRect(x: (70 + (view.frame.width - 150) + 40 + ((tabBarController?.tabBar.frame.size.height)! - 15) + ((tabBarController?.tabBar.frame.size.height)! - 15) + ((tabBarController?.tabBar.frame.size.height)! - 15)), y: rightY, width: ((tabBarController?.tabBar.frame.size.height)! - 15), height: ((tabBarController?.tabBar.frame.size.height)! - 15))
        chatSadButton.frame = CGRect(x: (70 + (view.frame.width - 150) + 50 + ((tabBarController?.tabBar.frame.size.height)! - 15) + ((tabBarController?.tabBar.frame.size.height)! - 15) + ((tabBarController?.tabBar.frame.size.height)! - 15) + ((tabBarController?.tabBar.frame.size.height)! - 15)), y: rightY, width: ((tabBarController?.tabBar.frame.size.height)! - 15), height: ((tabBarController?.tabBar.frame.size.height)! - 15))
        
        
        view.addSubview(collectionView)
        view.addSubview(chatEntryTab)
        chatEntryTab.addSubview(chatTextBar)
        chatEntryTab.addSubview(chatShareButton)
        chatEntryTab.addSubview(chatLikeButton)
        chatEntryTab.addSubview(chatLoveButton)
        chatEntryTab.addSubview(chatDislikeButton)
        chatEntryTab.addSubview(chatSupriseButton)
        chatEntryTab.addSubview(chatSadButton)
        chatEntryTab.addSubview(chatSendButton)
        
        
        chatSendButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LiveVC.sendButtonPressed)))

        

    }
    
    func setupChatUsernameView() {
        
        chatIconView.frame = CGRect(x: (view.frame.width / 2) - 50, y: (view.frame.height / 2), width: 100, height: 100)
        chatUsernameBar.frame = CGRect(x: (view.frame.width / 2) - 125, y: (view.frame.height / 2) + 120, width: 200, height: 30)
        chatJoinButton.frame = CGRect(x: (view.frame.width / 2) + 85, y: (view.frame.height / 2) + 120, width: 50, height: 30)
        
        view.addSubview(chatIconView)
        view.addSubview(chatUsernameBar)
        view.addSubview(chatJoinButton)
        
        chatJoinButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LiveVC.joinIRC)))
        
        collectionView.isHidden = true
        chatEntryTab.isHidden = true
    }
    
    func touching() {
        print("hehehehe")
        if UserDefaults.standard.bool(forKey: "keyboardVisable") {
            dismissKeyboard()
        } else {
            let offsetHeight = UIApplication.shared.statusBarFrame.height + (navigationController?.navigationBar.frame.size.height)!
            let tabHeight = (tabBarController?.tabBar.frame.size.height)!
            guideLuncher.showGuide(offsetHeight: offsetHeight, videoHeight: view.frame.width * 9/16)
        }
        
    }
    
    func playerView(frame: CGRect) {
        
    }
    
    func chatBarType(typing:Bool) {
        if typing {
            view.bringSubview(toFront: chatEntryTab)
            chatSadButton.isHidden = true
            chatSupriseButton.isHidden = true
            chatDislikeButton.isHidden = true
            chatLoveButton.isHidden = true
            chatLikeButton.isHidden = true
            chatShareButton.isHidden = true
            chatSendButton.isHidden = false
            chatTextBar.isHidden = false
            chatEntryTab.isHidden = false
            chatTextBar.frame = CGRect(x: 10, y: (((tabBarController?.tabBar.frame.size.height)! / 2) - (((tabBarController?.tabBar.frame.size.height)! - 15) / 2)), width: (view.frame.width - 80), height: ((tabBarController?.tabBar.frame.size.height)! - 15))
            chatEntryTab.contentSize = CGSize(width: view.frame.width, height: (tabBarController?.tabBar.frame.size.height)!)
            if UserDefaults.standard.object(forKey: "username") == nil {
                chatTextBar.text = chatUsernameBar.text
                chatTextBar.attributedPlaceholder = NSAttributedString(string: "Choose your username", attributes: [NSForegroundColorAttributeName: UIColor.white.withAlphaComponent(0.5)])
                
                chatSendButton.titleLabel?.text = "Join"
            } else {
                chatTextBar.placeholder = "Tap to enter text..."
                chatSendButton.titleLabel?.text = "Send"
            }
            
        } else {
            let farRight = (70 + (view.frame.width - 150) + 50 + ((tabBarController?.tabBar.frame.size.height)! - 15) + ((tabBarController?.tabBar.frame.size.height)! - 15) + ((tabBarController?.tabBar.frame.size.height)! - 15))
            chatSadButton.isHidden = false
            chatSupriseButton.isHidden = false
            chatDislikeButton.isHidden = false
            chatLoveButton.isHidden = false
            chatLikeButton.isHidden = false
            chatShareButton.isHidden = false
            chatSendButton.isHidden = true
            chatTextBar.frame = CGRect(x: 70, y: (((tabBarController?.tabBar.frame.size.height)! / 2) - (((tabBarController?.tabBar.frame.size.height)! - 15) / 2)), width: (view.frame.width - 150), height: ((tabBarController?.tabBar.frame.size.height)! - 15))
            chatEntryTab.contentSize = CGSize(width: view.frame.width + farRight, height: (tabBarController?.tabBar.frame.size.height)!)
            if UserDefaults.standard.object(forKey: "username") == nil {
                chatEntryTab.isHidden = true
                chatUsernameBar.text = chatTextBar.text
            }
        }
    }
    
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        //this is when the player is ready and rendering frames
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = .clear
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: liveCellID, for: indexPath as IndexPath) as! LiveChatCell
        
        var userString = messages[indexPath.row].user
        var messageString = messages[indexPath.row].message
        if messageString.characters.first == ":" {
            cell.textLabel.text = String(messageString.characters.dropFirst())
        } else {
            cell.textLabel.text = messageString
        }
        if userString.characters.first == ":" {
            cell.userLabel.text = String(userString.characters.dropFirst())
        } else {
            cell.userLabel.text = userString
        }
        
        
        cell.timeLabel.text = " - monday at 11:54 AM"
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 50
        
        //we are just measuring height so we add a padding constant to give the label some room to breathe!
        var padding: CGFloat = 14
        
        //estimate each cell's height
        
        let text = messages[indexPath.item].message
        let string = text.characters.dropFirst()
        height = estimateFrameForText(text: String(string)).height + padding
        print(height)
        return CGSize(width: view.frame.width, height: (height + 8))
        
        //return CGSize(width: view.frame.width, height: 20)
    }
    
    private func estimateFrameForText(text: String) -> CGRect {
        //we make the height arbitrarily large so we don't undershoot height in calculation
        let height: CGFloat = 5000
        
        let size = CGSize(width: (view.frame.width - 32), height: height)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 14, weight: UIFontWeightRegular)]
        
        return NSString(string: text).boundingRect(with: size, options: options, attributes: attributes, context: nil)
    }
    
    func sendButtonPressed() {
        if UserDefaults.standard.object(forKey: "username") == nil {
            joinIRC()
        } else {
            let whitespaceSet = NSCharacterSet.whitespaces
            if !(chatTextBar.text?.trimmingCharacters(in: whitespaceSet).isEmpty)! {
                print(chatTextBar.text!)
                self.irc.sendMessageToChannel(chatTextBar.text!, channel: "#twitlive")
                let username = UserDefaults.standard.object(forKey: "username") as! String
                let message = TwitLiveMessage(user: username, message: chatTextBar.text!)
                messages.append(message)
                print(messages.count)
                self.chatTextBar.text = ""
                self.chatTextBar.resignFirstResponder()
                collectionView.reloadData()
            }
        }
    }
    
    func joinIRC() {
        let whitespaceSet = NSCharacterSet.whitespaces
        if !(chatUsernameBar.text?.trimmingCharacters(in: whitespaceSet).isEmpty)! {
            UserDefaults.standard.set(chatUsernameBar.text, forKey: "username")
            
            collectionView.isHidden = false
            chatEntryTab.isHidden = false
            chatIconView.isHidden = true
            chatJoinButton.isHidden = true
            chatUsernameBar.isHidden = true
            let socket = GMSocket(host: "irc.twit.tv", port: 6667)
            irc = GMIRCClient(socket: socket)
            irc.delegate = self
            irc.register(chatUsernameBar.text!, user: chatUsernameBar.text!, realName: chatUsernameBar.text!)
            collectionView.reloadData()
        } else {
            print("NEED TO HAVE SOMETHING IN THE TEXT BAR")
        }
    }
}


extension LiveVC: GMIRCClientDelegate {
    
    func didWelcome() {
        print("Received welcome message - ready to join a chat room")
        irc.join("#twitlive")
    }
    
    func didJoin(_ channel: String) {
        print("Joined chat room: \(channel)")
        
        //irc.sendMessageToNickName("Hi, I'm eugenio_ios. Nice to meet you!", nickName: "eugenio79")
    }
    
    func didReceivePrivateMessage(_ text: String, from: String) {
        print("\(from): \(text)")
        print(from)
        print(text)
        
        let message = TwitLiveMessage(user: from, message: text)
        messages.append(message)
        print(messages.count)
        collectionView.reloadData()
        let item = self.collectionView(collectionView, numberOfItemsInSection: 0) - 1
        let lastItemIndex = NSIndexPath(item: item, section: 0)
        collectionView.scrollToItem(at: lastItemIndex as IndexPath, at: UICollectionViewScrollPosition.top, animated: true)
    }
    
    func nickAlreadyExists() {
        irc.closeIRC()
        let alert = UIAlertController(title: "Username in use", message: "Choose and alternative username from the list below", preferredStyle: UIAlertControllerStyle.alert)
        let user1 = "\(UserDefaults.standard.object(forKey: "username")!)\(UInt64.random(lower: 1, upper: 7))\(UInt64.random(lower: 1, upper: 7))\(UInt64.random(lower: 1, upper: 7))"
        let user2 = "\(UserDefaults.standard.object(forKey: "username")!)\(UInt64.random(lower: 1, upper: 7))\(UInt64.random(lower: 1, upper: 7))"
        alert.addAction(UIAlertAction(title: user1, style: .default, handler: { Void in
            UserDefaults.standard.set(user1, forKey: "username")
            print(user1)
            let socket = GMSocket(host: "irc.twit.tv", port: 6667)
            self.irc = GMIRCClient(socket: socket)
            self.irc.delegate = self
            self.irc.register(user1, user: user1, realName: user1)
            self.collectionView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: user2, style: .default, handler: { Void in
            UserDefaults.standard.set(user2, forKey: "username")
            let socket = GMSocket(host: "irc.twit.tv", port: 6667)
            self.irc = GMIRCClient(socket: socket)
            self.irc.delegate = self
            self.irc.register(user2, user: user2, realName: user2)
            self.collectionView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Choose your own", style: .default, handler: { [unowned self] Void in
            self.chatUsernameBar.text = ""
            self.chatUsernameBar.placeholder = "Choose another username"
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
