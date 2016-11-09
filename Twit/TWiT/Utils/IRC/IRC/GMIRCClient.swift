//
//  GMIRCClient.swift
//  TWiT
//
//  Created by Corey Baines on 7/11/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation


open class GMIRCClient: NSObject {
    
    open weak var delegate: GMIRCClientDelegate?
    
    fileprivate enum REPLY: String {
        case WELCOME = "001"
    }
    
    fileprivate var _socket: GMSocketProtocol!
    fileprivate var _nickName: String! = ""
    fileprivate var _user: String! = ""
    fileprivate var _realName: String! = ""
    
    /// true when a I registered successfully (user and nick)
    fileprivate var _connectionRegistered = false
    
    /// true when waiting for registration response
    fileprivate var _waitingForRegistration = false
    
    /// true when received the welcome message from the server
    fileprivate var _ready = false
    
    /// each IRC message should end with this sequence
    fileprivate let ENDLINE = "\r\n"
    
    required public init(socket: GMSocketProtocol) {
        
        super.init()
        
        _socket = socket
        _socket!.delegate = self
    }
}

// MARK: - GMIRCClientProtocol
extension GMIRCClient: GMIRCClientProtocol {
    
    public func host() -> String {
        return _socket.host
    }
    
    public func port() -> Int {
        return _socket.port
    }
    
    public func register(_ nickName: String, user: String, realName: String) {
        _nickName = nickName
        _user = user
        _realName = realName
        
        _socket.delegate = self
        _socket.open()
    }
    
    public func join(_ channel: String) {
        guard !channel.isEmpty && channel.hasPrefix("#") else {
            return
        }
        _sendCommand("JOIN \(channel)")
    }
    
    public func sendMessageToNickName(_ message: String, nickName: String) {
        guard !nickName.hasPrefix("#") else {
            print("Invalid nickName")
            return
        }
        _sendCommand("PRIVMSG \(nickName) :\(message)")
    }
    
    public func sendMessageToChannel(_ message: String, channel: String) {
        guard channel.hasPrefix("#") else {
            print("Invalid channel")
            return
        }
        _sendCommand("PRIVMSG \(channel) :\(message)")
    }
}

// MARK: - SocketDelegate
extension GMIRCClient: GMSocketDelegate {
    
    public func didOpen() {
        print("[DEBUG] Socket opened")
    }
    
    public func didReadyToSendMessages() {
        
        if !_connectionRegistered && !_waitingForRegistration {
            
            _waitingForRegistration = true
            
            _sendCommand("NICK \(_nickName!)")
            _sendCommand("USER \(_user!) 0 * : \(_realName!)")
        }
    }
    
    
    public func didReceiveMessage(_ msg: String) {
        
        print("\(msg)")
        
        let msgList = msg.components(separatedBy: ENDLINE)
        for line in msgList {
            if line.hasPrefix("PING") {
                _pong(msg)
            } else {
                _handleMessage(line)
            }
        }
    }
    
    public func didClose() {
        print("Socket connection closed")
        
        _connectionRegistered = false
    }
}

// MARK: - private
private extension GMIRCClient {
    
    func _sendCommand(_ command: String) {
        let msg = command + ENDLINE
        _socket.sendMessage(msg)
    }
    
    func _pong(_ msg: String) {
        
        var tokenFirst = msg.replacingOccurrences(of: "PING :", with: "")
        
        if let tokenID = tokenFirst.components(separatedBy: "/quote PONG ").last {
            print(tokenID)
            if let token = tokenID.components(separatedBy: " or /raw PONG").first {
                print(token)
                _connectionRegistered = true    // When I receive the first PING I suppose my registration is done
                _waitingForRegistration = false
                _sendCommand("PONG \(token)")
            }
        } else {
            _connectionRegistered = true    // When I receive the first PING I suppose my registration is done
            _waitingForRegistration = false
            _sendCommand("PONG \(tokenFirst)")
        }
    }
    
    
    
    func _handleMessage(_ msg: String) {
        
        let ircMsg = GMIRCMessage(message: msg)
        
        guard ircMsg != nil else {
            //            print("Can't parse message: \(msg)")
            return
        }
        
        switch ircMsg!.command! {
        case "001":
            _ready = true
            delegate?.didWelcome()
        case "JOIN":
            print(ircMsg)
            print(ircMsg!.params)
            print(ircMsg!.params!.unparsed)
            //delegate?.didJoin(ircMsg!.params!.unparsed!)
        case "PRIVMSG":
            delegate?.didReceivePrivateMessage(ircMsg!.params!.textToBeSent!, from: ircMsg!.prefix!.nickName!)
        default:
            //            print("Message not handled: \(msg)")
            break;
        }
    }
}
