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
    private var _label:String!
    private var _ID:Int!
    private var _created:String!
    private var _episodeNumber:String?
    private var _showNotes:String?
    private var _showLabel:String?
    private var _showPicture:String?
    private var _showDetails:TwitShowDetails?
    private var _videoArray:[TwitVideoDetails]?
    
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
    
    var showDetails:TwitShowDetails {
        get {
            if _showDetails == nil {
                return TwitShowDetails(label: "", showID: "", description: "", active: nil, shortCode: nil, showContactInfo: nil, showDate: nil, tagline: nil, showHeroImage: nil, showCoverImage: nil, categoryID: nil, categoryLabel: nil, topicsID: nil, topicsLabel: nil, twitCastDetails: nil, showSeasonInfo: nil, showOffersInfo: nil)
            }
            return _showDetails!
        }
    }

    init(label:String, ID:Int, created:String, episodeNumber:String?, showNotes:String?, showLabel:String?, showPicture:String?, videoArray:[TwitVideoDetails]?, showDetails:TwitShowDetails?) {
        _label = label
        _ID = ID
        _created = created
        _episodeNumber = episodeNumber
        _showNotes = showNotes
        _showLabel = showLabel
        _showPicture = showPicture
        _showDetails = showDetails
        _videoArray = videoArray
    }
    
}

struct ShowHeroImage {
    private var _heroImageFileName:String?
    private var _heroImageFileSize:String?
    private var _heroImageFileID:String?
    private var _heroImageHeight:String?
    private var _heroImageWidth:String?
    private var _heroImageUrl:String?
    private var _heroImageType:String?
    private var _heroImage1600:String?
    private var _heroImage1200:String?
    private var _heroImage800:String?
    
    
    var heroImageFileName:String {
        get {
            if _heroImageFileName == nil {
                return ""
            }
            return _heroImageFileName!
        }
    }
    
    var heroImageFileSize:String {
        get {
            if _heroImageFileSize == nil {
                return ""
            }
            return _heroImageFileSize!
        }
    }
    
    var heroImageFileID:String {
        get {
            if _heroImageFileID == nil {
                return ""
            }
            return _heroImageFileID!
        }
    }
    
    var heroImageHeight:String {
        get {
            if _heroImageHeight == nil {
                return ""
            }
            return _heroImageHeight!
        }
    }
    
    var heroImageWidth:String {
        get {
            if _heroImageWidth == nil {
                return ""
            }
            return _heroImageWidth!
        }
    }
    
    var heroImageUrl:String {
        get {
            if _heroImageUrl == nil {
                return ""
            }
            return _heroImageUrl!
        }
    }
    
    var heroImageType:String {
        get {
            if _heroImageType == nil {
                return ""
            }
            return _heroImageType!
        }
    }
    
    var heroImage1600:String {
        get {
            if _heroImage1600 == nil {
                return ""
            }
            return _heroImage1600!
        }
    }
    
    var heroImage1200:String {
        get {
            if _heroImage1200 == nil {
                return ""
            }
            return _heroImage1200!
        }
    }
    
    var heroImage800:String {
        get {
            if _heroImage800 == nil {
                return ""
            }
            return _heroImage800!
        }
    }
    
    init(heroImageFileName:String?, heroImageFileSize:String?, heroImageFileID:String?, heroImageHeight:String?, heroImageWidth:String?, heroImageUrl:String?, heroImageType:String?, heroImage1600:String?, heroImage1200:String?, heroImage800:String?) {
        _heroImageFileName = heroImageFileName
        _heroImageFileSize = heroImageFileSize
        _heroImageFileID = heroImageFileID
        _heroImageHeight = heroImageHeight
        _heroImageWidth = heroImageWidth
        _heroImageUrl = heroImageUrl
        _heroImageType = heroImageType
        _heroImage1600 = heroImage1600
        _heroImage1200 = heroImage1200
        _heroImage800 = heroImage800
    }
}

struct ShowCoverImage {
    private var _coverArtFileName:String?
    private var _coverArtFileSize:String?
    private var _coverArtFileID:String?
    private var _coverArtHeight:String?
    private var _coverArtWidth:String?
    private var _coverArtUrl:String?
    private var _coverArtType:String?
    private var _coverArt2048:String?
    private var _coverArt1400:String?
    private var _coverArt600:String?
    
