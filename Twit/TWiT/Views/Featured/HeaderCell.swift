//
//  HeaderCell.swift
//  TWiT
//
//  Created by Corey Baines on 25/9/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import UIKit

class HeaderCell: UICollectionViewCell, InfiniteCollectionViewDataSource, InfiniteCollectionViewDelegate {
    
    let cellId = "bannerCellId"
    var timr=Timer()
    var w:CGFloat=0.0
    var running:Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let headerCollectionView: InfiniteCollectionView = {
        let collectionViewLayout: CenterCellCollectionViewFlowLayout = CenterCellCollectionViewFlowLayout()
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionViewLayout.minimumLineSpacing = 5
        collectionViewLayout.scrollDirection = .horizontal
        
        let collectionView = InfiniteCollectionView(frame: .zero, collectionViewLayout: collectionViewLayout, frameCellWidth: UIScreen.main.bounds.width)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    func setupViews() {
        backgroundColor = UIColor.clear
        
        addSubview(headerCollectionView)
        headerCollectionView.register(BannerCell.self, forCellWithReuseIdentifier: cellId)
        
        headerCollectionView.infiniteDataSource = self
        headerCollectionView.infiniteDelegate = self
        
        configAutoscrollTimer()
        
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": headerCollectionView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": headerCollectionView]))
        
    }
    
    func numberOfItems(_ collectionView: UICollectionView) -> Int {
        return 6
    }
    
    func cellForItemAtIndexPath(_ collectionView: UICollectionView, dequeueIndexPath: IndexPath, usableIndexPath: IndexPath)  -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: dequeueIndexPath) as! BannerCell
        cell.imageView.image = UIImage(named: "firsttwiteastside1")
        return cell
    }
    func didSelectCellAtIndexPath(_ collectionView: UICollectionView, usableIndexPath: IndexPath) {
        print("Selected cell with name test")
    }
    
    func sizeForItemAt(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGSize(width: 400, height: frame.height)
        }
        return CGSize(width: frame.width, height: frame.height)
    }
    
    func insetForSectionAt(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, section: Int) -> UIEdgeInsets {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return UIEdgeInsetsMake(0, 5, 0, 5)
        }
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func configAutoscrollTimer()
    {
        
        timr=Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(autoScrollView), userInfo: nil, repeats: true)
    }
    func deconfigAutoscrollTimer()
    {
        timr.invalidate()
        
    }
    func onTimer()
    {
        autoScrollView()
    }
    
    func autoScrollView() {
        
        let initailPoint = CGPoint(x: w,y :0)
        let halfWidth = self.headerCollectionView.bounds.size.width * 0.5
        let centerCellCollectionViewFlowLayout = CenterCellCollectionViewFlowLayout()
        UserDefaults.standard.set(true, forKey: "autoSlide")
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            let x = self.headerCollectionView.contentOffset.x + 300
            let move = centerCellCollectionViewFlowLayout.autoOffset(proposedContentOffset: CGPoint(x: x, y: 0.0), collection: self.headerCollectionView)
            
            self.headerCollectionView.contentOffset = move
            }) { (complete) in
                UserDefaults.standard.set(false, forKey: "autoSlide")
        }
    }
    
    public func test() {
        //let halfWidth = self.headerCollectionView.bounds.size.width * 0.5
        let centerCellCollectionViewFlowLayout = CenterCellCollectionViewFlowLayout()
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            let x = self.headerCollectionView.contentOffset.x + 300
            let move = centerCellCollectionViewFlowLayout.autoOffset(proposedContentOffset: CGPoint(x: x, y: 0.0), collection: self.headerCollectionView)
      
            self.headerCollectionView.contentOffset = move
        }) { (complete) in
        }
    }
}



class BannerCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "theroom")
        iv.contentMode = .scaleAspectFill
        iv.layer.borderWidth = 0
        iv.layer.cornerRadius = 0
        iv.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.masksToBounds = true
        
        return iv
    }()
    
//    let overlayView: UIView = {
//        let ol = UIView()
//        let gradient: CAGradientLayer = CAGradientLayer()
//        gradient.colors = [UIColor.white.cgColor, UIColor.black.cgColor]
//        ol.layer.insertSublayer(gradient, at: 0)
//    }()
    
    func setupViews() {
        
        addSubview(imageView)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageView]))
        
    }

}
