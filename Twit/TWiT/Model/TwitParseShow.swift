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
            
            let showValue = show.value["info"] as! NSDictionary
            let showOffers = show.value["offers"] as? NSArray
            let showSeasons = show.value["seasons"] as? NSArray
            
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
            
            
            
            let ID = showValue.value(forKey: "id") as! String
            let label = showValue.value(forKey: "label") as! String
            let description = showValue.value(forKey: "description") as! String
            if showValue.value(forKey: "showNotes") as? String != nil {
                showNotes = showValue.value(forKey: "showNotes") as! String
            }
            if showValue.value(forKey: "showDate") as? String != nil {
                showNotes = showValue.value(forKey: "showDate") as! String
            }
            let tagLine = showValue.value(forKey: "tagLine") as! String
            let shortCode = showValue.value(forKey: "shortCode") as! String
            let active = showValue.value(forKey: "active") as! Bool
            
            if let heroImage = showValue.value(forKey: "heroImage") as? NSDictionary {
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
            
            if let coverArt = showValue.value(forKey: "coverArt") as? NSDictionary {
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
            
            if let showCast = show.value["people"] as? NSArray {
                twitParseShowCastDict = parseCast(data: showCast)
            }
            
            if showHero != nil || showCover != nil || showOffers != nil {
                twitShow = TwitShowDetails(label: label, showID: ID, description: description, active: active, shortCode: shortCode, showContactInfo: nil, showDate: showDate, tagline: tagLine, showHeroImage: showHero, showCoverImage: showCover, categoryID: nil, categoryLabel: nil, topicsID: nil, topicsLabel: nil, twitCastDetails: twitParseShowCastDict, showSeasonInfo: showSeasons, showOffersInfo: showOffers)
            } else if showHero != nil {
                twitShow = TwitShowDetails(label: label, showID: ID, description: description, active: active, shortCode: shortCode, showContactInfo: nil, showDate: showDate, tagline: tagLine, showHeroImage: showHero, showCoverImage: nil, categoryID: nil, categoryLabel: nil, topicsID: nil, topicsLabel: nil, twitCastDetails: twitParseShowCastDict, showSeasonInfo: showSeasons, showOffersInfo: nil)
            } else if showCover != nil {
                twitShow = TwitShowDetails(label: label, showID: ID, description: description, active: active, shortCode: shortCode, showContactInfo: nil, showDate: showDate, tagline: tagLine, showHeroImage: nil, showCoverImage: showCover, categoryID: nil, categoryLabel: nil, topicsID: nil, topicsLabel: nil, twitCastDetails: twitParseShowCastDict, showSeasonInfo: showSeasons, showOffersInfo: nil)
            } else if showOffers != nil {
                twitShow = TwitShowDetails(label: label, showID: ID, description: description, active: active, shortCode: shortCode, showContactInfo: nil, showDate: showDate, tagline: tagLine, showHeroImage: nil, showCoverImage: nil, categoryID: nil, categoryLabel: nil, topicsID: nil, topicsLabel: nil, twitCastDetails: twitParseShowCastDict, showSeasonInfo: showSeasons, showOffersInfo: showOffers)
            } else {
                twitShow = TwitShowDetails(label: label, showID: ID, description: description, active: active, shortCode: shortCode, showContactInfo: nil, showDate: showDate, tagline: tagLine, showHeroImage: nil, showCoverImage: nil, categoryID: nil, categoryLabel: nil, topicsID: nil, topicsLabel: nil, twitCastDetails: twitParseShowCastDict, showSeasonInfo: showSeasons, showOffersInfo: nil)
            }
            twitParseShowDict.append(twitShow!)
        }
        if Int(data.childrenCount) == twitParseShowDict.count {
            complete(twitParseShowDict)
            print("complete")
        }
    }
    
    func parseCast(data:NSArray) -> [TwitCastDetails] {
        
        var twitParseShowCastDict: [TwitCastDetails] = []
        
        for people in data {
            
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
            var twitCastLinks:TwitCastRelatedLinks?
            var twitCast:TwitCastDetails?
            
            let showPeople = people as! NSDictionary
            
            let castID = showPeople.value(forKey: "id") as! String
            let castLabel = showPeople.value(forKey: "label") as! String
            if let bio = showPeople.value(forKey: "bio") as? String {
                castBio = bio
            }
            let staff = showPeople.value(forKey: "staff") as! Bool
            if let picture = showPeople.value(forKey: "picture") as? NSDictionary {
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
            
            if let relatedLinks = showPeople.value(forKey: "relatedLinks") as? [String : AnyObject] {
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
        return twitParseShowCastDict
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
