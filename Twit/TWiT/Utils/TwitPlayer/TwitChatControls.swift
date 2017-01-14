//
//  TwitChatControls.swift
//  TWiT
//
//  Created by Corey Baines on 31/12/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import UIKit

extension TwitVideoPlayer {
    
    //MARK: -- Chat Bar Setup
    func chatBarSetup() {
        let rightY = ((tabBarHeight! / 2) - ((tabBarHeight! - 15) / 2))
        
        chatShareButton.frame = CGRect(x: 10, y: rightY, width: 50, height: (tabBarHeight! - 15))
        
        chatSendButton.frame = CGRect(x: (view.frame.width - 60), y: rightY, width: 50, height: (tabBarHeight! - 15))
        chatSendButton.isHidden = true
        
        chatLikeButton.frame = CGRect(x: (70 + (view.frame.width - 150) + 10), y: rightY, width: (tabBarHeight! - 15), height: (tabBarHeight! - 15))
        chatLoveButton.frame = CGRect(x: (70 + (view.frame.width - 150) + 20 + (tabBarHeight! - 15)), y: rightY, width: (tabBarHeight! - 15), height: (tabBarHeight! - 15))
        chatDislikeButton.frame = CGRect(x: (70 + (view.frame.width - 150) + 30 + (tabBarHeight! - 15) + (tabBarHeight! - 15)), y: rightY, width: (tabBarHeight! - 15), height: (tabBarHeight! - 15))
        chatLolButton.frame = CGRect(x: (70 + (view.frame.width - 150) + 40 + (tabBarHeight! - 15) + (tabBarHeight! - 15) + (tabBarHeight! - 15)), y: rightY, width: (tabBarHeight! - 15), height: (tabBarHeight! - 15))
        chatSupriseButton.frame = CGRect(x: (70 + (view.frame.width - 150) + 40 + (tabBarHeight! - 15) + (tabBarHeight! - 15) + (tabBarHeight! - 15)), y: rightY, width: (tabBarHeight! - 15), height: (tabBarHeight! - 15))
        chatSadButton.frame = CGRect(x: (70 + (view.frame.width - 150) + 50 + (tabBarHeight! - 15) + (tabBarHeight! - 15) + (tabBarHeight! - 15) + (tabBarHeight! - 15)), y: rightY, width: (tabBarHeight! - 15), height: (tabBarHeight! - 15))
        
        
        chatEntryTab.addSubview(chatTextBar)
        chatEntryTab.addSubview(chatShareButton)
        chatEntryTab.addSubview(chatLikeButton)
        chatEntryTab.addSubview(chatLoveButton)
        chatEntryTab.addSubview(chatDislikeButton)
        chatEntryTab.addSubview(chatSupriseButton)
        chatEntryTab.addSubview(chatSadButton)
        chatEntryTab.addSubview(chatSendButton)
        
        
        chatSendButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TwitVideoPlayer.sendButtonPressed)))

    }
    
    //MARK: -- Chat Bar Animations
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
            chatTextBar.frame = CGRect(x: 10, y: ((tabBarHeight! / 2) - ((tabBarHeight! - 15) / 2)), width: (view.frame.width - 80), height: (tabBarHeight! - 15))
            chatEntryTab.contentSize = CGSize(width: view.frame.width, height: tabBarHeight!)
            if UserDefaults.standard.object(forKey: "username") == nil {
                chatTextBar.text = chatUsernameBar.text
                chatTextBar.attributedPlaceholder = NSAttributedString(string: "Choose your username", attributes: [NSForegroundColorAttributeName: UIColor.white.withAlphaComponent(0.5)])
                
                chatSendButton.titleLabel?.text = "Join"
            } else {
                chatTextBar.placeholder = "Tap to enter text..."
                chatSendButton.titleLabel?.text = "Send"
            }
            
        } else {
            let farRight = (70 + (view.frame.width - 150) + 50 + (tabBarHeight! - 15) + (tabBarHeight! - 15) + (tabBarHeight! - 15))
            chatSadButton.isHidden = false
            chatSupriseButton.isHidden = false
            chatDislikeButton.isHidden = false
            chatLoveButton.isHidden = false
            chatLikeButton.isHidden = false
            chatShareButton.isHidden = false
            chatSendButton.isHidden = true
            chatTextBar.frame = CGRect(x: 70, y: ((tabBarHeight! / 2) - ((tabBarHeight! - 15) / 2)), width: (view.frame.width - 150), height: (tabBarHeight! - 15))
            chatEntryTab.contentSize = CGSize(width: view.frame.width + farRight, height: tabBarHeight!)
            if UserDefaults.standard.object(forKey: "username") == nil {
                chatEntryTab.isHidden = true
                chatUsernameBar.text = chatTextBar.text
            }
        }
    }
    
    func sendButtonPressed() {
        if UserDefaults.standard.object(forKey: "username") == nil {
            joinIRC()
        } else {
            let whitespaceSet = NSCharacterSet.whitespaces
            if !(chatTextBar.text?.trimmingCharacters(in: whitespaceSet).isEmpty)! {
                print(chatTextBar.text!)
                IRCService.shared.irc.sendMessageToChannel(chatTextBar.text!, channel: "#twitlive")
                let username = UserDefaults.standard.object(forKey: "username") as! String
                let message = TwitLiveMessage(user: username, message: chatTextBar.text!)
                IRCService.shared.messages.append(message)
                self.chatTextBar.text = ""
                self.chatTextBar.resignFirstResponder()
                collectionView.reloadData()
            }
        }
    }
    
}
