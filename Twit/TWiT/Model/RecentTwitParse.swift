//
//  RecentTwitParse.swift
//  TWiT
//
//  Created by Corey Baines on 25/9/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import Firebase

class TwitEpisodeParse {
    
    func parseEpisode(data:FIRDataSnapshot) {
        
        let recentData = data.value as! [String : AnyObject]
        
        for recent in recentData {
            var twitEpisode:TwitEpisodeDetails?
            let label = recent.value["label"] as! String
            let ID = recent.value["id"] as! Int
            let created = recent.value["created"] as! String
            let episodeNumber = recent.value["episodeNumber"] as! String
            let showNotes = recent.value["showNotes"] as! String
            let teaser = recent.value["teaser"] as! String
            print(label)
            print(ID)
            var showLabel:String?
            var showPicture:String?
            if let embedded = recent.value["embedded"] as? NSDictionary {
                if let showsDict = embedded.value(forKey: "shows") as? NSDictionary {
                    showLabel = showsDict.value(forKey: "label") as! String
                    showLabel = showsDict.value(forKey: "id") as! String
                    showPicture = showsDict.value(forKey: "id") as! String
                }
            } else if let showNotes = recent.value["showNotes"] as? String {
                if showNotes.lowercased().range(of: "Radio Tech") != nil {
                    showLabel = "This Week in Radio Tech"
                    showPicture = "twirt600"
                    print(recent)
                }
            } else {
                showLabel = "TWiT Bits & Specials"
                showPicture = "bits1400"
                print(recent)
            }
            print(showLabel)
            var videoArray:[TwitVideoDetails] = []
            var videoAudio:TwitVideoDetails?
            var videoHD:TwitVideoDetails?
            var videoLarge:TwitVideoDetails?
            var videoSmall:TwitVideoDetails?
            
            if let audioData = recent.value["video_audio"] as? NSDictionary {
                videoAudio = parseVideoData(data: audioData)
                print(videoAudio)
                videoArray.append(videoAudio!)
                print(videoArray)
            }
            if let hdData = recent.value["video_hd"] as? NSDictionary {
                videoHD = parseVideoData(data: hdData)
                videoArray.append(videoHD!)
            }
            if let largeData = recent.value["video_large"] as? NSDictionary {
                videoLarge = parseVideoData(data: largeData)
                videoArray.append(videoLarge!)
            }
            if let smallData = recent.value["video_small"] as? NSDictionary {
                videoSmall = parseVideoData(data: smallData)
                videoArray.append(videoSmall!)
            }
            if videoArray.count != 0 {
                twitEpisode = TwitEpisodeDetails.init(label: label, ID: ID, created: created, episodeNumber: episodeNumber, showNotes: showNotes, showLabel: showLabel, showPicture: showPicture, videoArray: videoArray)
                print(videoArray.count)
            } else {
                twitEpisode = TwitEpisodeDetails.init(label: label, ID: ID, created: created, episodeNumber: episodeNumber, showNotes: showNotes, showLabel: showLabel, showPicture: showPicture, videoArray: nil)
                print("no video array")
            }
        }
        
    }
    func parseVideoData(data:NSDictionary) -> TwitVideoDetails {
        let format = data.value(forKey: "format") as! String
        let runningTime = data.value(forKey: "runningTime") as! String
        let hours = data.value(forKey: "hours") as! String
        let minutes = data.value(forKey: "minutes") as! String
        let seconds = data.value(forKey: "seconds") as! String
        let mediaUrl = data.value(forKey: "mediaUrl") as! String
        let size = data.value(forKey: "size") as! String
        return TwitVideoDetails(formatString: format, mediaUrlString: mediaUrl, runningTimeString: runningTime, hoursString: hours, minutesString: minutes, secondsString: seconds, sizeString: size)
    }
    
}
