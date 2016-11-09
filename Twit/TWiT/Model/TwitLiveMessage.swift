//
//  TwitLiveMessage.swift
//  TWiT
//
//  Created by Corey Baines on 10/11/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation

struct TwitLiveMessage {
    private var _message:String!
    private var _user:String!
    
    var message:String {
        get {
            return _message
        }
    }
    
    var user:String {
        get {
            return _user
        }
    }
    
    init(user:String, message:String) {
        _user = user
        _message = message
    }

}
