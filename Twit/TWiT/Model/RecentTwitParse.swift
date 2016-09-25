//
//  RecentTwitParse.swift
//  TWiT
//
//  Created by Corey Baines on 25/9/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import Firebase

class RecentTwitParse {
    
    func parseRecent(data:FIRDataSnapshot) {
        
        let recentData = data.value as! [String : AnyObject]
        
        for recent in recentData {
            //            let label = recent.value["label"] as! String
            let label = recent.value["label"] as! String
            let ID = recent.value["id"] as! Int
            let created = recent.value["created"] as! String
            let episodeNumber = recent.value["episodeNumber"] as! String
            let showNotes = recent.value["showNotes"] as! String
            let teaser = recent.value["teaser"] as! String
            print(label)
            print(ID)
            var showLabel = ""
            var showPicture = ""
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
            if let video_audio = recent.value["video_audio"] as? NSDictionary {
                let format = video_audio.value(forKey: "format") as! String
                let runningTime = video_audio.value(forKey: "runningTime") as! String
                let hours = video_audio.value(forKey: "hours") as! String
                let minutes = video_audio.value(forKey: "minutes") as! String
                let seconds = video_audio.value(forKey: "seconds") as! String
                let mediaUrl = video_audio.value(forKey: "mediaUrl") as! String
                let size = video_audio.value(forKey: "size") as! String
            }
            if let video_audio = recent.value["video_hd"] as? NSDictionary {
                let format = video_audio.value(forKey: "format") as! String
                let runningTime = video_audio.value(forKey: "runningTime") as! String
                let hours = video_audio.value(forKey: "hours") as! String
                let minutes = video_audio.value(forKey: "minutes") as! String
                let seconds = video_audio.value(forKey: "seconds") as! String
                let mediaUrl = video_audio.value(forKey: "mediaUrl") as! String
                let size = video_audio.value(forKey: "size") as! String
            }
            if let video_audio = recent.value["video_large"] as? NSDictionary {
                let format = video_audio.value(forKey: "format") as! String
                let runningTime = video_audio.value(forKey: "runningTime") as! String
                let hours = video_audio.value(forKey: "hours") as! String
                let minutes = video_audio.value(forKey: "minutes") as! String
                let seconds = video_audio.value(forKey: "seconds") as! String
                let mediaUrl = video_audio.value(forKey: "mediaUrl") as! String
                let size = video_audio.value(forKey: "size") as! String
            }
            if let video_audio = recent.value["video_small"] as? NSDictionary {
                let format = video_audio.value(forKey: "format") as! String
                let runningTime = video_audio.value(forKey: "runningTime") as! String
                let hours = video_audio.value(forKey: "hours") as! String
                let minutes = video_audio.value(forKey: "minutes") as! String
                let seconds = video_audio.value(forKey: "seconds") as! String
                let mediaUrl = video_audio.value(forKey: "mediaUrl") as! String
                let size = video_audio.value(forKey: "size") as! String
            }
        }
        
    }
    
    
}
