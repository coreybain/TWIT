//
//  SeasonsDetailCoverHeader.swift
//  TWiT
//
//  Created by Corey Baines on 29/9/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import UIKit

class SeasonsDetailCoverHeader: UICollectionViewCell {
    
    let cellId = "showsDetailCoverHeaderCellId"
    
    var episodeData: TwitEpisodeDetails? {
        didSet {
            coverImage.image = UIImage(named: (episodeData?.showPicture)!)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        gradientLayer.locations = [0.3, 0.9]
        coverImage.layer.addSublayer(gradientLayer)
    }
    
    
    func setupViews() {
        backgroundColor = UIColor.clear
        
        
        setupGradientLayer()
        addSubview(coverImage)
        addConstraintsWithFormat("H:|[v0]|", views: coverImage)
        addConstraintsWithFormat("V:|[v0(185)]", views: coverImage)
        
        
        
    }
    
}
