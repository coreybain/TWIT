//
//  GMSocketDelegate.swift
//  TWiT
//
//  Created by Corey Baines on 7/11/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation

/// What methods should a class implement to become a delegate of a socket
@objc public protocol GMSocketDelegate {
    
    /// Called when socket connection is open
    func didOpen()
    
    /// Called when receiving a message
    func didReceiveMessage(_ message: String)
    
    /// Called when the socket is ready to receive messages from the client
    func didReadyToSendMessages()
    
    /// Called when the connection gets closed
    func didClose()
}
