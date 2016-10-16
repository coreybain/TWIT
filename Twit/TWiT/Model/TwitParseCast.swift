//
//  TwitParseCast.swift
//  TWiT
//
//  Created by Corey Baines on 15/10/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import Firebase

extension TwitEpisodeParse {
    
    func parseCast(data:FIRDataSnapshot, complete:([TwitCastDetails]) -> ()) {
        let castData = data.value as! [String : AnyObject]
        
        var twitParseCastDict: [TwitCastDetails] = []
        
        for show in castData {
            var twitCastLinks:TwitCastRelatedLinks?
            var twitCast:TwitCastDetails?
            let showValue = show.value["info"] as! NSDictionary
            
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
            
            let castID = showValue.value(forKey: "id") as! String
            let castLabel = showValue.value(forKey: "label") as! String
            if let bio = showValue.value(forKey: "bio") as? String {
                castBio = bio
            }
            let staff = showValue.value(forKey: "staff") as! Bool
            if let picture = showValue.value(forKey: "picture") as? NSDictionary {
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
            
            if let relatedLinks = showValue.value(forKey: "relatedLinks") as? [String : AnyObject] {
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

}
