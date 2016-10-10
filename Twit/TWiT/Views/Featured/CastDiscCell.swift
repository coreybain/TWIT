//
//  castDiscCell.swift
//  TWiT
//
//  Created by Corey Baines on 10/10/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import UIKit

class CastDiscCell: UICollectionViewCell {
    
    var castData: TwitCastDetails? {
        didSet {
//            if let imageName = episodeData?.showPicture {
//                imageView.image = UIImage(named: imageName)
//            }
//            episodeLabel.text = "Episode: \((episodeData?.episodeNumber)!)"
//            descriptionLabel.text = (episodeData?.showNotes)!
//            nameLabel.text = episodeData?.label
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Quick Play Episode"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "TEST"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(red: 147/255, green: 147/255, blue: 147/255, alpha: 1.0)
        label.numberOfLines = 4
        return label
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    func setupViews() {
        
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(dividerLineView)
        
        addConstraintsWithFormat("H:|-14-[v0]|", views: titleLabel)
        addConstraintsWithFormat("V:|[v0(30)]", views: titleLabel)
        
        addConstraintsWithFormat("H:|-14-[v0]-14-|", views: descriptionLabel)
        addConstraintsWithFormat("V:|[v0]-14-[v1]", views: titleLabel, descriptionLabel)
        
        addConstraintsWithFormat("H:|[v0]|", views: dividerLineView)
        addConstraintsWithFormat("V:[v0(1)]|", views: dividerLineView)
        
        
        
        
    }
    
    
}
