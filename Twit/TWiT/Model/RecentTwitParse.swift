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
    
    //MARK: -- Variables
    var twitEpisodeDict: [TwitEpisodeDetails] = []
    var twitShowDict: [TwitShowDetails] = []
    var twitCastRelatedLinks: [TwitCastRelatedLinks] = []
    var twitCastDict: [TwitCastDetails] = []
    var castDict: [TwitCastDetails] = []
    
    func parseShow(data:FIRDataSnapshot, complete:([TwitShowDetails]) -> ()) {
        let showData = data.value as! [String : AnyObject]
        
        var twitParseShowDict: [TwitShowDetails] = []
        var twitParseShowCastDict: [TwitCastDetails] = []
        
        for show in showData {
            
            //MARK: - Variables
            var showNotes = ""
            var showDate = ""
            
            var heroImageUrl = ""
            var heroImageID = ""
            var heroImageFileName = ""
            var heroImagetype = ""
            var heroImageSize = ""
            var heroImageWidth = ""
            var heroImageHeight = ""
            var heroImage1600 = ""
            var heroImage1200 = ""
            var heroImage800 = ""
            
            var coverArtUrl = ""
            var coverArtID = ""
            var coverArtFileName = ""
            var coverArttype = ""
            var coverArtSize = ""
            var coverArtWidth = ""
            var coverArtHeight = ""
            var coverArt2048 = ""
            var coverArt1400 = ""
            var coverArt600 = ""
            
            var twitCastLinks:TwitCastRelatedLinks?
            var twitCast:TwitCastDetails?
            var twitShow:TwitShowDetails?
            var showHero:ShowHeroImage?
            var showCover:ShowCoverImage?
            
            
            
            let ID = show.value["id"] as! String
            let label = show.value["label"] as! String
            let description = show.value["description"] as! String
            if show.value["showNotes"] as? String != nil {
                showNotes = show.value["showNotes"] as! String
            }
            if show.value["showDate"] as? String != nil {
                showNotes = show.value["showDate"] as! String
            }
            let tagLine = show.value["tagLine"] as! String
            let shortCode = show.value["shortCode"] as! String
            let active = show.value["active"] as! Bool
            
            if let heroImage = show.value["heroImage"] as? NSDictionary {
                heroImageUrl = heroImage.value(forKey: "url") as! String
                heroImageID = heroImage.value(forKey: "fid") as! String
                heroImageFileName = heroImage.value(forKey: "fileName") as! String
                heroImagetype = heroImage.value(forKey: "urmimeTypel") as! String
                heroImageSize = heroImage.value(forKey: "fileSize") as! String
                heroImageWidth = heroImage.value(forKey: "width") as! String
                heroImageHeight = heroImage.value(forKey: "height") as! String
                if let derivatives = heroImage.value(forKey: "derivatives") as? NSDictionary {
                    heroImage1600 = derivatives.value(forKey: "twit_slideshow_1600x400") as! String
                    heroImage1200 = derivatives.value(forKey: "twit_slideshow_1200x300") as! String
                    heroImage800 = derivatives.value(forKey: "twit_slideshow_800x200") as! String
                }
                showHero = ShowHeroImage(heroImageFileName: heroImageFileName, heroImageFileSize: heroImageSize, heroImageFileID: heroImageID, heroImageHeight: heroImageHeight, heroImageWidth: heroImageWidth, heroImageUrl: heroImageUrl, heroImageType: heroImagetype, heroImage1600: heroImage1600, heroImage1200: heroImage1200, heroImage800: heroImage800)
            }
            
            if let coverArt = show.value["coverArt"] as? NSDictionary {
                coverArtUrl = coverArt.value(forKey: "url") as! String
                coverArtFileName = coverArt.value(forKey: "fileName") as! String
                coverArtID = coverArt.value(forKey: "fid") as! String
                coverArttype = coverArt.value(forKey: "urmimeTypel") as! String
                coverArtSize = coverArt.value(forKey: "fileSize") as! String
                coverArtWidth = coverArt.value(forKey: "width") as! String
                coverArtHeight = coverArt.value(forKey: "height") as! String
                if let derivatives = coverArt.value(forKey: "derivatives") as? NSDictionary {
                    coverArt2048 = derivatives.value(forKey: "twit_album_art_2048x2048") as! String
                    coverArt1400 = derivatives.value(forKey: "twit_album_art_1400x1400") as! String
                    coverArt600 = derivatives.value(forKey: "twit_album_art_600x600") as! String
                }
                showCover = ShowCoverImage(coverArtFileName: coverArtFileName, coverArtFileSize: coverArtSize, coverArtFileID: coverArtID, coverArtHeight: coverArtHeight, coverArtWidth: coverArtWidth, coverArtUrl: coverArtUrl, coverArtType: coverArttype, coverArt2048: coverArt2048, coverArt1400: coverArt1400, coverArt600: coverArt600)
            }
            
            if let embedded = show.value["embedded"] as? NSDictionary {
                if let credits = embedded.value(forKey: "credits") as? [String : AnyObject] {
                    for credit in credits {
                        if let people = credit.value["people"] as? NSDictionary {
                            
                            var castArt2048 = ""
                            var castArt1400 = ""
                            var castArt600 = ""
                            var picture = ""
                            var positionTitle = ""
                            var pictureFileName = ""
                            var pictureType = ""
                            var pictureUrlFull = ""
                            var picturefileSize = ""
                            var pictureWidth = ""
                            var pictureHeight = ""
                            var castBio = ""
                            
                            let castID = people.value(forKey: "id") as! String
                            let castLabel = people.value(forKey: "label") as! String
                            if let bio = people.value(forKey: "bio") as? String {
                                castBio = bio
                            }
                            let staff = people.value(forKey: "staff") as! Bool
                            if let picture = people.value(forKey: "picture") as? NSDictionary {
                                pictureFileName = picture.value(forKey: "fileName") as! String
                                pictureType = picture.value(forKey: "mimeType") as! String
                                pictureUrlFull = picture.value(forKey: "url") as! String
                                picturefileSize = picture.value(forKey: "fileSize") as! String
                                pictureWidth = picture.value(forKey: "width") as! String
                                pictureHeight = picture.value(forKey: "height") as! String
                                if let derivatives = picture.value(forKey: "derivatives") as? NSDictionary {
                                    castArt2048 = derivatives.value(forKey: "twit_album_art_2048x2048") as! String
                                    castArt1400 = derivatives.value(forKey: "twit_album_art_1400x1400") as! String
                                    castArt600 = derivatives.value(forKey: "twit_album_art_600x600") as! String
                                }
                            }
                            
                            if let relatedLinks = people.value(forKey: "relatedLinks") as? [String : AnyObject] {
                                for relatedLink in relatedLinks {
                                    let title = relatedLink.value["title"] as! String
                                    let url = relatedLink.value["url"] as! String
                                    twitCastLinks = TwitCastRelatedLinks.init(url: url, title: title)
                                    twitCastRelatedLinks.append(twitCastLinks!)
                                }
                            }
                            if twitCastRelatedLinks.count == 0 {
                                twitCast = TwitCastDetails.init(castID: castID, castLabel: castLabel, castBio: castBio, staff: staff, positionTitle: positionTitle, pictureFileName: pictureFileName, pictureFiletype: pictureType, pictureUrlFull: pictureUrlFull, pictureUrl1400: castArt2048, pictureUrl600: castArt1400, pictureUrl300: castArt600, pictureFileSize: picturefileSize, pictureWidth: pictureWidth, pictureHeight: pictureHeight, pictureTitle: nil, relatedLinks: nil)
                                twitParseShowCastDict.append(twitCast!)
                            } else {
                                twitCast = TwitCastDetails.init(castID: castID, castLabel: castLabel, castBio: castBio, staff: staff, positionTitle: positionTitle, pictureFileName: pictureFileName, pictureFiletype: pictureType, pictureUrlFull: pictureUrlFull, pictureUrl1400: castArt2048, pictureUrl600: castArt1400, pictureUrl300: castArt600, pictureFileSize: picturefileSize, pictureWidth: pictureWidth, pictureHeight: pictureHeight, pictureTitle: nil, relatedLinks: twitCastRelatedLinks)
                                twitParseShowCastDict.append(twitCast!)
                            }
                        }
                    }
                }
            }
            if showHero != nil || showCover != nil {
                twitShow = TwitShowDetails(label: label, showID: ID, description: description, active: active, shortCode: shortCode, showContactInfo: nil, showDate: showDate, tagline: tagLine, showHeroImage: showHero, showCoverImage: showCover, categoryID: nil, categoryLabel: nil, topicsID: nil, topicsLabel: nil, twitCastDetails: twitParseShowCastDict)
            } else if showHero != nil {
                twitShow = TwitShowDetails(label: label, showID: ID, description: description, active: active, shortCode: shortCode, showContactInfo: nil, showDate: showDate, tagline: tagLine, showHeroImage: showHero, showCoverImage: nil, categoryID: nil, categoryLabel: nil, topicsID: nil, topicsLabel: nil, twitCastDetails: twitParseShowCastDict)
            } else if showCover != nil {
                twitShow = TwitShowDetails(label: label, showID: ID, description: description, active: active, shortCode: shortCode, showContactInfo: nil, showDate: showDate, tagline: tagLine, showHeroImage: nil, showCoverImage: showCover, categoryID: nil, categoryLabel: nil, topicsID: nil, topicsLabel: nil, twitCastDetails: twitParseShowCastDict)
            } else {
                twitShow = TwitShowDetails(label: label, showID: ID, description: description, active: active, shortCode: shortCode, showContactInfo: nil, showDate: showDate, tagline: tagLine, showHeroImage: nil, showCoverImage: nil, categoryID: nil, categoryLabel: nil, topicsID: nil, topicsLabel: nil, twitCastDetails: twitParseShowCastDict)
            }
            twitParseShowDict.append(twitShow!)
        }
        if Int(data.childrenCount) == twitParseShowDict.count {
            complete(twitParseShowDict)
            print("complete")
        }
    }
    
    func parseCast(data:FIRDataSnapshot, complete:([TwitCastDetails]) -> ()) {
        let castData = data.value as! [String : AnyObject]
        
        var twitParseCastDict: [TwitCastDetails] = []
        
        for show in castData {
            var twitCastLinks:TwitCastRelatedLinks?
            var twitCast:TwitCastDetails?
            
            var castArt2048 = ""
            var castArt1400 = ""
            var castArt600 = ""
            var picture = ""
            var positionTitle = ""
            var pictureFileName = ""
            var pictureType = ""
            var pictureUrlFull = ""
            var picturefileSize = ""
            var pictureWidth = ""
            var pictureHeight = ""
            var castBio = ""
            
            let castID = show.value["id"] as! String
            let castLabel = show.value["label"] as! String
            if let bio = show.value["bio"] as? String {
                castBio = bio
            }
            let staff = show.value["staff"] as! Bool
            if let picture = show.value["picture"] as? NSDictionary {
                pictureFileName = picture.value(forKey: "fileName") as! String
                pictureType = picture.value(forKey: "mimeType") as! String
                pictureUrlFull = picture.value(forKey: "url") as! String
                picturefileSize = picture.value(forKey: "fileSize") as! String
                pictureWidth = picture.value(forKey: "width") as! String
                pictureHeight = picture.value(forKey: "height") as! String
                if let derivatives = picture.value(forKey: "derivatives") as? NSDictionary {
                    castArt2048 = derivatives.value(forKey: "twit_album_art_2048x2048") as! String
                    castArt1400 = derivatives.value(forKey: "twit_album_art_1400x1400") as! String
                    castArt600 = derivatives.value(forKey: "twit_album_art_600x600") as! String
                }
            }
            
            if let relatedLinks = show.value["relatedLinks"] as? [String : AnyObject] {
                for relatedLink in relatedLinks {
                    let title = relatedLink.value["title"] as! String
                    let url = relatedLink.value["url"] as! String
                    twitCastLinks = TwitCastRelatedLinks.init(url: url, title: title)
                    twitCastRelatedLinks.append(twitCastLinks!)
                }
            }
            if twitCastRelatedLinks.count == 0 {
                twitCast = TwitCastDetails.init(castID: castID, castLabel: castLabel, castBio: castBio, staff: staff, positionTitle: positionTitle, pictureFileName: pictureFileName, pictureFiletype: pictureType, pictureUrlFull: pictureUrlFull, pictureUrl1400: castArt2048, pictureUrl600: castArt1400, pictureUrl300: castArt600, pictureFileSize: picturefileSize, pictureWidth: pictureWidth, pictureHeight: pictureHeight, pictureTitle: nil, relatedLinks: nil)
                twitParseCastDict.append(twitCast!)
            } else {
                twitCast = TwitCastDetails.init(castID: castID, castLabel: castLabel, castBio: castBio, staff: staff, positionTitle: positionTitle, pictureFileName: pictureFileName, pictureFiletype: pictureType, pictureUrlFull: pictureUrlFull, pictureUrl1400: castArt2048, pictureUrl600: castArt1400, pictureUrl300: castArt600, pictureFileSize: picturefileSize, pictureWidth: pictureWidth, pictureHeight: pictureHeight, pictureTitle: nil, relatedLinks: twitCastRelatedLinks)
                twitParseCastDict.append(twitCast!)
            }
    }
        if Int(data.childrenCount) == twitParseCastDict.count {
            complete(twitParseCastDict)
            print("complete")
        }
    }

    
    
    func parseEpisode(data:FIRDataSnapshot, complete:([TwitEpisodeDetails]) -> ()) {
        
        let recentData = data.value as! [String : AnyObject]
        
        var twitParseEpisodeDict: [TwitEpisodeDetails] = []
        
        for recent in recentData {
            var twitEpisode:TwitEpisodeDetails?
            let label = recent.value["label"] as! String
            let ID = recent.value["id"] as! Int
            let created = recent.value["created"] as! String
            let episodeNumber = recent.value["episodeNumber"] as! String
            let showNotes = recent.value["showNotes"] as! String
            var teaser:String = ""
            if let teas =  recent.value["teaser"] as? String {
                teaser = teas
            }
            var showLabel:String?
            var showID:String?
            var showPicture:String?
            var showDict:TwitShowDetails?
            if let embedded = recent.value["embedded"] as? NSDictionary {
                if let showsDict = embedded.value(forKey: "shows") as? NSDictionary {
                    showDict = parseEpisodeShow(showData: showsDict)
                    showLabel = showsDict.value(forKey: "label") as! String
                  
                    showID = showsDict.value(forKey: "id") as! String
                    if let picDict = showsDict.value(forKey: "coverArt") as? NSDictionary {
                        showPicture = picDict.value(forKey: "fileName") as! String
                    }
                }
            } else if let showNotes = recent.value["showNotes"] as? String {
                if showNotes.lowercased().range(of: "Radio Tech") != nil {
                    showLabel = "This Week in Radio Tech"
                    showPicture = "twirt600"
                }
            } else {
                showLabel = "TWiT Bits & Specials"
                showPicture = "bits1400"
            }
            var videoArray:[TwitVideoDetails] = []
            var videoAudio:TwitVideoDetails?
            var videoHD:TwitVideoDetails?
            var videoLarge:TwitVideoDetails?
            var videoSmall:TwitVideoDetails?
            
            if let audioData = recent.value["video_audio"] as? NSDictionary {
                videoAudio = parseVideoData(data: audioData)
                videoArray.append(videoAudio!)
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
    
    func parseEpisodeShow(showData:NSDictionary) -> TwitShowDetails {
        
        var twitParseShowDict: [TwitShowDetails] = []
        var twitParseShowCastDict: [TwitCastDetails] = []
        var twitParseCastDict: [TwitCastDetails] = []
            
            //MARK: - Variables
            var showNotes = ""
            var showDate = ""
            
            var heroImageUrl = ""
            var heroImageID = ""
            var heroImageFileName = ""
            var heroImagetype = ""
            var heroImageSize = ""
            var heroImageWidth = ""
            var heroImageHeight = ""
            var heroImage1600 = ""
            var heroImage1200 = ""
            var heroImage800 = ""
            
            var coverArtUrl = ""
            var coverArtID = ""
            var coverArtFileName = ""
            var coverArttype = ""
            var coverArtSize = ""
            var coverArtWidth = ""
            var coverArtHeight = ""
            var coverArt2048 = ""
            var coverArt1400 = ""
            var coverArt600 = ""
            
            var twitCastLinks:TwitCastRelatedLinks?
            var twitCast:TwitCastDetails?
            var twitShow:TwitShowDetails?
            var showHero:ShowHeroImage?
            var showCover:ShowCoverImage?
            
            
            
            let ID = showData.value(forKey: "id") as! String //value["id") as! String
            let label = showData.value(forKey: "label") as! String
            let description = showData.value(forKey: "description") as! String
            if let showN = showData.value(forKey: "showNotes") as? String {
                showNotes = showN
            }
            if let showD = showData.value(forKey: "showDate") as? String {
                showDate = showD
            }
            let tagLine = showData.value(forKey: "tagLine") as! String
            let shortCode = showData.value(forKey: "shortCode") as! String
            let active = showData.value(forKey: "active") as! Bool
            
            if let heroImage = showData.value(forKey: "heroImage") as? NSDictionary {
                heroImageUrl = heroImage.value(forKey: "url") as! String
                heroImageID = heroImage.value(forKey: "fid") as! String
                heroImageFileName = heroImage.value(forKey: "fileName") as! String
                heroImagetype = heroImage.value(forKey: "urmimeTypel") as! String
                heroImageSize = heroImage.value(forKey: "fileSize") as! String
                heroImageWidth = heroImage.value(forKey: "width") as! String
                heroImageHeight = heroImage.value(forKey: "height") as! String
                if let derivatives = heroImage.value(forKey: "derivatives") as? NSDictionary {
                    heroImage1600 = derivatives.value(forKey: "twit_slideshow_1600x400") as! String
                    heroImage1200 = derivatives.value(forKey: "twit_slideshow_1200x300") as! String
                    heroImage800 = derivatives.value(forKey: "twit_slideshow_800x200") as! String
                }
                showHero = ShowHeroImage(heroImageFileName: heroImageFileName, heroImageFileSize: heroImageSize, heroImageFileID: heroImageID, heroImageHeight: heroImageHeight, heroImageWidth: heroImageWidth, heroImageUrl: heroImageUrl, heroImageType: heroImagetype, heroImage1600: heroImage1600, heroImage1200: heroImage1200, heroImage800: heroImage800)
            }
            
            if let coverArt = showData.value(forKey: "coverArt") as? NSDictionary {
                coverArtUrl = coverArt.value(forKey: "url") as! String
                coverArtFileName = coverArt.value(forKey: "fileName") as! String
                coverArtID = coverArt.value(forKey: "fid") as! String
                coverArttype = coverArt.value(forKey: "urmimeTypel") as! String
                coverArtSize = coverArt.value(forKey: "fileSize") as! String
                coverArtWidth = coverArt.value(forKey: "width") as! String
                coverArtHeight = coverArt.value(forKey: "height") as! String
                if let derivatives = coverArt.value(forKey: "derivatives") as? NSDictionary {
                    coverArt2048 = derivatives.value(forKey: "twit_album_art_2048x2048") as! String
                    coverArt1400 = derivatives.value(forKey: "twit_album_art_1400x1400") as! String
                    coverArt600 = derivatives.value(forKey: "twit_album_art_600x600") as! String
                }
                showCover = ShowCoverImage(coverArtFileName: coverArtFileName, coverArtFileSize: coverArtSize, coverArtFileID: coverArtID, coverArtHeight: coverArtHeight, coverArtWidth: coverArtWidth, coverArtUrl: coverArtUrl, coverArtType: coverArttype, coverArt2048: coverArt2048, coverArt1400: coverArt1400, coverArt600: coverArt600)
            }
            
            if let embedded = showData.value(forKey: "embedded") as? NSDictionary {
                if let credits = embedded.value(forKey: "credits") as? [String : AnyObject] {
                    for credit in credits {
                        if let people = credit.value["people"] as? NSDictionary {
                            
                            var castArt2048 = ""
                            var castArt1400 = ""
                            var castArt600 = ""
                            var picture = ""
                            var positionTitle = ""
                            var pictureFileName = ""
                            var pictureType = ""
                            var pictureUrlFull = ""
                            var picturefileSize = ""
                            var pictureWidth = ""
                            var pictureHeight = ""
                            var castBio = ""
                            
                            let castID = people.value(forKey: "id") as! String
                            let castLabel = people.value(forKey: "label") as! String
                            if let bio = people.value(forKey: "bio") as? String {
                                castBio = bio
                            }
                            let staff = people.value(forKey: "staff") as! Bool
                            if let picture = people.value(forKey: "picture") as? NSDictionary {
                                pictureFileName = picture.value(forKey: "fileName") as! String
                                pictureType = picture.value(forKey: "mimeType") as! String
                                pictureUrlFull = picture.value(forKey: "url") as! String
                                picturefileSize = picture.value(forKey: "fileSize") as! String
                                pictureWidth = picture.value(forKey: "width") as! String
                                pictureHeight = picture.value(forKey: "height") as! String
                                if let derivatives = picture.value(forKey: "derivatives") as? NSDictionary {
                                    castArt2048 = derivatives.value(forKey: "twit_album_art_2048x2048") as! String
                                    castArt1400 = derivatives.value(forKey: "twit_album_art_1400x1400") as! String
                                    castArt600 = derivatives.value(forKey: "twit_album_art_600x600") as! String
                                }
                            }
                            
                            if let relatedLinks = people.value(forKey: "relatedLinks") as? [String : AnyObject] {
                                for relatedLink in relatedLinks {
                                    let title = relatedLink.value["title"] as! String
                                    let url = relatedLink.value["url"] as! String
                                    twitCastLinks = TwitCastRelatedLinks.init(url: url, title: title)
                                    twitCastRelatedLinks.append(twitCastLinks!)
                                }
                            }
                            if twitCastRelatedLinks.count == 0 {
                                twitCast = TwitCastDetails.init(castID: castID, castLabel: castLabel, castBio: castBio, staff: staff, positionTitle: positionTitle, pictureFileName: pictureFileName, pictureFiletype: pictureType, pictureUrlFull: pictureUrlFull, pictureUrl1400: castArt2048, pictureUrl600: castArt1400, pictureUrl300: castArt600, pictureFileSize: picturefileSize, pictureWidth: pictureWidth, pictureHeight: pictureHeight, pictureTitle: nil, relatedLinks: nil)
                                twitParseCastDict.append(twitCast!)
                            } else {
                                twitCast = TwitCastDetails.init(castID: castID, castLabel: castLabel, castBio: castBio, staff: staff, positionTitle: positionTitle, pictureFileName: pictureFileName, pictureFiletype: pictureType, pictureUrlFull: pictureUrlFull, pictureUrl1400: castArt2048, pictureUrl600: castArt1400, pictureUrl300: castArt600, pictureFileSize: picturefileSize, pictureWidth: pictureWidth, pictureHeight: pictureHeight, pictureTitle: nil, relatedLinks: twitCastRelatedLinks)
                                twitParseCastDict.append(twitCast!)
                            }
                        }
                    }
                }
            }
            if showHero != nil || showCover != nil {
                twitShow = TwitShowDetails(label: label, showID: ID, description: description, active: active, shortCode: shortCode, showContactInfo: nil, showDate: showDate, tagline: tagLine, showHeroImage: showHero, showCoverImage: showCover, categoryID: nil, categoryLabel: nil, topicsID: nil, topicsLabel: nil, twitCastDetails: twitParseCastDict)
            } else if showHero != nil {
                twitShow = TwitShowDetails(label: label, showID: ID, description: description, active: active, shortCode: shortCode, showContactInfo: nil, showDate: showDate, tagline: tagLine, showHeroImage: showHero, showCoverImage: nil, categoryID: nil, categoryLabel: nil, topicsID: nil, topicsLabel: nil, twitCastDetails: twitParseCastDict)
            } else if showCover != nil {
                twitShow = TwitShowDetails(label: label, showID: ID, description: description, active: active, shortCode: shortCode, showContactInfo: nil, showDate: showDate, tagline: tagLine, showHeroImage: nil, showCoverImage: showCover, categoryID: nil, categoryLabel: nil, topicsID: nil, topicsLabel: nil, twitCastDetails: twitParseCastDict)
            } else {
                twitShow = TwitShowDetails(label: label, showID: ID, description: description, active: active, shortCode: shortCode, showContactInfo: nil, showDate: showDate, tagline: tagLine, showHeroImage: nil, showCoverImage: nil, categoryID: nil, categoryLabel: nil, topicsID: nil, topicsLabel: nil, twitCastDetails: twitParseCastDict)
            }
        
        return twitShow!
        }
}
