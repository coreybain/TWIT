//
//  TwitChat.swift
//  TWiT
//
//  Created by Corey Baines on 31/12/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import UIKit

extension TwitVideoPlayer {
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return IRCService.shared.messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: liveCellID, for: indexPath as IndexPath) as! LiveChatCell
        
        var userString = IRCService.shared.messages[indexPath.row].user
        var messageString = IRCService.shared.messages[indexPath.row].message
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
        
        let text = IRCService.shared.messages[indexPath.item].message
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
    
    func reloadCollectionView() {
        collectionView.reloadData()
    }
    
    //MARK: -- Username check and login
    func joinIRC() {
        let whitespaceSet = NSCharacterSet.whitespaces
        if !(chatUsernameBar.text?.trimmingCharacters(in: whitespaceSet).isEmpty)! {
            UserDefaults.standard.set(chatUsernameBar.text, forKey: "username")
            
            IRCService.shared.setupIRC(chatUsernameBar.text!)
        } else {
            print("NEED TO HAVE SOMETHING IN THE TEXT BAR")
        }
    }
    
    func IRCLoginSuccess(_ notification: Notification) {
        if let isLoggedIn = notification.userInfo?["isLoggedIn"] as? Bool {
            if isLoggedIn {
                collectionView.isHidden = false
                chatEntryTab.isHidden = false
                chatIconView.isHidden = true
                chatJoinButton.isHidden = true
                chatUsernameBar.isHidden = true
                reloadCollectionView()
            } else {
                chatUsernameBar.text = ""
                chatUsernameBar.placeholder = "Choose another username"
            }
        }
    }
    
    func receivedIRCMessage() {
        collectionView.reloadData()
        let item = self.collectionView(collectionView, numberOfItemsInSection: 0) - 1
        let lastItemIndex = NSIndexPath(item: item, section: 0)
        collectionView.scrollToItem(at: lastItemIndex as IndexPath, at: UICollectionViewScrollPosition.top, animated: true)
    }

    
}
