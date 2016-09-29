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
        
        if singleEpisodeData != nil {
            if let cellname = (singleEpisodeData?.showDetails.twitCastDetails[indexPath.row].pictureFileName) {
                if UIImage(named: cellname) != nil {
                    cell.imageView.image = UIImage(named: cellname)
                    return cell
                } else {
                    cell.imageView.image = UIImage(named: "leo_1")
                    return cell
                }
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
        } else {
            cell.imageView.image = UIImage(named: "banner-bits1400")
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: frame.height - 32)
    }
}
