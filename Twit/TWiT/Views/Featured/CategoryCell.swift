//
//  CategoryCell.swift
//  TWiT
//
//  Created by Corey Baines on 24/9/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import UIKit

class CategoryCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //MARK: -- Variables
    fileprivate let cellId = "showCellId"
    var featuredVC: FeaturedVC?
    var castPic:Bool = false
    var seasonCastPic:Bool = false
    var cellLoading:Bool?
    var seasonOffersPic:Bool = false
    var episodeData: [TwitEpisodeDetails]? {
        didSet {
            print(episodeData?.count)
            showsCollectionView.reloadData()
        }
    }
    var singleEpisodeData: TwitEpisodeDetails? {
        didSet {
            showsCollectionView.reloadData()
        }
    }
    var castData: [TwitCastDetails]? {
        didSet {
            print(castData)
            showsCollectionView.reloadData()
        }
    }
    var showData: [TwitShowDetails]? {
        didSet {
            showsCollectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let showsCollectionView: UICollectionView = {
        let collectionViewLayout: CenterCellCollectionViewFlowLayout = CenterCellCollectionViewFlowLayout()
        //collectionViewLayout.itemSize = CGSize(width: view.frame.width, height: 120)
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //collectionViewLayout.minimumInteritemSpacing = 0
        //collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.scrollDirection = .horizontal
        
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
//    let showsCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        
//        collectionView.backgroundColor = .clear
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        
//        return collectionView
//    }()
    
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "New Releases"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let loadingLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading..."
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 47/255, green: 47/255, blue: 47/255, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupViews() {
        backgroundColor = UIColor.clear
        
        addSubview(showsCollectionView)
        addSubview(dividerLineView)
        addSubview(nameLabel)
        
        if cellLoading != nil {
            if cellLoading! {
                addSubview(loadingLabel)
                //nameLabel.frame = CGRect(x: frame.width / 2, y: frame.width / 2, width: frame.width, height: 40)
                addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": loadingLabel]))
                addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0(40)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": loadingLabel]))
            }
        }
        
        showsCollectionView.dataSource = self
        showsCollectionView.delegate = self
        
        showsCollectionView.register(ShowCell.self, forCellWithReuseIdentifier: cellId)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": dividerLineView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": showsCollectionView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[nameLabel(30)][v0][v1(0.5)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": showsCollectionView, "v1": dividerLineView, "nameLabel": nameLabel]))
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(castData?.count)
        if let count = episodeData?.count {
            return count
        } else if let count = showData?.count {
            return count
        } else if let count = castData?.count {
            return count
        } else if let count = singleEpisodeData?.showDetails.twitCastDetails.count {
            return count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ShowCell
        if episodeData != nil {
            cell.episodeTitle = episodeData?[indexPath.row].label
            cell.showTitle = episodeData?[indexPath.row].showLabel
            if (episodeData?[indexPath.row].showPicture) != "" {
                print(episodeData?[indexPath.row].showPicture)
                cell.imageView.image = UIImage(named: (episodeData?[indexPath.row].showPicture)!)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: frame.height - 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 14, 0, 14)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if episodeData != nil {
            if let show = episodeData?[indexPath.row] {
                print(show)
                featuredVC?.showShowsDetail(show)
            }
        }
        
        
//        if !UserDefaults.standard.bool(forKey: "videoplaying"){
//            if episodeData != nil {
//                let videoLauncher = VideoLauncher()
//                videoLauncher.urlString = (episodeData?[indexPath.row].videoArray[1].mediaUrl)!
//                videoLauncher.showVideoPlayer()
//            }
//        }
    }
}



class ShowCell: UICollectionViewCell {
    
    //MARK: -- Variables
    var episodeTitle:String? {
        didSet {
            if let title = episodeTitle {
                nameLabel.text = title
            }
        }
    }
    var showTitle:String? {
        didSet {
            if let title = showTitle {
                categoryLabel.text = title
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "twit1400")
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Hiss Happens to the best"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        label.numberOfLines = 2
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "This Week in Tech"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(red: 147/255, green: 147/255, blue: 147/255, alpha: 1.0)
        label.textColor = UIColor.darkGray
        return label
    }()
    
//    let priceLabel: UILabel = {
//        let label = UILabel()
//        label.text = "$3.99"
//        label.font = UIFont.systemFont(ofSize: 13)
//        label.textColor = UIColor.darkGray
//        return label
//    }()
    
    func setupViews() {
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(categoryLabel)
        //addSubview(priceLabel)
        
        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)
        nameLabel.frame = CGRect(x: 0, y: frame.width + 2, width: frame.width, height: 40)
        if (nameLabel.text?.characters.count)! < 14 {
            categoryLabel.frame = CGRect(x: 0, y: frame.width + 30, width: frame.width, height: 20)
        } else {
            categoryLabel.frame = CGRect(x: 0, y: frame.width + 38, width: frame.width, height: 20)
        }
       // priceLabel.frame = CGRect(x: 0, y: frame.width + 56, width: frame.width, height: 20)
    }
    
}
