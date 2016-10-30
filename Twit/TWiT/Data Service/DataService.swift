//
//  DataService.swift
//  TWiT
//
//  Created by Corey Baines on 25/9/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import Firebase
import CoreData
import Alamofire

class DataService {
    
    static let shared = DataService()
    
    static func ds() -> DataService {
        return shared
    }
    
    //MARK: -- Variables:
    let twitEpisodeParse = TwitEpisodeParse()
    
    //MARK: - Firebase Variables:
    var ref = FIRDatabase.database().reference()
    
    //MARK: - Firebase Data:
    var newReleaseData: [TwitEpisodeDetails]!
    var trendingEpisodesData: [TwitEpisodeDetails]!
    var showOffersData: [TwitOfferDetails]!
    var newEpisodeData: [TwitEpisodeDetails]!
    var activeShowData: [TwitShowDetails]!
    var pastShowData: [TwitShowDetails]!
    var newReviewData: [TwitEpisodeDetails]!
    var newTwitBitsData: [TwitEpisodeDetails] = []
    var newHelpData: [TwitEpisodeDetails]!
    var activeCastData: [TwitCastDetails]!
    
    func downloadFeaturedPage(downloadComplete:@escaping (_ newReleaseData:[TwitEpisodeDetails]?, _ newEpisodeData:[TwitEpisodeDetails]?, _ activeShowData:[TwitShowDetails]?, _ pastShowData:[TwitShowDetails]?, _ newReviewData:[TwitEpisodeDetails]?, _ newTwitBitsData:[TwitEpisodeDetails]?, _ newHelpData:[TwitEpisodeDetails]?, _ activeCastData:[TwitCastDetails]?) -> ()) {
        
        Alamofire.request(API.mainData(uuid: UIDevice.current.identifierForVendor!.uuidString)).responseJSON { response in
           // print(response)
            switch response.result {
            case .success( _):
                if let mainData = response.result.value as? NSDictionary {
                    if let allEpisodes = mainData.value(forKey: "allepisodes") as? NSArray {
                        print("MADE IT")
                        self.twitEpisodeParse.parseEpisode(data: allEpisodes, complete: { (data, offData) in
                            
                            print("NEW EPISODES")
                            if self.newEpisodeData == nil || self.activeCastData == nil || self.pastShowData == nil || self.activeShowData == nil || self.newReviewData == nil || self.newHelpData == nil {
                                self.newReleaseData = data
                                print("Still downloading over episodes")
                                
                            } else {
                                self.newReleaseData = data
                                print("Download complete and ready for processing")
                                
                                downloadComplete(self.newReleaseData, self.newEpisodeData, self.activeShowData, self.pastShowData, self.newReviewData, self.newTwitBitsData, self.newHelpData, self.activeCastData)
                                //downloadComplete(nil)
                            }
                        })
                    }
                    
                    if let newsCat = mainData.value(forKey: "newsCat") as? NSArray {
                        print("MADE IT")
                        self.twitEpisodeParse.parseEpisode(data: newsCat, complete: { (data, offData) in
                            
                            print("NEW EPISODES FROM NEWS CATEGORY")
                            if self.newReleaseData == nil || self.activeCastData == nil || self.activeShowData == nil || self.pastShowData == nil || self.newReviewData == nil || self.newHelpData == nil {
                                self.newEpisodeData = data
                                
                                print("Still downloading over episodes")
                            } else {
                                self.newEpisodeData = data
                                print("Download complete and ready for processing")
                                
                                downloadComplete(self.newReleaseData, self.newEpisodeData, self.activeShowData, self.pastShowData, self.newReviewData, self.newTwitBitsData, self.newHelpData, self.activeCastData)
                                //downloadComplete(nil)
                            }
                        })
                    }
                    
                    if let reviewCat = mainData.value(forKey: "reviewCat") as? NSArray {
                        print("MADE IT")
                        self.twitEpisodeParse.parseEpisode(data: reviewCat, complete: { (data, offData) in
                            
                            print("NEW EPISODES FROM REVIEW CATEGORY")
                            if self.newReleaseData == nil || self.activeCastData == nil || self.newEpisodeData == nil || self.pastShowData == nil || self.activeShowData == nil || self.newHelpData == nil {
                                self.newReviewData = data
                                print("Still downloading over episodes")
                            } else {
                                self.newReviewData = data
                                print("Download complete and ready for processing")
                                
                                downloadComplete(self.newReleaseData, self.newEpisodeData, self.activeShowData, self.pastShowData, self.newReviewData, self.newTwitBitsData, self.newHelpData, self.activeCastData)
                                //downloadComplete(nil)
                            }
                        })
                    }
                    
                    if let bitCat = mainData.value(forKey: "bitCat") as? NSArray {
                        print("MADE IT")
                        self.twitEpisodeParse.parseEpisode(data: bitCat, complete: { (data, offData) in
                            
                            print("NEW EPISODES FROM TWIT BITS CATEGORY")
                            if self.newReleaseData == nil || self.activeCastData == nil || self.newEpisodeData == nil || self.pastShowData == nil || self.activeShowData == nil || self.newReviewData == nil || self.newHelpData == nil {
                                self.newTwitBitsData = data
                                print("Still downloading over episodes")
                            } else {
                                self.newTwitBitsData = data
                                print("Download complete and ready for processing")
                                
                                downloadComplete(self.newReleaseData, self.newEpisodeData, self.activeShowData, self.pastShowData, self.newReviewData, self.newTwitBitsData, self.newHelpData, self.activeCastData)
                                //downloadComplete(nil)
                            }
                        })
                    }
                    
                    if let howCat = mainData.value(forKey: "howCat") as? NSArray {
                        print("MADE IT")
                        self.twitEpisodeParse.parseEpisode(data: howCat, complete: { (data, offData) in
                            
                            print("NEW EPISODES FROM HOW-TO CATEGORY")
                            if self.newReleaseData == nil || self.activeCastData == nil || self.newEpisodeData == nil || self.pastShowData == nil || self.activeShowData == nil || self.newReviewData == nil {
                                self.newHelpData = data
                                print("Still downloading over episodes")
                            } else {
                                self.newHelpData = data
                                print("Download complete and ready for processing")
                                
                                downloadComplete(self.newReleaseData, self.newEpisodeData, self.activeShowData, self.pastShowData, self.newReviewData, self.newTwitBitsData, self.newHelpData, self.activeCastData)
                                //downloadComplete(nil)
                            }
                        })
                    }
                    
                    if let activeShows = mainData.value(forKey: "activeShows") as? NSArray {
                        print("MADE IT")
                        self.twitEpisodeParse.parseShow(data: activeShows, complete: { (data) in
                            
                            print("ACTIVE SHOWS")
                            if self.newReleaseData == nil || self.activeCastData == nil || self.newEpisodeData == nil || self.pastShowData == nil || self.newReviewData == nil || self.newHelpData == nil {
                                self.activeShowData = data
                                print("Still downloading over episodes")
                            } else {
                                self.activeShowData = data
                                print("Download complete and ready for processing")
                                
                                downloadComplete(self.newReleaseData, self.newEpisodeData, self.activeShowData, self.pastShowData, self.newReviewData, self.newTwitBitsData, self.newHelpData, self.activeCastData)
                            }
                        })
                    }
                    
                    if let pastShows = mainData.value(forKey: "pastShows") as? NSArray {
                        print("MADE IT")
                        self.twitEpisodeParse.parseShow(data: pastShows, complete: { (data) in
                            
                            print("PAST SHOWS")
                            if self.newReleaseData == nil || self.activeCastData == nil || self.newEpisodeData == nil || self.activeShowData == nil || self.newReviewData == nil || self.newHelpData == nil {
                                self.pastShowData = data
                                print("Still downloading over episodes")
                            } else {
                                self.pastShowData = data
                                print("Download complete and ready for processing")
                                
                                downloadComplete(self.newReleaseData, self.newEpisodeData, self.activeShowData, self.pastShowData, self.newReviewData, self.newTwitBitsData, self.newHelpData, self.activeCastData)
                            }
                        })
                    }
                    
                    if let people = mainData.value(forKey: "people") as? NSArray {
                        print("MADE IT")
                        self.twitEpisodeParse.parseCast(data: people, complete: { (data) in
                            print("CAST MEMBERS")
                            if self.newReleaseData == nil || self.newEpisodeData == nil || self.activeShowData == nil || self.pastShowData == nil || self.newReviewData == nil || self.newHelpData == nil {
                                self.activeCastData = data
                                print("Still downloading over episodes")
                            } else {
                                self.activeCastData = data
                                print("Download complete and ready for processing")
                                downloadComplete(self.newReleaseData, self.newEpisodeData, self.activeShowData, self.pastShowData, self.newReviewData, self.newTwitBitsData, self.newHelpData, self.activeCastData)
                            }
                        })
                    }
                }
            case .failure(let error):
                print("There was an error download: -- \(error)")
            }
        }
    }
    
