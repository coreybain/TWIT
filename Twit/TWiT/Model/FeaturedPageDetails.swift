//
//  FeaturedPageDetails.swift
//  TWiT
//
//  Created by Corey Baines on 25/9/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import Firebase

struct TwitEpisodeDetails {
    var _label:String!
    var _ID:Int!
    var _created:String!
    var _episodeNumber:String?
    var _showNotes:String?
    var _showLabel:String?
    var _showPicture:String?
    var _videoArray:[TwitVideoDetails]?
    
    var label:String {
        get {
            return _label
        }
    }
    
    var ID:Int {
        get {
            return _ID
        }
    }
    
    var created:String {
        get {
            return _created
        }
    }
    
    var episodeNumber:String {
        get {
            if _episodeNumber == nil {
                return "1"
            }
            return _episodeNumber!
        }
    }
    
    var showNotes:String {
        get {
            if _showNotes == nil {
                return ""
            }
            return _showNotes!
        }
    }
    
    var showLabel:String {
        get {
            if _showLabel == nil {
                return ""
            }
            return _showLabel!
        }
    }
    
    var showPicture:String {
        get {
            if _showPicture == nil {
                return ""
            }
            return _showPicture!
        }
    }
    
    var videoArray:[TwitVideoDetails] {
        get {
            if _videoArray == nil {
                return [TwitVideoDetails(formatString: "1", mediaUrlString: "1", runningTimeString: "1", hoursString: "1", minutesString: "1", secondsString: "1", sizeString: "1")]
            }
            return _videoArray!
        }
    }

    init(label:String, ID:Int, created:String, episodeNumber:String?, showNotes:String?, showLabel:String?, showPicture:String?, videoArray:[TwitVideoDetails]?) {
        _label = label
        _ID = ID
        _created = created
        _episodeNumber = episodeNumber
        _showNotes = showNotes
        _showLabel = showLabel
        _showPicture = showPicture
        _videoArray = videoArray
    }
    
}

struct TwitVideoDetails {
    var format:String!
    var mediaUrl:String!
    var runningTime:Int!
    var hours:Int!
    var minutes:Int!
    var seconds:Int!
    var size:Int!
    
    init(formatString:String, mediaUrlString:String, runningTimeString:String, hoursString:String, minutesString:String, secondsString:String, sizeString:String) {
        format = formatString
        mediaUrl = mediaUrlString
        runningTime = Int(runningTimeString)
        hours = Int(hoursString)
        minutes = Int(minutesString)
        seconds = Int(secondsString)
        size = Int(sizeString)
    }
}