    var coverArtFileName:String {
        get {
            if _coverArtFileName == nil {
                return ""
            }
            return _coverArtFileName!
        }
    }
    
    var coverArtFileSize:String {
        get {
            if _coverArtFileSize == nil {
                return ""
            }
            return _coverArtFileSize!
        }
    }
    
    var coverArtFileID:String {
        get {
            if _coverArtFileID == nil {
                return ""
            }
            return _coverArtFileID!
        }
    }
    
    var coverArtHeight:String {
        get {
            if _coverArtHeight == nil {
                return ""
            }
            return _coverArtHeight!
        }
    }
    
    var coverArtWidth:String {
        get {
            if _coverArtWidth == nil {
                return ""
            }
            return _coverArtWidth!
        }
    }
    
    var coverArtUrl:String {
        get {
            if _coverArtUrl == nil {
                return ""
            }
            return _coverArtUrl!
        }
    }
    
    var coverArtType:String {
        get {
            if _coverArtType == nil {
                return ""
            }
            return _coverArtType!
        }
    }
    
    var coverArt2048:String {
        get {
            if _coverArt2048 == nil {
                return ""
            }
            return _coverArt2048!
        }
    }
    
    var coverArt1400:String {
        get {
            if _coverArt1400 == nil {
                return ""
            }
            return _coverArt1400!
        }
    }
    
    var coverArt600:String {
        get {
            if _coverArt600 == nil {
                return ""
            }
            return _coverArt600!
        }
    }

    
    init(coverArtFileName:String?, coverArtFileSize:String?, coverArtFileID:String?, coverArtHeight:String?, coverArtWidth:String?, coverArtUrl:String?, coverArtType:String?, coverArt2048:String?, coverArt1400:String?, coverArt600:String?) {
        _coverArtFileName = coverArtFileName
        _coverArtFileSize = coverArtFileSize
        _coverArtFileID = coverArtFileID
        _coverArtHeight = coverArtHeight
        _coverArtWidth = coverArtWidth
        _coverArtUrl = coverArtUrl
        _coverArtType = coverArtType
        _coverArt2048 = coverArt2048
        _coverArt1400 = coverArt1400
        _coverArt600 = coverArt600
    }
}

struct TwitShowDetails {
    private var _label:String!
    private var _ID:String!
    private var _description:String!
    private var _active:Bool?
    private var _shortCode:String?
    private var _showContactInfo:String?
    private var _showDate:String?
    private var _tagline:String?
    private var _categoryID:Int?
    private var _categoryLabel:String?
    private var _topicsID:Int?
    private var _topicsLabel:String?
    private var _twitCastDetails:[TwitCastDetails]?
    private var _showSeasonInfo:NSArray?
    private var _showOffersInfo:NSArray?
    private var _showHeroImage: ShowHeroImage?
    private var _showCoverImage: ShowCoverImage?
    
    var label:String {
        get {
            return _label
        }
    }
    
    var ID:String {
        get {
            return _ID
        }
    }
    
    var description:String {
        get {
            return _description
        }
    }
    
    var active:Bool {
        get {
            if _active == nil {
                return false
            }
            return _active!
        }
    }
    
    var shortCode:String {
        get {
            if _shortCode == nil {
                return ""
            }
            return _shortCode!
        }
    }
    
    var showContactInfo:String {
        get {
            if _showContactInfo == nil {
                return ""
            }
            return _showContactInfo!
        }
    }
    
    var showDate:String {
        get {
            if _showDate == nil {
                return ""
            }
            return _showDate!
        }
    }
    
    var tagline:String {
        get {
            if _tagline == nil {
                return ""
            }
            return _tagline!
        }
    }
    
    var categoryID:Int {
        get {
            if _categoryID == nil {
                return 0
            }
            return _categoryID!
        }
    }
    
    var categoryLabel:String {
        get {
            if _categoryLabel == nil {
                return ""
            }
            return _categoryLabel!
        }
    }
    
    var topicsID:Int {
        get {
            if _topicsID == nil {
                return 0
            }
            return _topicsID!
        }
    }
    
