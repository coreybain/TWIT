//
//  TwitParseEpisode.swift
//  TWiT
//
//  Created by Corey Baines on 15/10/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import Firebase

extension TwitEpisodeParse {

    
    func parseEpisode(data:FIRDataSnapshot, complete:([TwitEpisodeDetails]) -> ()) {
        
        let recentData = data.value as! [String : AnyObject]
        
        var twitParseEpisodeDict: [TwitEpisodeDetails] = []
        
        for recent in recentData {
            
            
            var twitEpisode:TwitEpisodeDetails?
            
            //MARK: INFO SECTION
            let recentValue = recent.value["info"] as! NSDictionary
            
            let label = recentValue.value(forKey: "label")  as! String  //value["label"] as! String
            let ID = recentValue.value(forKey: "id") as! Int
            let created = recentValue.value(forKey: "created") as! String
            let episodeNumber = recentValue.value(forKey: "episodeNumber") as! String
            let showNotes = recentValue.value(forKey: "showNotes") as! String
            var teaser:String = ""
            if let teas =  recentValue.value(forKey: "teaser") as? String {
                teaser = teas
            }
            
            var showLabel:String?
            var showID:String?
            var showPicture:String?
            var showDict:TwitShowDetails?
            if let showRaw = recent.value["show"] as? NSDictionary {
                showDict = parseEpisodeShow(showData: showRaw)
                if let showsDict = showRaw.value(forKey: "info") as? NSDictionary {
                    showLabel = showsDict.value(forKey: "label") as! String
                    showID = showsDict.value(forKey: "id") as! String
                    if let picDict = showsDict.value(forKey: "coverArt") as? NSDictionary {
                        showPicture = picDict.value(forKey: "fileName") as! String
                    }
                }
            }
            
            
            var videoArray:[TwitVideoDetails] = []
            var videoAudio:TwitVideoDetails?
            var videoHD:TwitVideoDetails?
            var videoLarge:TwitVideoDetails?
            var videoSmall:TwitVideoDetails?
            
            if let audioData = recentValue.value(forKey: "video_audio") as? NSDictionary {
                videoAudio = parseVideoData(data: audioData)
                videoArray.append(videoAudio!)
            }
            if let hdData = recentValue.value(forKey: "video_hd") as? NSDictionary {
                videoHD = parseVideoData(data: hdData)
                videoArray.append(videoHD!)
            }
            if let largeData = recentValue.value(forKey: "video_large") as? NSDictionary {
                videoLarge = parseVideoData(data: largeData)
                videoArray.append(videoLarge!)
            }
            if let smallData = recentValue.value(forKey: "video_small") as? NSDictionary {
                videoSmall = parseVideoData(data: smallData)
                videoArray.append(videoSmall!)
            }
            if videoArray.count != 0 {
                twitEpisode = TwitEpisodeDetails(label: label, ID: ID, created: created, episodeNumber: episodeNumber, showNotes: showNotes, showLabel: showLabel, showPicture: showPicture, videoArray: videoArray, showDetails: showDict)
                twitParseEpisodeDict.append(twitEpisode!)
            } else {
                twitEpisode = TwitEpisodeDetails(label: label, ID: ID, created: created, episodeNumber: episodeNumber, showNotes: showNotes, showLabel: showLabel, showPicture: showPicture, videoArray: nil, showDetails: showDict)
                
                twitParseEpisodeDict.append(twitEpisode!)
            }
        }
        if Int(data.childrenCount) == twitParseEpisodeDict.count {
            complete(twitParseEpisodeDict)
        }
        
    }

}
