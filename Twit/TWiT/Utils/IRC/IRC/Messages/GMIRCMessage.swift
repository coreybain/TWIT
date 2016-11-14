//
//  GMIRCMessage.swift
//  TWiT
//
//  Created by Corey Baines on 7/11/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation

/// An IRC message
open class GMIRCMessage: NSObject {
    
    fileprivate(set) var prefix: GMIRCMessagePrefix?
    fileprivate(set) var command: String?
    fileprivate(set) var user: String?
    
    //    private(set) var parameters: String?
    fileprivate(set) var params: GMIRCMessageParams?
    
    /// format: prefix + cmd + params + crlf
    /// e.g. :card.freenode.net 001 eugenio_ios :Welcome to the freenode Internet Relay Chat Network eugenio_ios
    /// e.g. :eugenio79!~giuseppem@93-34-6-226.ip47.fastwebnet.it PRIVMSG eugenio_ios :Hi, I am Eugenio too
    init?(message: String) {
        
        super.init()
        
        var msg = message
        print(msg)
        
        // prefix
        if message.hasPrefix(":") {
            if let idx = msg.characters.index(of: " ") {
                let prefixStr = msg.substring(to: idx)
                prefix = GMIRCMessagePrefix(prefix: prefixStr)
                //msg = msg.substring(from: idx.samePosition(in: idx))
                //msg = msg.substring(from: <#T##String.CharacterView corresponding to `idx`##String.CharacterView#>.index(after: idx))
                msg = msg.substring(from: idx)
                print(msg)
                print(prefix?.nickName)
            } else {
                return nil
            }
        }
        
        // command
        if let idx = msg.characters.index(of: " ") {
            print(msg)
            var subTrue:Bool = false
            //command = msg.substring(to: idx)
            let subString = msg.components(separatedBy: " ")
            if (msg.range(of: "ERSIO") != nil) {  //legat
                if subString[1] == "PRIVMSG" {
                    if ((prefix?.nickName)!.range(of: "legat") != nil) {
                        user = String((prefix?.nickName)!.characters.dropFirst())
                        command = "VERSION"
                    } else if subString[2] == "\(UserDefaults.standard.object(forKey: "username")!)" {
                        user = String((prefix?.nickName)!.characters.dropFirst())
                        command = "VERSION"
                    } else {
                        return nil
                    }
                } else {
                     return nil
                }
            } else {
                command = subString[1]
            }
            
        } else {
            return nil
        }
        
        // parameters
        params = GMIRCMessageParams(stringToParse: msg)
        //        parameters = msg
    }
    
}
