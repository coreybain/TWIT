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
    var newReleaseData: FIRDataSnapshot!
    var newEpisodeData: NSDictionary!
    var activeShowData: NSDictionary!
    var newReviewData: NSDictionary!
    var newTwitBitsData: NSDictionary!
    var newHelpData: NSDictionary!
    var activeCastData: NSDictionary!
    
    func downloadFeaturedPage(downloadComplete:@escaping (_ featuredPageDetails:[TwitEpisodeDetails]?) -> ()) {
        
        //MARK: Download new releases:
        ref.child("episodes").child("allEpisodes").queryLimited(toLast: 10).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if snapshot.exists() {
                if self.newEpisodeData == nil || self.activeCastData == nil || self.activeShowData == nil || self.newReviewData == nil || self.newTwitBitsData == nil || self.newHelpData == nil {
                    self.newReleaseData = snapshot
                    
                    
                    
                    self.twitEpisodeParse.parseEpisode(data: self.newReleaseData)
                    
                    print("Still downloading over episodes")
                } else {
                    self.newReleaseData = snapshot.value as! FIRDataSnapshot
                    print("Download complete and ready for processing")
                    //downloadComplete(nil)
                }
            }
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
        //MARK: Download News episodes from categories section:
        ref.child("categoryEpisodes").child("93").queryLimited(toLast: 10).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if snapshot.exists() {
                if self.newReleaseData == nil || self.activeCastData == nil || self.activeShowData == nil || self.newReviewData == nil || self.newTwitBitsData == nil || self.newHelpData == nil {
                    self.newEpisodeData = snapshot.value as! NSDictionary
                    print("Still downloading over episodes")
                } else {
                    self.newEpisodeData = snapshot.value as! NSDictionary
                    print("Download complete and ready for processing")
                    //downloadComplete(nil)
                }
            }
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
        //MARK: Download list of active Shows (long buttons):
        ref.child("activeShows").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if snapshot.exists() {
                if self.newReleaseData == nil || self.activeCastData == nil || self.newEpisodeData == nil || self.newReviewData == nil || self.newTwitBitsData == nil || self.newHelpData == nil {
                    self.activeShowData = snapshot.value as! NSDictionary
                    print("Still downloading over episodes")
                } else {
                    self.activeShowData = snapshot.value as! NSDictionary
                    print("Download complete and ready for processing")
                    //downloadComplete(nil)
                }
            }
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
        //MARK: Download Review episodes from categories section:
        ref.child("categoryEpisodes").child("92").queryLimited(toLast: 10).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if snapshot.exists() {
                if self.newReleaseData == nil || self.activeCastData == nil || self.newEpisodeData == nil || self.activeShowData == nil || self.newTwitBitsData == nil || self.newHelpData == nil {
                    self.newReviewData = snapshot.value as! NSDictionary
                    print("Still downloading over episodes")
                } else {
                    self.newReviewData = snapshot.value as! NSDictionary
                    print("Download complete and ready for processing")
                    //downloadComplete(nil)
                }
            }
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
        //MARK: Download Twit Bits (long buttons) episodes from categories section:
        ref.child("categoryEpisodes").child("2001").queryLimited(toLast: 10).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if snapshot.exists() {
                if self.newReleaseData == nil || self.activeCastData == nil || self.newEpisodeData == nil || self.activeShowData == nil || self.newReviewData == nil || self.newHelpData == nil {
                    self.newTwitBitsData = snapshot.value as! NSDictionary
                    print("Still downloading over episodes")
                } else {
                    self.newTwitBitsData = snapshot.value as! NSDictionary
                    print("Download complete and ready for processing")
                    //downloadComplete(nil)
                }
            }
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
        //MARK: Download Help and How-to episodes from categories section:
        ref.child("categoryEpisodes").child("94").queryLimited(toLast: 10).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if snapshot.exists() {
                if self.newReleaseData == nil || self.activeCastData == nil || self.newEpisodeData == nil || self.activeShowData == nil || self.newReviewData == nil || self.newTwitBitsData == nil {
                    self.newHelpData = snapshot.value as! NSDictionary
                    print("Still downloading over episodes")
                } else {
                    self.newHelpData = snapshot.value as! NSDictionary
                    print("Download complete and ready for processing")
                    //downloadComplete(nil)
                }
            }
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
        //MARK: Download list of cast members (long button):
        ref.child("cast").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if snapshot.exists() {
                if self.newReleaseData == nil || self.newTwitBitsData == nil || self.newEpisodeData == nil || self.activeShowData == nil || self.newReviewData == nil || self.newHelpData == nil {
                    self.activeCastData = snapshot.value as! NSDictionary
                    print("Still downloading over episodes")
                } else {
                    self.activeCastData = snapshot.value as! NSDictionary
                    print("Download complete and ready for processing")
                    //downloadComplete(nil)
                }
            }
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
}
