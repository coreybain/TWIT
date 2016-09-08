//
//  Constaints.swift
//  Twit
//
//  Created by Corey Baines on 5/09/2016.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation

let twitKey = "2a6557daace8c6524cc82af2e718fbcc"
let twitAppID = "3e742ac7"

let twitHeaders = ["Accept":"application/json", "app-id":twitAppID, "app-key":twitKey]

typealias DownloadComplete = () -> ()
typealias DownloadError = (NSError) -> ()