    var topicsLabel:String {
        get {
            if _topicsLabel == nil {
                return ""
            }
            return _topicsLabel!
        }
    }
    
    var showSeasonInfo:NSArray {
        get {
            if _showSeasonInfo == nil {
                return []
            }
            return _showSeasonInfo!
        }
    }
    
    var showOffersInfo:NSArray {
        get {
            if _showOffersInfo == nil {
                return []
            }
            return _showOffersInfo!
        }
    }
    
    var twitCastDetails:[TwitCastDetails] {
        get {
            if _twitCastDetails == nil {
                return [TwitCastDetails(castID: "", castLabel: "", castBio: "", staff: false, positionTitle: nil, pictureFileName: nil, pictureFiletype: nil, pictureUrlFull: nil, pictureUrl1400: nil, pictureUrl600: nil, pictureUrl300: nil, pictureFileSize: nil, pictureWidth: nil, pictureHeight: nil, pictureTitle: nil, relatedLinks: nil)]
            }
            return _twitCastDetails!
        }
    }
    
    var showHeroImage:ShowHeroImage {
        get {
            if _showHeroImage == nil {
                return ShowHeroImage(heroImageFileName: nil, heroImageFileSize: nil, heroImageFileID: nil, heroImageHeight: nil, heroImageWidth: nil, heroImageUrl: nil, heroImageType: nil, heroImage1600: nil, heroImage1200: nil, heroImage800: nil)
            }
            return _showHeroImage!
        }
    }
    
    var showCoverImage:ShowCoverImage {
        get {
            if _showCoverImage == nil {
                return ShowCoverImage(coverArtFileName: nil, coverArtFileSize: nil, coverArtFileID: nil, coverArtHeight: nil, coverArtWidth: nil, coverArtUrl: nil, coverArtType: nil, coverArt2048: nil, coverArt1400: nil, coverArt600: nil)
            }
            return _showCoverImage!
        }
    }
    
    init(label:String, showID:String, description:String, active:Bool?, shortCode:String?, showContactInfo:String?, showDate:String?, tagline:String?, showHeroImage:ShowHeroImage?, showCoverImage:ShowCoverImage?, categoryID:Int?, categoryLabel:String?, topicsID:Int?, topicsLabel:String?, twitCastDetails:[TwitCastDetails]?, showSeasonInfo:NSArray?, showOffersInfo:NSArray?) {
        _label = label
        _ID = showID
        _description = description
        _active = active
        _shortCode = shortCode
        _showContactInfo = showContactInfo
        _showDate = showDate
        _tagline = tagline
        _categoryID = categoryID
        _categoryLabel = categoryLabel
        _topicsID = topicsID
        _topicsLabel = topicsLabel
        _twitCastDetails = twitCastDetails
        _showHeroImage = showHeroImage
        _showCoverImage = showCoverImage
        _showSeasonInfo = showSeasonInfo
        _showOffersInfo = showOffersInfo
    }
    
}


struct TwitVideoDetails {
    private var _format:String!
    private var _mediaUrl:String!
    private var _runningTime:Date!
    private var _hours:Int!
    private var _minutes:Int!
    private var _seconds:Int!
    private var _size:Int!
    
    var format:String {
        get {
            return _format
        }
    }
    
    var mediaUrl:String {
        get {
            return _mediaUrl
        }
    }
    
    var runningTime:Date {
        get {
            return _runningTime
        }
    }
    
    var hours:Int {
        get {
            return _hours
        }
    }
    
    var minutes:Int {
        get {
            return _minutes
        }
    }
    
    var seconds:Int {
        get {
            return _seconds
        }
    }
    
    var size:Int {
        get {
            return _size
        }
    }

    
    init(formatString:String, mediaUrlString:String, runningTimeString:String, hoursString:String, minutesString:String, secondsString:String, sizeString:String) {
        _format = formatString
        _mediaUrl = mediaUrlString
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateFormat = "k:mm:ss" // k = Hour in 1~24, mm = Minute
        _runningTime = dateFormatter.date(from: runningTimeString)
        _hours = Int(hoursString)
        _minutes = Int(minutesString)
        _seconds = Int(secondsString)
        _size = Int(sizeString)
    }
}

