//
//  CategoryLargeCell.swift
//  TWiT
//
//  Created by Corey Baines on 25/9/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import UIKit

class CategoryLargeCell: CategoryCell {
    
    fileprivate let largeCategoryCellID = "largeCategoryCellID"
    
    override func setupViews() {
        super.setupViews()
        showsCollectionView.register(LargeShowCell.self, forCellWithReuseIdentifier: largeCategoryCellID)
    }
    
    fileprivate class LargeShowCell: ShowCell {
        fileprivate override func setupViews() {
            imageView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(imageView)
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageView]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-2-[v0]-14-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageView]))
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: largeCategoryCellID, for: indexPath) as! ShowCell
        //cell.app = appCategory?.apps?[(indexPath as NSIndexPath).item]
        if singleCastInEpisodeData != nil {
            if let cellname = (singleCastInEpisodeData?.showDetails.twitCastDetails[indexPath.row].pictureUrl300) {
                
                    //cell.imageView.image = UIImage(named: cellname)
                cell.imageView.sd_setImage(with: URL(string: cellname), placeholderImage: UIImage(named: "twit1"))
                    return cell
                
            } else {
                cell.imageView.image = UIImage(named: "leo_1")
                return cell
            }
        } else if singleCastInShowData != nil {
            if let cellname = (singleCastInShowData?.twitCastDetails[indexPath.row].pictureUrl300) {
                
                //cell.imageView.image = UIImage(named: cellname)
                cell.imageView.sd_setImage(with: URL(string: cellname), placeholderImage: UIImage(named: "twit1"))
                return cell
                
            } else {
                cell.imageView.image = UIImage(named: "twit1")
                return cell
            }
        } else if episodeData != nil {
            for cast in (episodeData?[indexPath.row].showDetails.twitCastDetails)! {
                if cast.pictureUrl300 != "" {
                    let cellname = cast.pictureUrl300
                    cell.imageView.sd_setImage(with: URL(string: cellname), placeholderImage: UIImage(named: "twit1"))
                    return cell
                } else {
                    cell.imageView.image = UIImage(named: "twit1")
                    return cell
                }
            }
        } else if offersData != nil {
            if let cellname = offersData?[indexPath.row].image800 {
                cell.imageView.sd_setImage(with: URL(string: cellname), placeholderImage: UIImage(named: "twit1"))
                return cell
            } else {
                cell.imageView.image = UIImage(named: "twit1")
                return cell
            }
        }
        
        if seasonOffersPic {
            //OFFERS WILL GO IN HERE
        }
        if castPic {
            if let cellname = (castData?[indexPath.row].pictureUrl300) {
                
                //cell.imageView.image = UIImage(named: cellname)
                cell.imageView.sd_setImage(with: URL(string: cellname), placeholderImage: UIImage(named: "twit1"))
                return cell
                
            } else {
                cell.imageView.image = UIImage(named: "leo_1")
                return cell
            }
        }
        if let cellname = (showData?[indexPath.row].showCoverImage.coverArtFileName) {
            if UIImage(named: "banner-\(cellname)") != nil {
                cell.imageView.image = UIImage(named: "banner-\(cellname)")
            } else {
                cell.imageView.image = UIImage(named: "banner-bits1400")
            }
        } else if let cellname = (pastShowData?[indexPath.row].showCoverImage.coverArtFileName) {
            if UIImage(named: "banner-\(cellname)") != nil {
                cell.imageView.image = UIImage(named: "banner-\(cellname)")
            } else {
                cell.imageView.image = UIImage(named: "banner-bits1400")
            }
        } else {
            cell.imageView.image = UIImage(named: "banner-bits1400")
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if castData != nil {
            if let cast = castData?[indexPath.row] {
                featuredVC?.showCastDetail(cast)
            }
        } else if let show = showData?[indexPath.row] {
            featuredVC?.showSeasonDetail(nil, show)
        } else if let show = pastShowData?[indexPath.row] {
            featuredVC?.showSeasonDetail(nil, show)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: frame.height - 32)
    }
}
