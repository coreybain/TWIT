//
//  InfiniteCollectionView.swift
//  ExampleInfiniteScrollView
//
//  Created by Mason L'Amy on 04/08/2015.
//  Copyright (c) 2015 Maso Apps Ltd. All rights reserved.
//

import UIKit

protocol InfiniteCollectionViewDataSource
{
    func cellForItemAtIndexPath(_ collectionView: UICollectionView, dequeueIndexPath: IndexPath, usableIndexPath: IndexPath) -> UICollectionViewCell
    func numberOfItems(_ collectionView: UICollectionView) -> Int
    func sizeForItemAt(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, indexPath: IndexPath) -> CGSize
    func insetForSectionAt(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, section: Int) -> UIEdgeInsets
}

protocol InfiniteCollectionViewDelegate
{
    func didSelectCellAtIndexPath(_ collectionView: UICollectionView, usableIndexPath: IndexPath)
}

class InfiniteCollectionView: UICollectionView
{
    var infiniteDataSource: InfiniteCollectionViewDataSource?
    var infiniteDelegate: InfiniteCollectionViewDelegate?
    var running:Bool = false
    
    fileprivate var cellPadding = CGFloat(0)
    fileprivate var cellWidth = CGFloat(0)
    fileprivate var indexOffset = 0
    
    init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout, frameCellWidth: CGFloat) {
        super.init(frame: frame, collectionViewLayout: layout)
        dataSource = self
        delegate = self
        cellPadding = (layout as! UICollectionViewFlowLayout).minimumInteritemSpacing
        if UIDevice.current.userInterfaceIdiom == .pad {
            cellWidth = 400
        } else {
            cellWidth = frameCellWidth
        }
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        centreIfNeeded()
    }
    
    fileprivate func centreIfNeeded()
    {
        let currentOffset = contentOffset
        let contentWidth = getTotalContentWidth()
        
        // Calculate the centre of content X position offset and the current distance from that centre point
        let centerOffsetX: CGFloat = (3 * contentWidth - bounds.size.width) / 2
        let distFromCentre = centerOffsetX - currentOffset.x
        
        if (fabs(distFromCentre) > (contentWidth / 4))
        {
            // Total cells (including partial cells) from centre
            let cellcount = distFromCentre/(cellWidth+cellPadding)
            
            // Amount of cells to shift (whole number) - conditional statement due to nature of +ve or -ve cellcount
            let shiftCells = Int((cellcount > 0) ? floor(cellcount) : ceil(cellcount))
            
            // Amount left over to correct for
            let offsetCorrection = (abs(cellcount).truncatingRemainder(dividingBy: 1)) * (cellWidth+cellPadding)
            
            // Scroll back to the centre of the view, offset by the correction to ensure it's not noticable
            if (contentOffset.x < centerOffsetX)
            {
                //left scrolling
                contentOffset = CGPoint(x: centerOffsetX - offsetCorrection, y: currentOffset.y)
            }
            else if (contentOffset.x > centerOffsetX)
            {
                //right scrolling
                contentOffset = CGPoint(x: centerOffsetX + offsetCorrection, y: currentOffset.y)
            }
            
            // Make content shift as per shiftCells
            shiftContentArray(getCorrectedIndex(shiftCells))
            
            // Reload cells, due to data shift changes above
            reloadData()
            if UserDefaults.standard.bool(forKey: "autoSlide") {
                
            }
        }

    }
    
    fileprivate func shiftContentArray(_ offset: Int)
    {
        indexOffset += offset
    }
    
    fileprivate func getTotalContentWidth() -> CGFloat
    {
        let numberOfCells = infiniteDataSource?.numberOfItems(self) ?? 0
        return CGFloat(numberOfCells) * (cellWidth + cellPadding)
    }
}

extension InfiniteCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        let numberOfItems = infiniteDataSource?.numberOfItems(self) ?? 0
      
        return  3 * numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        return infiniteDataSource!.cellForItemAtIndexPath(self, dequeueIndexPath: indexPath, usableIndexPath: IndexPath(row: getCorrectedIndex((indexPath as NSIndexPath).row - indexOffset), section: 0))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return infiniteDataSource!.sizeForItemAt(self, layout: collectionViewLayout, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return infiniteDataSource!.insetForSectionAt(self, layout: collectionViewLayout, section: section)
    }
    
    fileprivate func getCorrectedIndex(_ indexToCorrect: Int) -> Int
    {
        if let numberOfCells = infiniteDataSource?.numberOfItems(self)
        {
            if (indexToCorrect < numberOfCells && indexToCorrect >= 0)
            {
                return indexToCorrect
            }
            else
            {
                let countInIndex = Float(indexToCorrect) / Float(numberOfCells)
                let flooredValue = Int(floor(countInIndex))
                let offset = numberOfCells * flooredValue
                return indexToCorrect - offset
            }
        }
        else
        {
            return 0
        }
    }
    //DELEGATE METHODS
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        infiniteDelegate?.didSelectCellAtIndexPath(self, usableIndexPath: IndexPath(row: getCorrectedIndex((indexPath as NSIndexPath).row - indexOffset), section: 0))
    }
}

extension InfiniteCollectionView
{
    override var dataSource: UICollectionViewDataSource?
        {
        didSet
        {
            if (!self.dataSource!.isEqual(self))
            {
                print("WARNING: UICollectionView DataSource must not be modified.  Set infiniteDataSource instead.")
                self.dataSource = self
            }
        }
    }
    
    override var delegate: UICollectionViewDelegate?
        {
        didSet
        {
            if (!self.delegate!.isEqual(self))
            {
                print("WARNING: UICollectionView delegate must not be modified.  Set infiniteDelegate instead.")
                self.delegate = self
            }
        }
    }
}
