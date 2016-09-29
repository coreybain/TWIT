//
//  Featured.swift
//  TWiT
//
//  Created by Corey Baines on 24/9/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import UIKit

class FeaturedVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Variables
    fileprivate let homeCellID = "HomeCell"
    fileprivate let largeCellId = "largeCellId"
    fileprivate let headerId = "headerId"
    
    //MARK: - Firebase Data:
    var newRelease: [TwitEpisodeDetails]?
    var newEpisode: [TwitEpisodeDetails]?
    var activeShow: [TwitShowDetails]?
    var newReview: [TwitEpisodeDetails]?
    var newTwitBits: [TwitEpisodeDetails]?
    var newHelp: [TwitEpisodeDetails]?
    var activeCast: [TwitCastDetails]?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Featured"
       // navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 47/255, green: 47/255, blue: 47/255, alpha: 1.0)]
        //navigationController?.navigationBar.barTintColor = UIColor(red: 16/255, green: 16/255, blue: 16/255, alpha: 1.0)
        navigationController?.navigationBar.barStyle = .black
        collectionView?.backgroundColor = UIColor(red: 22/255, green: 22/255, blue: 22/255, alpha: 1.0) //UIColor(colorLiteralRed: 29, green: 29, blue: 28, alpha: 1.0)
        collectionView?.showsVerticalScrollIndicator = false
        
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: homeCellID)
        collectionView?.register(CategoryLargeCell.self, forCellWithReuseIdentifier: largeCellId)
        collectionView?.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        
        DataService.ds().downloadFeaturedPage { (newReleaseData, newEpisodeData, activeShowData, newReviewData, newTwitBitsData, newHelpData, activeCastData) in
            print("WE GOT HERE")
            self.newRelease = newReleaseData
            self.newEpisode = newEpisodeData
            self.activeShow = activeShowData
            self.newReview = newReviewData
            self.newTwitBits = newTwitBitsData
            self.newHelp = newHelpData
            self.activeCast = activeCastData
            print(activeCastData?.count)
            self.collectionView?.reloadData()
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: CategoryCell
        
        if (indexPath as NSIndexPath).item == 2 || (indexPath as NSIndexPath).item == 4 || (indexPath as NSIndexPath).item == 6 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: largeCellId, for: indexPath as IndexPath) as! CategoryLargeCell
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: homeCellID, for: indexPath as IndexPath) as! CategoryCell
        }
        if (indexPath as NSIndexPath).item == 0 {
            cell.nameLabel.text = "New Released TWiT's"
            print(newRelease?.count)
            cell.episodeData = newRelease
        } else if (indexPath as NSIndexPath).item == 1 {
            cell.nameLabel.text = "Latest News"
            cell.episodeData = newEpisode
        } else if (indexPath as NSIndexPath).item == 2 {
            cell.nameLabel.text = "Active Shows"
            cell.showData = activeShow
        } else if (indexPath as NSIndexPath).item == 3 {
            cell.nameLabel.text = "Product Reviews"
            cell.episodeData = newReview
        } else if (indexPath as NSIndexPath).item == 4 {
            cell.nameLabel.text = "TWiT Bits & Specials"
            cell.episodeData = newTwitBits
        } else if (indexPath as NSIndexPath).item == 5 {
            cell.nameLabel.text = "Help and How-To's"
            cell.episodeData = newHelp
        } else if (indexPath as NSIndexPath).item == 6 {
            cell.nameLabel.text = "TWiT Crew"
            cell.castData = activeCast
        }
        cell.featuredVC = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if (indexPath as NSIndexPath).item == 2 || (indexPath as NSIndexPath).item == 4 || (indexPath as NSIndexPath).item == 6 {
            return CGSize(width: view.frame.width, height: 160)
        }
        
        return CGSize(width: view.frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 160)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! HeaderCell
        
        //header.appCategory = featuredApps?.bannerCategory
        
        return header
    }
    
    func showShowsDetail(_ app: TwitEpisodeDetails) {
        let layout = UICollectionViewFlowLayout()
        let seasonsDetailVC = SeasonsDetailVC(collectionViewLayout: layout)
        seasonsDetailVC.episodeData = app
        navigationController?.pushViewController(seasonsDetailVC, animated: true)
    }
    
    func canRotate() -> Void {}


    
}
