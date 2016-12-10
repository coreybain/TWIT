//
//  UserCell.swift
//  TWiT
//
//  Created by Corey Baines on 10/12/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation

import UIKit

class UserCell: UICollectionViewCell {

    var userData: TwitUserDetails? {
        didSet {
            if userData != nil {
                nameLabel.isHidden = false
                descriptionLabel.isHidden = false
                if let imageName = userData?.showPicture {
                    imageView.isHidden = false
                    imageView.image = UIImage(named: imageName)
                }
                descriptionLabel.text = (userData?.showNotes)!
                nameLabel.text = userData?.label
            } else {
                imageView.isHidden = true
                nameLabel.isHidden = true
                descriptionLabel.isHidden = true
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
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "TEST"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.white
        label.numberOfLines = 2
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "This Week in Tech"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(red: 147/255, green: 147/255, blue: 147/255, alpha: 1.0)
        label.textColor = UIColor.darkGray
        return label
    }()
    
    func setupViews() {
        
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        
        addConstraintsWithFormat("H:|-14-[v0(75)]-8-[v1]", views: imageView, nameLabel)
        addConstraintsWithFormat("H:|-14-[v0(75)]-8-[v1]", views: imageView, descriptionLabel)
        addConstraintsWithFormat("V:|-12-[v1(75)]", views: imageView)
        addConstraintsWithFormat("V:|-12-[v1(75)]", views: nameLabel)
        addConstraintsWithFormat("V:|-12-[v1(75)]", views: descriptionLabel)
        
        
    }

    
    
    
}
