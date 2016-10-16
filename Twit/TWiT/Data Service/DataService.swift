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
    var newEpisodeData: [TwitEpisodeDetails]!
    var activeShowData: [TwitShowDetails]!
    var newReviewData: [TwitEpisodeDetails]!
    var newTwitBitsData: [TwitEpisodeDetails]!
    var newHelpData: [TwitEpisodeDetails]!
    var activeCastData: [TwitCastDetails]!
    
    func downloadFeaturedPage(downloadComplete:@escaping (_ newReleaseData:[TwitEpisodeDetails]?, _ newEpisodeData:[TwitEpisodeDetails]?, _ activeShowData:[TwitShowDetails]?, _ newReviewData:[TwitEpisodeDetails]?, _ newTwitBitsData:[TwitEpisodeDetails]?, _ newHelpData:[TwitEpisodeDetails]?, _ activeCastData:[TwitCastDetails]?) -> ()) {
        
        //MARK: Download new releases:
        ref.child("episodes").child("allEpisodes").queryLimited(toLast: 20).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if snapshot.exists() {
                self.twitEpisodeParse.parseEpisode(data: snapshot, complete: { (data) in
                    
                    print("NEW EPISODES")
                    if self.newEpisodeData == nil || self.activeCastData == nil || self.activeShowData == nil || self.newReviewData == nil || self.newTwitBitsData == nil || self.newHelpData == nil {
                        self.newReleaseData = data
                        print("Still downloading over episodes")
                        
                    } else {
                        self.newReleaseData = data
                        print("Download complete and ready for processing")
                        
                        downloadComplete(self.newReleaseData, self.newEpisodeData, self.activeShowData, self.newReviewData, self.newTwitBitsData, self.newHelpData, self.activeCastData)
                        //downloadComplete(nil)
                    }
                })
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
        //MARK: Download News episodes from categories section:
        ref.child("categoryEpisodes").child("93").queryLimited(toLast: 20).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if snapshot.exists() {
                self.twitEpisodeParse.parseEpisode(data: snapshot, complete: { (data) in
                    
                    print("CATEGORY")
                    if self.newReleaseData == nil || self.activeCastData == nil || self.activeShowData == nil || self.newReviewData == nil || self.newTwitBitsData == nil || self.newHelpData == nil {
                        self.newEpisodeData = data
                        
                        print("Still downloading over episodes")
                    } else {
                        self.newEpisodeData = data
                        print("Download complete and ready for processing")
                         
                        downloadComplete(self.newReleaseData, self.newEpisodeData, self.activeShowData, self.newReviewData, self.newTwitBitsData, self.newHelpData, self.activeCastData)
                        //downloadComplete(nil)
                    }
                })
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
        //MARK: Download list of active Shows (long buttons):
        ref.child("activeShows").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if snapshot.exists() {
                self.twitEpisodeParse.parseShow(data: snapshot, complete: { (data) in
                    print("ACTIVE SHOWS")
                    if self.newReleaseData == nil || self.activeCastData == nil || self.newEpisodeData == nil || self.newReviewData == nil || self.newTwitBitsData == nil || self.newHelpData == nil {
                        self.activeShowData = data
                        print("Still downloading over episodes")
                    } else {
                        self.activeShowData = data
                        print("Download complete and ready for processing")
                         
                        downloadComplete(self.newReleaseData, self.newEpisodeData, self.activeShowData, self.newReviewData, self.newTwitBitsData, self.newHelpData, self.activeCastData)
                    }
                })
                
            }
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
        //MARK: Download Review episodes from categories section:
        ref.child("categoryEpisodes").child("92").queryLimited(toLast: 20).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if snapshot.exists() {
                self.twitEpisodeParse.parseEpisode(data: snapshot, complete: { (data) in
                    print("REVIEW EPS")
                    if self.newReleaseData == nil || self.activeCastData == nil || self.newEpisodeData == nil || self.activeShowData == nil || self.newTwitBitsData == nil || self.newHelpData == nil {
                        self.newReviewData = data
                        print("Still downloading over episodes")
                    } else {
                        self.newReviewData = data
                        print("Download complete and ready for processing")
                         
                        downloadComplete(self.newReleaseData, self.newEpisodeData, self.activeShowData, self.newReviewData, self.newTwitBitsData, self.newHelpData, self.activeCastData)
                        //downloadComplete(nil)
                    }
                })
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
        //MARK: Download Twit Bits (long buttons) episodes from categories section:
        ref.child("categoryEpisodes").child("2001").queryLimited(toLast: 20).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if snapshot.exists() {
                self.twitEpisodeParse.parseEpisode(data: snapshot, complete: { (data) in
                    print("TWIT BITS")
                    if self.newReleaseData == nil || self.activeCastData == nil || self.newEpisodeData == nil || self.activeShowData == nil || self.newReviewData == nil || self.newHelpData == nil {
                        self.newTwitBitsData = data
                        print("Still downloading over episodes")
                    } else {
                        self.newTwitBitsData = data
                        print("Download complete and ready for processing")
                         
                        downloadComplete(self.newReleaseData, self.newEpisodeData, self.activeShowData, self.newReviewData, self.newTwitBitsData, self.newHelpData, self.activeCastData)
                        //downloadComplete(nil)
                    }
                })
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
        //MARK: Download Help and How-to episodes from categories section:
        ref.child("categoryEpisodes").child("94").queryLimited(toLast: 20).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if snapshot.exists() {
                self.twitEpisodeParse.parseEpisode(data: snapshot, complete: { (data) in
                    print("HOW TO")
                    if self.newReleaseData == nil || self.activeCastData == nil || self.newEpisodeData == nil || self.activeShowData == nil || self.newReviewData == nil || self.newTwitBitsData == nil {
                        self.newHelpData = data
                        print("Still downloading over episodes")
                    } else {
                        self.newHelpData = data
                        print("Download complete and ready for processing")
                         
                        downloadComplete(self.newReleaseData, self.newEpisodeData, self.activeShowData, self.newReviewData, self.newTwitBitsData, self.newHelpData, self.activeCastData)
                        //downloadComplete(nil)
                    }
                })
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
        //MARK: Download list of cast members (long button):
        ref.child("people").queryLimited(toFirst: 20).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if snapshot.exists() {
                
                self.twitEpisodeParse.parseCast(data: snapshot, complete: { (data) in
                    print("CAST MEMBERS")
                    if self.newReleaseData == nil || self.newTwitBitsData == nil || self.newEpisodeData == nil || self.activeShowData == nil || self.newReviewData == nil || self.newHelpData == nil {
                        self.activeCastData = data
                        print("Still downloading over episodes")
                    } else {
                        self.activeCastData = data
                        print("Download complete and ready for processing") 
                        downloadComplete(self.newReleaseData, self.newEpisodeData, self.activeShowData, self.newReviewData, self.newTwitBitsData, self.newHelpData, self.activeCastData)
                    }
                })
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
}
