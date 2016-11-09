//
//  GMSocketProtocol.swift
//  TWiT
//
//  Created by Corey Baines on 7/11/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation

/// What an implementation of a socket should implement at least
@objc public protocol GMSocketProtocol {
    
    var host: String { get }
    var port: Int { get }
    
    /// Who'll listen for socket events (e.g. open, close, message received)
    weak var delegate: GMSocketDelegate? { get set }
    
    init(host: String, port: Int)
    
    /// Open the connection of the socket
    func open()
    
    /// Close the connection of the socket
    func close()
    
    /// Send a message on the socket (the socket should be open)
    func sendMessage(_ message: String)
}
