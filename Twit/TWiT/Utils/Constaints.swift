//
//  Constaints.swift
//  TWiT
//
//  Created by Corey Baines on 24/9/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation

typealias DownloadComplete = () -> ()
typealias DownloadError = (NSError) -> ()

let internalAdress = "http://192.168.1.9/v1/"
let APIAdress = "\(internalAdress)v1/"


class API {
    private let baseURL = "http://192.168.1.9/v1/"
    static func mainData(uuid:String) -> String {
        return "http://192.168.1.9:3002/v1/twitdata/\(uuid)/mainpage"
    }
    static func seasonData(uuid:String, showID:String) -> String {
        return "http://192.168.1.9:3002/v1/twitdata/\(uuid)/\(showID)/seasonpage"
    }
}
