//
//  SeasonsDetailVC.swift
//  TWiT
//
//  Created by Corey Baines on 29/9/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import UIKit

class SeasonsDetailVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK: -- Variables
    fileprivate let headerId = "headerId"
    fileprivate let topShowDetailsId = "headerId"
    fileprivate let baseCellId = "baseCell"
    fileprivate let quickEpisodeCell = "quickEpisodeCell"
    fileprivate let categoryCell = "categoryCell"
    fileprivate let largeCellId = "largeCellId"
    
    var episodeData: TwitEpisodeDetails? {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    var showData: TwitShowDetails? {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    var seasonInfo: [TwitShowDetails]?
    var seasonEpisodeInfo: [TwitEpisodeDetails]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = episodeData?.showLabel
        
        collectionView?.alwaysBounceVertical = true
        navigationController?.navigationBar.barStyle = .black
        collectionView?.backgroundColor = UIColor(red: 22/255, green: 22/255, blue: 22/255, alpha: 1.0) //UIColor(colorLiteralRed: 29, green: 29, blue: 28, alpha: 1.0)
        collectionView?.showsVerticalScrollIndicator = false
        
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
                if showData != nil {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: quickEpisodeCell, for: indexPath as IndexPath) as! CategoryCell
                    cell.showData = seasonInfo
                    cell.nameLabel.text = "Current Seasons"
                    return cell
                } else {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCell, for: indexPath as IndexPath) as! CategoryCell
                    //cell.showData = seasonInfo
                    cell.cellLoading = true
                    cell.loadingLabel.text = "Loading current seasons"
                    cell.nameLabel.text = "Current Seasons"
                    return cell
                }
            }
            if (indexPath as NSIndexPath).item == 2 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCell, for: indexPath as IndexPath) as! CategoryCell
                //cell.showData = seasonInfo
                cell.cellLoading = true
                cell.loadingLabel.text = "Loading current seasons"
                cell.nameLabel.text = "Past Seasons"
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
                cell.singleSponsorsInEpisodeData = episodeData
                cell.nameLabel.text = "Sponsors"
                return cell
            }
        }
        
        if showData != nil {
            if (indexPath as NSIndexPath).item == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: quickEpisodeCell, for: indexPath as IndexPath) as! QuickPlayCell
                cell.episodeData = episodeData
                return cell
            }
            if (indexPath as NSIndexPath).item == 1 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: quickEpisodeCell, for: indexPath as IndexPath) as! QuickPlayCell
                cell.episodeData = episodeData
                cell.titleLabel.text = "Current Seasons"
                return cell
            }
            if (indexPath as NSIndexPath).item == 2 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: quickEpisodeCell, for: indexPath as IndexPath) as! QuickPlayCell
                cell.episodeData = episodeData
                cell.titleLabel.text = "Past Seasons"
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
                cell.singleEpisodeData = episodeData
                cell.nameLabel.text = "Sponsors"
                return cell
            }
        }
        
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: baseCellId, for: indexPath) as! BaseCell
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if episodeData != nil {
            if (indexPath as NSIndexPath).item == 0 {
                return CGSize(width: view.frame.width, height: 130)
            }
        }
        
        return CGSize(width: view.frame.width, height: 170)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! SeasonsDetailCoverHeader
        print((episodeData?.showDetails.showHeroImage.heroImageFileName)!)
        header.coverImage.image = UIImage(named: "\((episodeData?.showDetails.showHeroImage.heroImageFileName)!)")
        
        return header
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 190)
    }
    
    
    func canRotate() -> Void {}
    
    
}
