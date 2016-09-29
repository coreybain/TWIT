//
//  ShowsDetailVC.swift
//  TWiT
//
//  Created by Corey Baines on 29/9/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import UIKit

class ShowsDetailVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK: -- Variables
    fileprivate let headerId = "headerId"
    fileprivate let topShowDetailsId = "headerId"
    fileprivate let baseCellId = "baseCell"
    
    var episodeData: TwitEpisodeDetails? {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.alwaysBounceVertical = true
        navigationController?.navigationBar.barStyle = .black
        collectionView?.backgroundColor = UIColor(red: 22/255, green: 22/255, blue: 22/255, alpha: 1.0) //UIColor(colorLiteralRed: 29, green: 29, blue: 28, alpha: 1.0)
        collectionView?.showsVerticalScrollIndicator = false
        
        collectionView?.register(BaseCell.self, forCellWithReuseIdentifier: baseCellId)
        collectionView?.register(TopShowDetailsId.self, forCellWithReuseIdentifier: topShowDetailsId)
        collectionView?.register(ShowsDetailCoverHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (indexPath as NSIndexPath).item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: topShowDetailsId, for: indexPath) as! TopShowDetailsId
            cell.nameLabel.text = episodeData?.showLabel
            cell.imageView.image = UIImage(named: (episodeData?.showPicture)!)

            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: baseCellId, for: indexPath) as! BaseCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        
        return CGSize(width: view.frame.width, height: 170)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! ShowsDetailCoverHeader
        header.nameLabel.text = episodeData?.showLabel
        header.imageView.image = UIImage(named: (episodeData?.showPicture)!)
        header.coverImage.image = UIImage(named: "banner-\((episodeData?.showPicture)!)")
        
        return header
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
    
}

class AppDetailDescriptionCell: BaseCell {
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "SAMPLE DESCRIPTION"
        return tv
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(textView)
        addSubview(dividerLineView)
        
        addConstraintsWithFormat("H:|-8-[v0]-8-|", views: textView)
        addConstraintsWithFormat("H:|-14-[v0]|", views: dividerLineView)
        
        addConstraintsWithFormat("V:|-4-[v0]-4-[v1(1)]|", views: textView, dividerLineView)
    }
    
}

class TopShowDetailsId: BaseCell {
    
    var showData: TwitEpisodeDetails? {
        didSet {
            if let imageName = showData?.showPicture {
                imageView.image = UIImage(named: imageName)
            }
            
            nameLabel.text = showData?.showLabel
            
//            if let price = app?.price?.stringValue {
//                buyButton.setTitle("$\(price)", for: UIControlState())
//            }
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
//        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Details", "Reviews", "Related"])
        sc.tintColor = UIColor.white
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "This Week in Tech"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.white
        return label
    }()
    
    let seasonLabel: UILabel = {
        let label = UILabel()
        label.text = "Season 14"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.white
        label.alpha = 0.85
        return label
    }()
    
    let subscribeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SUBSCRIBE", for: UIControlState())
        button.layer.borderColor = UIColor(red: 0, green: 129/255, blue: 250/255, alpha: 1).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        addSubview(segmentedControl)
        addSubview(nameLabel)
        addSubview(seasonLabel)
        addSubview(subscribeButton)
        addSubview(dividerLineView)
        
        addConstraintsWithFormat("H:|-14-[v0(100)]-8-[v1]|", views: imageView, nameLabel)
        addConstraintsWithFormat("V:|[v0(100)]", views: imageView)
        
        addConstraintsWithFormat("V:|-4-[v0(20)]", views: nameLabel)
        addConstraintsWithFormat("V:[v0(20)]-1-[v1(20)]", views: nameLabel, seasonLabel)
        addConstraintsWithFormat("H:[v0(100)]-8-[v1]|", views: imageView, seasonLabel)
        
        addConstraintsWithFormat("H:|-40-[v0]-40-|", views: segmentedControl)
        addConstraintsWithFormat("V:[v0(34)]-8-|", views: segmentedControl)
        
        addConstraintsWithFormat("H:[v0(120)]-14-|", views: subscribeButton)
        addConstraintsWithFormat("V:[v0(32)]-56-|", views: subscribeButton)
        
        addConstraintsWithFormat("H:|[v0]|", views: dividerLineView)
        addConstraintsWithFormat("V:[v0(1)]|", views: dividerLineView)
    }
    
}

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
    }
}

extension UIView {
    
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
}