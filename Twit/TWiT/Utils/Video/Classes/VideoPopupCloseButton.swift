//
//  VideoPopupCloseButton.swift
//  TWiT
//
//  Created by Corey Baines on 4/10/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import UIKit

class VideoPopupCloseButton: UIButton {
    var effectView: UIVisualEffectView
    
    override init(frame: CGRect) {
        effectView = UIVisualEffectView.init(effect: UIBlurEffect(style: .extraLight))
        effectView.isUserInteractionEnabled = false
        super.init(frame: frame)
        initViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        effectView = UIVisualEffectView.init(effect: UIBlurEffect(style: .extraLight))
        effectView.isUserInteractionEnabled = false
        super.init(coder: aDecoder)
        initViews()
    }
    
    func initViews() {
        self.addSubview(effectView)
        let highlightEffectView: UIVisualEffectView = UIVisualEffectView.init(effect: UIVibrancyEffect(blurEffect: effectView.effect as! UIBlurEffect))
        highlightEffectView.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
        highlightEffectView.frame = effectView.contentView.bounds
        let highlightView = UIView.init(frame: highlightEffectView.contentView.bounds)
        highlightView.backgroundColor = UIColor(white: 1.0, alpha: 0.2)
        highlightView.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
        highlightView.alpha = 0
        highlightEffectView.contentView.addSubview(highlightView)
        effectView.contentView.addSubview(highlightEffectView)
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 3.0
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.masksToBounds = false
        
        self.setTitleColor(UIColor.black, for: UIControlState())
        
        self.setImage(UIImage(named: "NowPlayingCollapseChevronMask"), for: UIControlState())
        
        self.accessibilityLabel = "Close"
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.sendSubview(toBack: effectView)
        
        let minSideSize: CGFloat = min(self.bounds.size.width, self.bounds.size.height)
        
        effectView.frame = self.bounds
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.rasterizationScale = UIScreen.main.nativeScale
        maskLayer.shouldRasterize = true
        
        let path: CGPath = CGPath(roundedRect: self.bounds, cornerWidth: minSideSize / 2, cornerHeight: minSideSize / 2, transform: nil)
        maskLayer.path = path
        
        effectView.layer.mask = maskLayer
        
        var imageFrame: CGRect = self.imageView!.frame
        imageFrame.origin.y = imageFrame.origin.y + 0.5
        self.imageView!.frame = imageFrame
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var superSize: CGSize = super.sizeThatFits(size)
        superSize.width = superSize.width + 14
        superSize.height = superSize.height + 2
        
        return superSize
    }
}