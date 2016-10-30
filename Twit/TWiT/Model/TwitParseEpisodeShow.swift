//
//  TwitParseEpisodeShow.swift
//  TWiT
//
//  Created by Corey Baines on 15/10/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import Firebase

extension TwitEpisodeParse {
    
    
    func parseEpisodeShow(showData:NSDictionary) -> TwitShowDetails {
        
        var twitParseShowDict: [TwitShowDetails] = []
        var twitParseShowCastDict: [TwitCastDetails] = []
        var twitParseCastDict: [TwitCastDetails] = []
        let showOffers = showData.value(forKey: "offers") as? NSArray
        let showInfo = showData.value(forKey: "info") as! NSDictionary
        
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
        
        
        let ID = showInfo.value(forKey: "id") as! String //value["id") as! String
        let label = showInfo.value(forKey: "label") as! String
        let description = showInfo.value(forKey: "description") as! String
        if let showN = showInfo.value(forKey: "showNotes") as? String {
            showNotes = showN
        }
        if let showD = showInfo.value(forKey: "showDate") as? String {
            showDate = showD
        }
        let tagLine = showInfo.value(forKey: "tagLine") as! String
        let shortCode = showInfo.value(forKey: "shortCode") as! String
        let active = showInfo.value(forKey: "active") as! Bool
        
        if let heroImage = showInfo.value(forKey: "heroImage") as? NSDictionary {
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
        
        if let coverArt = showInfo.value(forKey: "coverArt") as? NSDictionary {
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
        
        if let showCast = showData.value(forKey: "people") as? NSDictionary {
            twitParseShowCastDict = parseCast(rawData: showCast)
        }
        print(twitParseShowCastDict.count)
        if showHero != nil || showCover != nil {
            twitShow = TwitShowDetails(label: label, showID: ID, description: description, active: active, shortCode: shortCode, showContactInfo: nil, showDate: showDate, tagline: tagLine, showHeroImage: showHero, showCoverImage: showCover, categoryID: nil, categoryLabel: nil, topicsID: nil, topicsLabel: nil, twitCastDetails: twitParseShowCastDict, showSeasonInfo: nil, showOffersInfo: showOffers)
        } else if showHero != nil {
            twitShow = TwitShowDetails(label: label, showID: ID, description: description, active: active, shortCode: shortCode, showContactInfo: nil, showDate: showDate, tagline: tagLine, showHeroImage: showHero, showCoverImage: nil, categoryID: nil, categoryLabel: nil, topicsID: nil, topicsLabel: nil, twitCastDetails: twitParseShowCastDict, showSeasonInfo: nil, showOffersInfo: showOffers)
        } else if showCover != nil {
            twitShow = TwitShowDetails(label: label, showID: ID, description: description, active: active, shortCode: shortCode, showContactInfo: nil, showDate: showDate, tagline: tagLine, showHeroImage: nil, showCoverImage: showCover, categoryID: nil, categoryLabel: nil, topicsID: nil, topicsLabel: nil, twitCastDetails: twitParseShowCastDict, showSeasonInfo: nil, showOffersInfo: showOffers)
        } else {
            twitShow = TwitShowDetails(label: label, showID: ID, description: description, active: active, shortCode: shortCode, showContactInfo: nil, showDate: showDate, tagline: tagLine, showHeroImage: nil, showCoverImage: nil, categoryID: nil, categoryLabel: nil, topicsID: nil, topicsLabel: nil, twitCastDetails: twitParseShowCastDict, showSeasonInfo: nil, showOffersInfo: showOffers)
        }
        
        return twitShow!
    }

    
}


