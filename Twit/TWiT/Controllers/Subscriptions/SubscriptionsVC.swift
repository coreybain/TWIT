//
//  SubscriptionsVC.swift
//  TWiT
//
//  Created by Corey Baines on 31/10/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import UIKit

class SubscriptionsVC: UICollectionViewController {
    
    
    //MARK: - Variables
    fileprivate let homeCellID = "subscriptionCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Subscription"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .black
        view.backgroundColor = UIColor(red: 22/255, green: 22/255, blue: 22/255, alpha: 1.0)
        collectionView?.backgroundColor = UIColor(red: 22/255, green: 22/255, blue: 22/255, alpha: 1.0)

        
        
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: homeCellID)
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath) as UICollectionViewCell
        
        return cell
    }
    
    
    
}
