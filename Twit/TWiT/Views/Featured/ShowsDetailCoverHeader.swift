//
//  ShowsDetailCoverHeader.swift
//  TWiT
//
//  Created by Corey Baines on 29/9/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import UIKit

class ShowsDetailCoverHeader: UICollectionViewCell {
    
    let cellId = "showsDetailCoverHeaderCellId"
    
    var showData: TwitEpisodeDetails? {
        didSet {
            if let imageName = showData?.showPicture {
                imageView.image = UIImage(named: imageName)
            }
            
            nameLabel.text = showData?.showLabel
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        containerView.frame = frame
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    let audioButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("AUDIO", for: UIControlState())
        button.layer.borderColor = UIColor(red: 0, green: 129/255, blue: 250/255, alpha: 1).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
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
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blue
        return view
    }()
    
    let coverImage: UIImageView = {
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
    
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor(red: 22/255, green: 22/255, blue: 22/255, alpha: 1.0).cgColor]
        gradientLayer.locations = [0.2, 0.45]
        coverImage.layer.addSublayer(gradientLayer)
    }

    
    func setupViews() {
        backgroundColor = UIColor.clear
        
        
        setupGradientLayer()
        addSubview(coverImage)
        
        addSubview(imageView)
        addSubview(segmentedControl)
        addSubview(nameLabel)
        addSubview(seasonLabel)
        addSubview(audioButton)
        addSubview(subscribeButton)
        addSubview(dividerLineView)
        
        addConstraintsWithFormat("H:|[v0]|", views: coverImage)
        addConstraintsWithFormat("V:|[v0(185)]", views: coverImage)
        
        addConstraintsWithFormat("H:|-14-[v0(100)]-8-[v1]|", views: imageView, nameLabel)
        addConstraintsWithFormat("V:|[v0]-4-[v1(100)]", views: coverImage, imageView)
        
        addConstraintsWithFormat("V:|[v0]-8-[v1(20)]", views: coverImage, nameLabel)
        addConstraintsWithFormat("V:[v0(20)]-1-[v1(20)]", views: nameLabel, seasonLabel)
        addConstraintsWithFormat("H:[v0(100)]-8-[v1]|", views: imageView, seasonLabel)
        
        addConstraintsWithFormat("H:|-40-[v0]-40-|", views: segmentedControl)
        addConstraintsWithFormat("V:[v0(34)]-12-|", views: segmentedControl)
        
        addConstraintsWithFormat("H:[v0(120)]-14-|", views: audioButton)
        addConstraintsWithFormat("V:[v0(32)]-8-[v1]", views: audioButton, subscribeButton)
        
        addConstraintsWithFormat("H:[v0(120)]-14-|", views: subscribeButton)
        addConstraintsWithFormat("V:[v0(32)]-63-|", views: subscribeButton)
        
        addConstraintsWithFormat("H:|[v0]|", views: dividerLineView)
        addConstraintsWithFormat("V:[v0(1)]|", views: dividerLineView)
        
        
        
    }
    
}
