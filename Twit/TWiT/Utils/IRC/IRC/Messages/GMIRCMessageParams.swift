//
//  GMIRCMessageParams.swift
//  TWiT
//
//  Created by Corey Baines on 7/11/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
/// Encapsulates an IRC message params
open class GMIRCMessageParams: NSObject {
    
    /// Here I put everything I'm not still able to parse
    fileprivate(set) var unparsed: String?
    
    /// e.g. the target of a PRIVMSG
    fileprivate(set) var msgTarget: String?
    
    /// e.g. the the text of a PRIVMSG
    fileprivate(set) var textToBeSent: String?
    
    /// @param stringToParse e.g. "eugenio_ios :Hi, I am Eugenio too"
    init?(stringToParse: String) {
        
        super.init()
        
        var idx = stringToParse.characters.index(of: " ")
        
        if idx == nil {
            unparsed = stringToParse
            return
        }
        
        msgTarget = stringToParse.substring(to: idx!)
        
        let remaining = stringToParse.substring(from: idx!)
        
        idx = remaining.characters.index(of: ":")
        
        if idx == nil {
            print(remaining)
            unparsed = remaining
            return
        }
        
        textToBeSent = remaining.substring(from: idx!)
    }
}
