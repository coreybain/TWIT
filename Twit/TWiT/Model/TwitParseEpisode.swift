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

    
    func parseEpisode(data:NSArray, complete:(_ episodeData:[TwitEpisodeDetails], _ offers:[TwitOfferDetails]?) -> ()) {
        
       // let recentData = data.value(forKey: [String : AnyObject])
        
        var twitParseEpisodeDict: [TwitEpisodeDetails] = []
        
        for recent in data {
            if let episode = recent as? NSDictionary {
                
                var twitEpisode:TwitEpisodeDetails?
                
                //print(episode)
                //MARK: INFO SECTION
                let recentValue = episode.value(forKey: "info")  as! NSDictionary
                
            
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
                if let showRaw = episode.value(forKey: "show") as? NSDictionary {
                    showDict = parseEpisodeShow(showData: showRaw)
                    if let offers = showRaw.value(forKey: "offers")as? NSDictionary {
                        print("OFFERS HERE")
                        parseOffers(data: offers)
                    }
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
        }
        if Int(data.count) == twitParseEpisodeDict.count {
            complete(twitParseEpisodeDict, twitOffers)
        }
        
    }
    
    func parseOffers(data:NSDictionary) {
        
        var offers:[TwitOfferDetails]?
        
        for (key, value) in data {
            let offerData = value as! NSDictionary
            var offerURL:String?
            var imageUrl:String?
            var imageType:String?
            var image1600:String?
            var image1200:String?
            var image800:String?
            var image600:String?
            var image400:String?
            let offerID = offerData.value(forKey: "id") as! String
            let offerLabel = offerData.value(forKey: "label") as! String
            if let offerlink = offerData.value(forKey: "offerLink") as? NSDictionary {
                offerURL = offerlink.value(forKey: "url") as! String
            }
            if let offerSponsor = offerData.value(forKey: "offerSponsor") as? NSDictionary {
                if let sponsorLogo = offerSponsor.value(forKey: "sponsorLogo") as? NSDictionary {
                    imageUrl = sponsorLogo.value(forKey: "url") as! String
                    imageType = sponsorLogo.value(forKey: "mimeType") as! String
                    if let derivatives = sponsorLogo.value(forKey: "derivatives") as? NSDictionary {
                        image1600 = derivatives.value(forKey: "twit_slideshow_1600x400") as! String
                        image1200 = derivatives.value(forKey: "twit_slideshow_1200x300") as! String
                        image800 = derivatives.value(forKey: "twit_slideshow_800x200") as! String
                        image600 = derivatives.value(forKey: "twit_slideshow_600x450") as! String
                        image400 = derivatives.value(forKey: "twit_slideshow_400x300") as! String
                    }
                }
            }
            let episodeOffer = TwitOfferDetails(ID: offerID, url: offerURL!, label: offerLabel, imageUrl: imageUrl, imageType: imageType, image1600: image1600, image1200: image1200, image800: image800, image600: image600, image400: image400)
            offers?.append(episodeOffer)
            twitOffers.append(episodeOffer)
            
        }
        
    }
    
    func parseSeasonEpisode(data:NSArray, complete:(_ episodeData:[TwitEpisodeDetails], _ offers:[TwitOfferDetails]?) -> ()) {
        
        // let recentData = data.value(forKey: [String : AnyObject])
        
        var twitParseEpisodeDict: [TwitEpisodeDetails] = []
        
        for recent in data {
            if let epRaw = recent as? NSDictionary {
                
                for (key, value) in epRaw {
                    
                    if let episode = value as? NSDictionary {
                
                        var twitEpisode:TwitEpisodeDetails?
                            
                        
                        //print(episode)
                        //MARK: INFO SECTION
                        let recentValue = episode.value(forKey: "info")  as! NSDictionary
                        
                        
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
                        if let showRaw = episode.value(forKey: "show") as? NSDictionary {
                            showDict = parseEpisodeShow(showData: showRaw)
                            if let offers = showRaw.value(forKey: "offers")as? NSDictionary {
                                print("OFFERS HERE")
                                parseOffers(data: offers)
                            }
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
                }
                if Int(data.count) == twitParseEpisodeDict.count {
                    complete(twitParseEpisodeDict, twitOffers)
                }
                
            }
        
        }
        
    }


}
