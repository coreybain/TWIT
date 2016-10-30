//
//  SeasonsDetailVC.swift
//  TWiT
//
//  Created by Corey Baines on 29/9/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class SeasonsDetailVC: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {
    
    //MARK: -- Variables
    fileprivate let homeCellID = "HomeCell"
    fileprivate let headerId = "headerId"
    fileprivate let topShowDetailsId = "headerId"
    fileprivate let baseCellId = "baseCell"
    fileprivate let quickEpisodeCell = "quickEpisodeCell"
    fileprivate let categoryCell = "categoryCell"
    fileprivate let largeCellId = "largeCellId"
    
    var recentEpisodesData: [TwitEpisodeDetails]?
    var trendingEpisodesData: [TwitEpisodeDetails]?
    var offersData: [TwitOfferDetails]?
    
    var tapBGGesture: UITapGestureRecognizer!
    
    var episodeData: TwitEpisodeDetails? {
        didSet {
            DataService.ds().downloadSeasonShowPage(showID: (episodeData?.showDetails.ID)!) { (recentEps, trendingEps, offers) in
                self.recentEpisodesData = recentEps
                self.trendingEpisodesData = trendingEps
                self.offersData = offers
                self.collectionView?.reloadData()
            }
            collectionView?.reloadData()
        }
    }
    
    var showData: TwitShowDetails? {
        didSet {
            print((showData?.ID)!)
            DataService.ds().downloadSeasonShowPage(showID: (showData?.ID)!) { (recentEps, trendingEps, offers) in
                self.recentEpisodesData = recentEps
                self.trendingEpisodesData = trendingEps
                self.offersData = offers
                self.collectionView?.reloadData()
            }
            collectionView?.reloadData()
        }
    }
    
    var seasonInfo: [TwitShowDetails]?
    var seasonEpisodeInfo: [TwitEpisodeDetails]?
    
    override func viewDidAppear(_ animated: Bool) {
        tapBGGesture = UITapGestureRecognizer(target: self, action: #selector(settingsBGTapped))
        tapBGGesture.numberOfTapsRequired = 1
        tapBGGesture.cancelsTouchesInView = false
        self.view!.window!.addGestureRecognizer(tapBGGesture)
        tapBGGesture.delegate = self
    }
    func settingsBGTapped(sender: UITapGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.ended {
            let location = sender.location(in: nil)
            if !self.view.point(inside: self.view.convert(location, from: self.view.window), with: nil) {
                // Remove the recognizer first so it’s view.window is valid.
                self.view.window?.removeGestureRecognizer(sender)
                self.dismiss(animated: true, completion: { () -> Void in
                })
            }
        }
    }
    // MARK: - UIGestureRecognizer Delegate
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.view.window!.removeGestureRecognizer(tapBGGesture)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.view.superview?.layer.cornerRadius = 0.0
            self.view.superview?.layer.masksToBounds = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let title = episodeData?.showLabel {
            navigationItem.title = title
        } else if let title = showData?.label {
            navigationItem.title = title
        }
        
        collectionView?.alwaysBounceVertical = true
        navigationController?.navigationBar.barStyle = .black
        collectionView?.backgroundColor = UIColor(red: 22/255, green: 22/255, blue: 22/255, alpha: 1.0) //UIColor(colorLiteralRed: 29, green: 29, blue: 28, alpha: 1.0)
        collectionView?.showsVerticalScrollIndicator = false
        
        
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: homeCellID)
        collectionView?.register(BaseCell.self, forCellWithReuseIdentifier: baseCellId)
        collectionView?.register(TopShowDetailsId.self, forCellWithReuseIdentifier: topShowDetailsId)
        collectionView?.register(QuickPlayCell.self, forCellWithReuseIdentifier: quickEpisodeCell)
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: categoryCell)
        collectionView?.register(CategoryLargeCell.self, forCellWithReuseIdentifier: largeCellId)
        collectionView?.register(SeasonsDetailCoverHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if episodeData != nil {
            if (indexPath as NSIndexPath).item == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: quickEpisodeCell, for: indexPath as IndexPath) as! QuickPlayCell
                cell.episodeData = episodeData
                return cell
            }
            if (indexPath as NSIndexPath).item == 1 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCell, for: indexPath as IndexPath) as! CategoryCell
                cell.episodeData = recentEpisodesData
                cell.cellLoading = true
                cell.nameLabel.text = "Current Episodes"
                return cell
            }
            if (indexPath as NSIndexPath).item == 2 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCell, for: indexPath as IndexPath) as! CategoryCell
                cell.episodeData = trendingEpisodesData
                cell.cellLoading = true
                cell.nameLabel.text = "Trending Episodes"
                return cell
            }
            if (indexPath as NSIndexPath).item == 3 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: largeCellId, for: indexPath as IndexPath) as! CategoryLargeCell
                cell.singleCastInEpisodeData = episodeData
                cell.nameLabel.text = "Cast and Crew"
                return cell
            }
            
            if (indexPath as NSIndexPath).item == 4 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: largeCellId, for: indexPath as IndexPath) as! CategoryLargeCell
                cell.offersData = offersData
                cell.nameLabel.text = "Sponsors"
                return cell
            }
        }
        
        if showData != nil {
            if (indexPath as NSIndexPath).item == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: quickEpisodeCell, for: indexPath as IndexPath) as! QuickPlayCell
                cell.episodeData = recentEpisodesData?[0]
                return cell
            }
            if (indexPath as NSIndexPath).item == 1 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: homeCellID, for: indexPath as IndexPath) as! CategoryCell
                cell.episodeData = recentEpisodesData
                cell.nameLabel.text = "Current Episodes"
                return cell
            }
            if (indexPath as NSIndexPath).item == 2 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: homeCellID, for: indexPath as IndexPath) as! CategoryCell
                cell.episodeData = trendingEpisodesData
                cell.nameLabel.text = "Trending Episodes"
                return cell
            }
            if (indexPath as NSIndexPath).item == 3 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: largeCellId, for: indexPath as IndexPath) as! CategoryLargeCell
                cell.singleCastInShowData = showData
                cell.nameLabel.text = "Cast and Crew"
                return cell
            }
            
            if (indexPath as NSIndexPath).item == 4 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: largeCellId, for: indexPath as IndexPath) as! CategoryLargeCell
                cell.offersData = offersData
                cell.nameLabel.text = "Sponsors"
                return cell
            }
        }
        
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: baseCellId, for: indexPath) as! BaseCell
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if (indexPath as NSIndexPath).item == 0 {
            return CGSize(width: view.frame.width, height: 130)
        }
        if (indexPath as NSIndexPath).item == 1 || (indexPath as NSIndexPath).item == 2 {
            return CGSize(width: view.frame.width, height: 200)
        }
        
        return CGSize(width: view.frame.width, height: 170)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! SeasonsDetailCoverHeader
        
        if let headerImage = episodeData?.showDetails.showHeroImage.heroImageFileName {
            header.coverImage.image = UIImage(named: "\(headerImage)")
        } else if let headerImage = showData?.showHeroImage.heroImageFileName {
            header.coverImage.image = UIImage(named: "\(headerImage)")
        }
        
        return header
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 190)
    }
    
    
    func canRotate() -> Void {}
    
    
}
