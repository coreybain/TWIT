//
//  IRCService.swift
//  TWiT
//
//  Created by Corey Baines on 31/12/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import CoreData

class IRCService: NSObject, GMIRCClientDelegate {
    
    static let shared = IRCService()
    var irc: GMIRCClient!
    var connected:Bool = false
    
    static func IRC() -> IRCService {
        return shared
    }
    
    //MARK: -- Message Dictionary
    var messages: [TwitLiveMessage] = []
    
    func setupIRC(_ username:String) {
        let socket = GMSocket(host: "irc.twit.tv", port: 6667)
        irc = GMIRCClient(socket: socket)
        irc.delegate = self
        irc.register((username as! String), user: (username as! String), realName: (username as! String))
    }
    
    func closeIRC() {
        irc.closeIRC()
        connected = false
    }
    
    func didWelcome() {
        let userInfo = [ "isLoggedIn" : true ]
        NotificationCenter.default.post(name: Notification.Name("isLoggedIn"), object: nil, userInfo: userInfo)
        print("Received welcome message - ready to join a chat room")
        irc.join("#twitlive")
    }
    
    func didJoin(_ channel: String) {
        print("Joined chat room: \(channel)")
        connected = true
        //irc.sendMessageToNickName("Hi, I'm eugenio_ios. Nice to meet you!", nickName: "eugenio79")
    }
    
    func didReceivePrivateMessage(_ text: String, from: String) {
        print("\(from): \(text)")
        print(from)
        print(text)
        
        let message = TwitLiveMessage(user: from, message: text)
        messages.append(message)
        
        NotificationCenter.default.post(name: Notification.Name("NewTwitMessage"), object: nil)
        
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
            NotificationCenter.default.post(name: Notification.Name("reloadCollectionView"), object: nil)
        }))
        alert.addAction(UIAlertAction(title: user2, style: .default, handler: { Void in
            UserDefaults.standard.set(user2, forKey: "username")
            let socket = GMSocket(host: "irc.twit.tv", port: 6667)
            self.irc = GMIRCClient(socket: socket)
            self.irc.delegate = self
            self.irc.register(user2, user: user2, realName: user2)
            NotificationCenter.default.post(name: Notification.Name("reloadCollectionView"), object: nil)
        }))
        alert.addAction(UIAlertAction(title: "Choose your own", style: .default, handler: { [unowned self] Void in
            let userInfo = [ "isLoggedIn" : false ]
            NotificationCenter.default.post(name: Notification.Name("isLoggedIn"), object: nil, userInfo: userInfo)
        }))
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
}
