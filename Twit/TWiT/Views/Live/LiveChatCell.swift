//
//  LiveChatCell.swift
//  TWiT
//
//  Created by Corey Baines on 10/11/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation

class LiveChatCell: UICollectionViewCell {
    
    var textLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        return label
    }()
    
    var userLabel:UILabel = {
        let label = UILabel()
       // label.backgroundColor = UIColor.red
        label.font = UIFont.boldSystemFont(ofSize: 16) //systemFont(ofSize: 14)
        label.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var timeLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupViews() {
        backgroundColor = UIColor.clear
        
        
        addSubview(textLabel)
        addSubview(userLabel)
        addSubview(timeLabel)
        addSubview(dividerLineView)
        
        addConstraintsWithFormat("H:|[v0]|", views: dividerLineView)
        addConstraintsWithFormat("V:|-4-[v0(1)]", views: dividerLineView)
        
        addConstraintsWithFormat("H:|-14-[v0]", views: userLabel)
        addConstraintsWithFormat("V:[v0(1)]-8-[v1(12)]", views: dividerLineView, userLabel)
        
        addConstraintsWithFormat("H:[v0][v1]", views: userLabel, timeLabel)
        addConstraintsWithFormat("V:[v0(1)]-8-[v1(12)]", views: dividerLineView, timeLabel)
        
        addConstraintsWithFormat("H:|-14-[v0]-14-|", views: textLabel)
        addConstraintsWithFormat("V:[v0]-4-[v1]", views: userLabel, textLabel)
        
        
    }
}
