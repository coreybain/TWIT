//
//  HomeVC.swift
//  Twit
//
//  Created by Corey Baines on 4/09/2016.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import UIKit

class HomeVC: UICollectionViewController {
    
    //MARK: - Variables
    let homeCellID = "HomeCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        DataService.ds().downloadFromTwit("shows", download: true, complete: { 
            
            }) { (error) in
                
        }
        
        navigationItem.title = "Twit"
        collectionView?.backgroundColor = .whiteColor()
        
        collectionView?.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: homeCellID)
        
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(homeCellID, forIndexPath: indexPath)
        
        cell.backgroundColor = .redColor()
        return cell
    }
    
}
