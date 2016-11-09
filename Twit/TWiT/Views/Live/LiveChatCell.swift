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
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": textLabel]))
        
        
    }
}
