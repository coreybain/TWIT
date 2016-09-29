//
//  QuickPlayCell.swift
//  TWiT
//
//  Created by Corey Baines on 29/9/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import UIKit

class QuickPlayCell: UICollectionViewCell {
    
    var episodeData: TwitEpisodeDetails? {
        didSet {
            if let imageName = episodeData?.showPicture {
                imageView.image = UIImage(named: imageName)
            }
            episodeLabel.text = "Episode: \((episodeData?.episodeNumber)!)"
            descriptionLabel.text = (episodeData?.showNotes)!
            nameLabel.text = episodeData?.label
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
    
    lazy var playButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "play")
        button.setImage(image, for: UIControlState())
        button.tintColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = false
        
        button.addTarget(self, action: #selector(playVideo), for: .touchUpInside)
        
        return button
    }()
    
    let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Details", "Reviews", "Related"])
        sc.tintColor = UIColor.darkGray
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Quick Play Episode"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "TEST"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.white
        label.numberOfLines = 2
        return label
    }()
    
    let episodeLabel: UILabel = {
        let label = UILabel()
        label.text = "This Week in Tech"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(red: 147/255, green: 147/255, blue: 147/255, alpha: 1.0)
        label.textColor = UIColor.darkGray
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
    
    let audioButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("AUDIO", for: UIControlState())
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
    
    func playVideo() {
        if !UserDefaults.standard.bool(forKey: "videoplaying"){
            if episodeData != nil {
                let videoLauncher = VideoLauncher()
                videoLauncher.urlString = (episodeData?.videoArray[1].mediaUrl)!
                videoLauncher.showVideoPlayer()
            }
        }
    }
    
    
    func buttonAction(sender: UIButton!) {
        print("Button tapped")
    }
    
    func setupViews() {
        
        addSubview(titleLabel)
        addSubview(imageView)
        imageView.addSubview(playButton)
        addSubview(nameLabel)
        addSubview(episodeLabel)
        addSubview(audioButton)
        addSubview(dividerLineView)
        
        addConstraintsWithFormat("H:|-14-[v0]|", views: titleLabel)
        addConstraintsWithFormat("V:|[v0(30)]", views: titleLabel)
        
        addConstraintsWithFormat("H:|-14-[v0(75)]-8-[v1]-8-[v2]", views: imageView, nameLabel, audioButton)
        addConstraintsWithFormat("V:|[v0]-12-[v1(75)]", views: titleLabel, imageView)
        
        addConstraintsWithFormat("V:|[v0]-12-[v1]", views: titleLabel, nameLabel)
        
        addConstraintsWithFormat("V:[v0][v1(20)]", views: nameLabel, episodeLabel)
        addConstraintsWithFormat("H:|-14-[v0]-8-[v1]-8-[v2]", views: imageView, episodeLabel, audioButton)
        
        addConstraintsWithFormat("H:[v0(60)]-14-|", views: audioButton)
        addConstraintsWithFormat("V:|[v0]-12-[v1(32)]", views: titleLabel, audioButton)
        
        
        addConstraintsWithFormat("H:|[v0]|", views: dividerLineView)
        addConstraintsWithFormat("V:[v0(1)]|", views: dividerLineView)
        
        
        
        playButton.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        playButton.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        
    }
    
    
}
