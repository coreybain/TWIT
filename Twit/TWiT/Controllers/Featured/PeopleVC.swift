//
//  PeopleVC.swift
//  TWiT
//
//  Created by Corey Baines on 10/10/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import UIKit

class PeopleVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK: -- Variables
    
    fileprivate let headerId = "headerId"
    fileprivate let topShowDetailsId = "headerId"
    fileprivate let baseCellId = "baseCell"
    fileprivate let quickEpisodeCell = "quickEpisodeCell"
    fileprivate let castDiscCell = "castDiscCell"
    fileprivate let categoryCell = "categoryCell"
    fileprivate let largeCellId = "largeCellId"
    
    var singleCastData: TwitCastDetails? {
        didSet {
            print(singleCastData?.castBio)
            print(singleCastData?.castID)
            collectionView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(true, forKey: "isCast")
        navigationItem.title = singleCastData?.castLabel
        
        collectionView?.alwaysBounceVertical = true
        navigationController?.navigationBar.barStyle = .black
        collectionView?.backgroundColor = UIColor(red: 22/255, green: 22/255, blue: 22/255, alpha: 1.0) //UIColor(colorLiteralRed: 29, green: 29, blue: 28, alpha: 1.0)
        collectionView?.showsVerticalScrollIndicator = false
        
        collectionView?.register(BaseCell.self, forCellWithReuseIdentifier: baseCellId)
        collectionView?.register(TopShowDetailsId.self, forCellWithReuseIdentifier: topShowDetailsId)
        collectionView?.register(QuickPlayCell.self, forCellWithReuseIdentifier: quickEpisodeCell)
        collectionView?.register(CastDiscCell.self, forCellWithReuseIdentifier: castDiscCell)
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: categoryCell)
        collectionView?.register(CategoryLargeCell.self, forCellWithReuseIdentifier: largeCellId)
        collectionView?.register(SeasonsDetailCoverHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UserDefaults.standard.set(false, forKey: "isCast")
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if singleCastData != nil {
            if (indexPath as NSIndexPath).item == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: castDiscCell, for: indexPath as IndexPath) as! CastDiscCell
                //cell.showData = seasonInfo
                cell.titleLabel.text = "Description of \((singleCastData?.castLabel)!)"
                let string = ((singleCastData?.castBio)!)
                let str = "\(string)".replacingOccurrences(of:"<[^>]+>", with: "", options: .regularExpression, range: nil)
                cell.descriptionLabel.text = str
                
                return cell
            }
            if (indexPath as NSIndexPath).item == 1 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCell, for: indexPath as IndexPath) as! CategoryCell
                //cell.showData = seasonInfo
                cell.nameLabel.text = "Recent Episodes"
                return cell
            }
            if (indexPath as NSIndexPath).item == 2 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCell, for: indexPath as IndexPath) as! CategoryCell
                //cell.showData = seasonInfo
                cell.nameLabel.text = "Show Cast member"
                return cell
            }
            
            if (indexPath as NSIndexPath).item == 3 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: largeCellId, for: indexPath as IndexPath) as! CategoryLargeCell
                //cell.singleSponsorsInEpisodeData = episodeData
                cell.nameLabel.text = "Links to \((singleCastData?.castLabel)!)"
                return cell
            }
        }
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: baseCellId, for: indexPath) as! BaseCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if singleCastData != nil {
            if (indexPath as NSIndexPath).item == 0 {
                return CGSize(width: view.frame.width, height: 130)
            }
        }
        
        return CGSize(width: view.frame.width, height: 170)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! SeasonsDetailCoverHeader
        if let cellname = ((singleCastData?.pictureUrl300)) {
            
            //cell.imageView.image = UIImage(named: cellname)
            header.coverImage.sd_setImage(with: URL(string: cellname), placeholderImage: UIImage(named: "twit1"))
            
        }
        
        return header
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGSize(width: view.frame.width, height: 360)
        } else {
            return CGSize(width: view.frame.width, height: 190)
        }
        
    }
    
    
    func canRotate() -> Void {}
    
    

    
}
