//
//  GMIRCClientProtocol.swift
//  TWiT
//
//  Created by Corey Baines on 7/11/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation

public protocol GMIRCClientProtocol: NSObjectProtocol {
    
    weak var delegate: GMIRCClientDelegate? { get set }
    
    init(socket: GMSocketProtocol)
    
    func host() -> String
    func port() -> Int
    
    /// In order to start an IRC session, you'd provide at least a nick name and a real name
    func register(_ nickName: String, user: String, realName: String)
    
    /// Join a channel / chat room
    func join(_ channel: String)
    
    /// Send a private message to a specific user (identified by its nickname)
    /// @param message The message to send
    /// @param nickName The nickname of the recipient (e.g. "john")
    func sendMessageToNickName(_ message: String, nickName: String)
    
    /// Send a message to a specific channel
    /// @param message The message to send
    /// @param channel The target channel (e.g. "#test")
    func sendMessageToChannel(_ message: String, channel: String)
}
