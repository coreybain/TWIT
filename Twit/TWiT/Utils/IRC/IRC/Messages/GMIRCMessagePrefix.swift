//
//  GMIRCMessagePrefix.swift
//  TWiT
//
//  Created by Corey Baines on 7/11/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation

/// An IRC message prefix
open class GMIRCMessagePrefix: NSObject {
    
    fileprivate(set) var nickName: String?
    fileprivate(set) var serverName: String?
    
    /// @param prefix e.g. ":eugenio79!~giuseppem@93-34-6-226.ip47.fastwebnet.it"
    init?(prefix: String) {
        
        super.init()
        
        var idx = prefix.characters.index(of: ":")  // an IRC prefix should start with ":"
        
        guard idx != nil else {
            return nil
        }
        
        let remainingPrefix = prefix.substring(from: idx!)   // skipping the ":"
        
        idx = remainingPrefix.characters.index(of: "!")
        
        if idx != nil {
            nickName = remainingPrefix.substring(to: idx!)
        } else {
            serverName = remainingPrefix
        }
    }
}
