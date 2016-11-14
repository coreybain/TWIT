//
//  GMIRCClientDelegate.swift
//  TWiT
//
//  Created by Corey Baines on 7/11/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation

public protocol GMIRCClientDelegate: NSObjectProtocol {
    
    /// When this method is called, the channel is ready
    /// At this point you can join a chat room
    func didWelcome()
    
    /// Called when successfully joined a chat room
    /// @param channel Prepend an hash symbol (#) to the chat room name, e.g. "#test"
    func didJoin(_ channel: String)
    
    /// Called when someone sent you a private message
    /// @param text The text sent by the user
    /// @param from The nickName of who sent you the message
    func didReceivePrivateMessage(_ text: String, from: String)
    
    func nickAlreadyExists()
}
