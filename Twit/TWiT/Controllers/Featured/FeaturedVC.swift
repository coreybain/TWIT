//
//  Featured.swift
//  TWiT
//
//  Created by Corey Baines on 24/9/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog

class FeaturedVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Variables
    fileprivate let homeCellID = "HomeCell"
    fileprivate let largeCellId = "largeCellId"
    fileprivate let headerId = "headerId"
    
    //MARK: - Firebase Data:
    var newRelease: [TwitEpisodeDetails]?
    var newEpisode: [TwitEpisodeDetails]?
    var activeShow: [TwitShowDetails]?
    var pastShow: [TwitShowDetails]?
    var newReview: [TwitEpisodeDetails]?
    var newTwitBits: [TwitEpisodeDetails]?
    var newHelp: [TwitEpisodeDetails]?
    var activeCast: [TwitCastDetails]?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 22/255, green: 22/255, blue: 22/255, alpha: 1.0)
        navigationItem.title = "Featured"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .black
        //navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: nil)
       // navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 47/255, green: 47/255, blue: 47/255, alpha: 1.0)]
        //navigationController?.navigationBar.barTintColor = UIColor(red: 16/255, green: 16/255, blue: 16/255, alpha: 1.0)
        tabBarController?.tabBar.barStyle = .black
        collectionView?.backgroundColor = UIColor(red: 22/255, green: 22/255, blue: 22/255, alpha: 1.0) //UIColor(colorLiteralRed: 29, green: 29, blue: 28, alpha: 1.0)
        collectionView?.showsVerticalScrollIndicator = false
        
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: homeCellID)
        collectionView?.register(CategoryLargeCell.self, forCellWithReuseIdentifier: largeCellId)
        collectionView?.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        
        downloadUI()
        
    }
    
    func downloadUI() {
        loading(loading: true)
        DataService.ds().downloadFeaturedPage { (newReleaseData, newEpisodeData, activeShowData, pastShowData, newReviewData, newTwitBitsData, newHelpData, activeCastData) in
            print("WE GOT HERE")
            self.newRelease = newReleaseData
            self.newEpisode = newEpisodeData
            self.activeShow = activeShowData
            self.pastShow = pastShowData
            self.newReview = newReviewData
            self.newTwitBits = newTwitBitsData
            self.newHelp = newHelpData
            self.activeCast = activeCastData
            self.loading(loading: false)
            self.collectionView?.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: CategoryCell
        
        if (indexPath as NSIndexPath).item == 2 || (indexPath as NSIndexPath).item == 4 || (indexPath as NSIndexPath).item == 6 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: largeCellId, for: indexPath as IndexPath) as! CategoryLargeCell
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: homeCellID, for: indexPath as IndexPath) as! CategoryCell
        }
        if (indexPath as NSIndexPath).item == 6 {
                cell.castPic = true
        }
        if (indexPath as NSIndexPath).item == 0 {
            cell.nameLabel.text = "New Released TWiT's"
            cell.episodeData = newRelease
        } else if (indexPath as NSIndexPath).item == 1 {
            cell.nameLabel.text = "Latest News"
            cell.episodeData = newEpisode
        } else if (indexPath as NSIndexPath).item == 2 {
            cell.nameLabel.text = "Active Shows"
            cell.showData = activeShow
        } else if (indexPath as NSIndexPath).item == 3 {
            cell.nameLabel.text = "Product Reviews"
            cell.episodeData = newReview
        } else if (indexPath as NSIndexPath).item == 4 {
            cell.nameLabel.text = "Past Shows"
            cell.pastShowData = pastShow
        } else if (indexPath as NSIndexPath).item == 5 {
            cell.nameLabel.text = "Help and How-To's"
            cell.episodeData = newHelp
        } else if (indexPath as NSIndexPath).item == 6 {
            cell.nameLabel.text = "TWiT Crew"
            cell.castData = activeCast
        }
        cell.featuredVC = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if (indexPath as NSIndexPath).item == 2 || (indexPath as NSIndexPath).item == 4 || (indexPath as NSIndexPath).item == 6 {
            return CGSize(width: view.frame.width, height: 160)
        }
        
        return CGSize(width: view.frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGSize(width: view.frame.width, height: 200)
        }
        return CGSize(width: view.frame.width, height: 160)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! HeaderCell
        
        //header.appCategory = featuredApps?.bannerCategory
        
        return header
    }
    
    func showSeasonDetail(_ app: TwitEpisodeDetails?, _ show: TwitShowDetails?) {
        if UIDevice.current.userInterfaceIdiom == .pad {
            let layout = UICollectionViewFlowLayout()
            let seasonsDetailVC = SeasonsDetailVC(collectionViewLayout: layout)
            if app != nil {
                seasonsDetailVC.episodeData = app
            } else if show != nil {
                seasonsDetailVC.showData = show
            }
            seasonsDetailVC.modalPresentationStyle = .formSheet
            self.present(seasonsDetailVC, animated: true, completion: nil)
        } else {
            let layout = UICollectionViewFlowLayout()
            let seasonsDetailVC = SeasonsDetailVC(collectionViewLayout: layout)
            if app != nil {
                seasonsDetailVC.episodeData = app
            } else if show != nil {
                seasonsDetailVC.showData = show
            }
            navigationController?.pushViewController(seasonsDetailVC, animated: true)
        }
    }
    
    func showShowsDetail(_ app: TwitEpisodeDetails) {
        if UIDevice.current.userInterfaceIdiom == .pad {
            let layout = UICollectionViewFlowLayout()
            let showsDetailVC = ShowsDetailVC(collectionViewLayout: layout)
            showsDetailVC.episodeData = app
            showsDetailVC.modalPresentationStyle = .formSheet
            self.present(showsDetailVC, animated: true, completion: nil)
        } else {
            let layout = UICollectionViewFlowLayout()
            let showsDetailVC = ShowsDetailVC(collectionViewLayout: layout)
            showsDetailVC.episodeData = app
            navigationController?.pushViewController(showsDetailVC, animated: true)
        }
    }
    
    func showCastDetail(_ app: TwitCastDetails) {
        let layout = UICollectionViewFlowLayout()
        let peopleVC = PeopleVC(collectionViewLayout: layout)
        peopleVC.singleCastData = app
        navigationController?.pushViewController(peopleVC, animated: true)
    }
    
    func loading(loading:Bool) {
        if loading {
            collectionView?.isHidden = true
            navigationItem.rightBarButtonItem = nil
            LoadingView.startSpinning(mainView: view)
        } else {
            collectionView?.isHidden = false
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: nil)
            LoadingView.stopSpinning()
        }
    }
    
    func canRotate() -> Void {}


    
}