    func downloadSeasonShowPage(showID:String, downloadComplete:@escaping (_ newReleaseData:[TwitEpisodeDetails]?, _ trendingEpisodesData:[TwitEpisodeDetails]?, _ showOffers:[TwitOfferDetails]?) -> ()) {
        
        Alamofire.request(API.seasonData(uuid: UIDevice.current.identifierForVendor!.uuidString, showID: showID)).responseJSON { response in
            // print(response)
            switch response.result {
            case .success( _):
                
                if let mainData = response.result.value as? NSDictionary {
                    if let allEpisodes = mainData.value(forKey: "newEpisodes") as? NSArray {
                        print("MADE IT")
                        self.twitEpisodeParse.parseSeasonEpisode(data: allEpisodes, complete: { (data, offData) in
                            
                            print("NEW EPISODES")
                            if self.trendingEpisodesData == nil {
                                self.newReleaseData = data
                                self.showOffersData = offData
                                print("Still downloading over episodes")
                                
                            } else {
                                self.newReleaseData = data
                                self.showOffersData = offData
                                print("Download complete and ready for processing")
                                
                                downloadComplete(self.newReleaseData, self.trendingEpisodesData, self.showOffersData)
                                //downloadComplete(nil)
                            }
                        })
                    }
                    
                    if let trendingEpisodes = mainData.value(forKey: "trendingEpisodes") as? NSArray {
                        print("MADE IT")
                        self.twitEpisodeParse.parseSeasonEpisode(data: trendingEpisodes, complete: { (data, offData) in
                            
                            print("TRENDING EPISODES")
                            if self.newReleaseData == nil {
                                self.trendingEpisodesData = data
                                print("Still downloading over episodes")
                                
                            } else {
                                self.trendingEpisodesData = data
                                print("Download complete and ready for processing")
                                
                                downloadComplete(self.newReleaseData, self.trendingEpisodesData, self.showOffersData)
                                //downloadComplete(nil)
                            }
                        })
                    }
                }
            case .failure(let error):
                print("There was an error download: -- \(error)")
            }
        }
    }
    
}