struct TwitCastDetails {
    private var _castID:String!
    private var _castLabel:String!
    private var _castBio:String!
    private var _staff:Bool!
    private var _positionTitle:String?
    private var _pictureFileName:String?
    private var _pictureFiletype:String?
    private var _pictureUrlFull:String?
    private var _pictureUrl1400:String?
    private var _pictureUrl600:String?
    private var _pictureUrl300:String?
    private var _pictureFileSize:String?
    private var _pictureWidth:String?
    private var _pictureHeight:String?
    private var _pictureTitle:String?
    private var _relatedLinks:[TwitCastRelatedLinks]?
    
    var castID:String {
        get {
            return _castID
        }
    }
    
    var castLabel:String {
        get {
            return _castLabel
        }
    }
    
    var castBio:String {
        get {
            return _castBio
        }
    }
    
    var staff:Bool {
        get {
            return _staff
        }
    }
    
    var positionTitle:String {
        get {
            if _positionTitle == nil {
                return ""
            }
            return _positionTitle!
        }
    }
    
    var pictureFileName:String {
        get {
            if _pictureFileName == nil {
                return ""
            }
            return _pictureFileName!
        }
    }
    
    var pictureFiletype:String {
        get {
            if _pictureFiletype == nil {
                return ""
            }
            return _pictureFiletype!
        }
    }
    
    var pictureUrlFull:String {
        get {
            if _pictureUrlFull == nil {
                return ""
            }
            return _pictureUrlFull!
        }
    }
    
    var pictureUrl1400:String {
        get {
            if _pictureUrl1400 == nil {
                return ""
            }
            return _pictureUrl1400!
        }
    }
    
    var pictureUrl600:String {
        get {
            if _pictureUrl600 == nil {
                return ""
            }
            return _pictureUrl600!
        }
    }
    
    var pictureUrl300:String {
        get {
            if _pictureUrl300 == nil {
                return ""
            }
            return _pictureUrl300!
        }
    }
    
    var pictureFileSize:String {
        get {
            if _pictureFileSize == nil {
                return ""
            }
            return _pictureFileSize!
        }
    }
    
    var pictureWidth:String {
        get {
            if _pictureWidth == nil {
                return ""
            }
            return _pictureWidth!
        }
    }
    
    var pictureHeight:String {
        get {
            if _pictureHeight == nil {
                return ""
            }
            return _pictureHeight!
        }
    }
    
    var pictureTitle:String {
        get {
            if _pictureTitle == nil {
                return ""
            }
            return _pictureTitle!
        }
    }
    
    var relatedLinks:[TwitCastRelatedLinks] {
        get {
            if _relatedLinks == nil {
                return [TwitCastRelatedLinks(url:"", title:"")]
            }
            return _relatedLinks!
        }
    }
    
    init(castID:String, castLabel:String, castBio:String, staff:Bool, positionTitle:String?, pictureFileName:String?, pictureFiletype:String?, pictureUrlFull:String?, pictureUrl1400:String?, pictureUrl600:String?, pictureUrl300:String?, pictureFileSize:String?, pictureWidth:String?, pictureHeight:String?, pictureTitle:String?, relatedLinks:[TwitCastRelatedLinks]?) {
        _castID = castID
        _castBio = castBio
        _castLabel = castLabel
        _staff = staff
        _positionTitle = positionTitle
        _pictureFileName = pictureFileName
        _pictureFiletype = pictureFiletype
        _pictureUrlFull = pictureUrlFull
        _pictureUrl1400 = pictureUrl1400
        _pictureUrl600 = pictureUrl600
        _pictureUrl300 = pictureUrl300
        _pictureFileSize = pictureFileSize
        _pictureWidth = pictureWidth
        _pictureHeight = pictureHeight
        _pictureTitle = pictureTitle
        _relatedLinks = relatedLinks
    }
}


struct TwitCastRelatedLinks {
    private var _url:String!
    private var _title:String!
    
    var url:String {
        get {
            return _url
        }
    }
    
    var title:String {
        get {
            return _title
        }
    }
    
    init(url:String, title:String) {
        _url = url
        _title = title
    }
}

