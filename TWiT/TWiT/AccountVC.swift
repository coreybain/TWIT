//
//  AccountVC.swift
//  TWiT
//
//  Created by Corey Baines on 31/10/16.
//  Copyright © 2016 Corey Baines. All rights reserved.
//

import Foundation
import UIKit

class AccountVC: UITableViewController {
    
    //
    /*
 
 
 
     User information // login
     
     Subscriptions
     History
     
     Account
     Live Chat
     Notifications
     Data Usage
     
     About Spiritdevs
     Share with friends
 
 
 
    */
    //
    // 34, 33, 36
    
    
    //MARK: - Variables
    //    fileprivate let AccountCellID = "AccountCell"
    
    var userCell: UITableViewCell = UITableViewCell()
    var subscriptionCell: UITableViewCell = UITableViewCell()
    var historyCell: UITableViewCell = UITableViewCell()
    var accountCell: UITableViewCell = UITableViewCell()
    var liveChatCell: UITableViewCell = UITableViewCell()
    var notificationCell: UITableViewCell = UITableViewCell()
    var dataUsageCell: UITableViewCell = UITableViewCell()
    var aboutCell: UITableViewCell = UITableViewCell()
    var shareCell: UITableViewCell = UITableViewCell()
    
    var firstNameText: UITextField = UITextField()
    var lastNameText: UITextField = UITextField()
    var cellImage: UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Account"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .black
        view.backgroundColor = UIColor(red: 22/255, green: 22/255, blue: 22/255, alpha: 1.0)
        tableView?.backgroundColor = UIColor(red: 23/255, green: 23/255, blue: 23/255, alpha: 1.0)
        tableView.separatorColor = UIColor(red: 56/255, green: 55/255, blue: 58/255, alpha: 1.0)
        //tableView.separatorInset = UIEdgeInsets.zero
        
        
        // construct first name cell, section 0, row 0
        self.userCell.backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 28/255, alpha: 1.0)
        //self.userCell.frame.size.height = 60
        self.firstNameText = UITextField(frame: self.userCell.contentView.bounds.insetBy(dx: 15, dy: 0))
        self.firstNameText.placeholder = "First Name"
        self.userCell.addSubview(self.firstNameText)
        
        // construct last name cell, section 0, row 1
        self.subscriptionCell.textLabel?.text = "Subscriptions"
        self.subscriptionCell.textLabel?.textColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0)
        self.subscriptionCell.imageView?.image = imageWithImage(image: UIImage(named: "aaa1400a")!, scaledToSize: CGSize(width: 30, height: 30))
        self.subscriptionCell.backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 28/255, alpha: 1.0)
        self.subscriptionCell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        // construct last name cell, section 0, row 1
        self.historyCell.textLabel?.text = "History"
        self.historyCell.textLabel?.textColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0)
        self.historyCell.imageView?.image = imageWithImage(image: UIImage(named: "aaa1400a")!, scaledToSize: CGSize(width: 30, height: 30))
        self.historyCell.backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 28/255, alpha: 1.0)
        self.historyCell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        // construct last name cell, section 0, row 1
        self.accountCell.textLabel?.text = "Account"
        self.accountCell.textLabel?.textColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0)
        self.accountCell.imageView?.image = imageWithImage(image: UIImage(named: "aaa1400a")!, scaledToSize: CGSize(width: 30, height: 30))
        self.accountCell.backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 28/255, alpha: 1.0)
        self.accountCell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        // construct last name cell, section 0, row 1
        self.liveChatCell.textLabel?.text = "Live Chat"
        self.liveChatCell.textLabel?.textColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0)
        self.liveChatCell.imageView?.image = imageWithImage(image: UIImage(named: "aaa1400a")!, scaledToSize: CGSize(width: 30, height: 30))
        self.liveChatCell.backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 28/255, alpha: 1.0)
        self.liveChatCell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        // construct last name cell, section 0, row 1
        self.notificationCell.textLabel?.text = "Notifications"
        self.notificationCell.textLabel?.textColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0)
        self.notificationCell.imageView?.image = imageWithImage(image: UIImage(named: "aaa1400a")!, scaledToSize: CGSize(width: 30, height: 30))
        self.notificationCell.backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 28/255, alpha: 1.0)
        self.notificationCell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        // construct last name cell, section 0, row 1
        self.dataUsageCell.textLabel?.text = "Data Usage"
        self.dataUsageCell.textLabel?.textColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0)
        self.dataUsageCell.imageView?.image = imageWithImage(image: UIImage(named: "aaa1400a")!, scaledToSize: CGSize(width: 30, height: 30))
        self.dataUsageCell.backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 28/255, alpha: 1.0)
        self.dataUsageCell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        // construct last name cell, section 0, row 1
        self.aboutCell.textLabel?.text = "About Spiritdevs"
        self.aboutCell.textLabel?.textColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0)
        self.aboutCell.imageView?.image = imageWithImage(image: UIImage(named: "aaa1400a")!, scaledToSize: CGSize(width: 30, height: 30))
        self.aboutCell.backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 28/255, alpha: 1.0)
        //self.dataUsageCell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        // construct last name cell, section 0, row 1
        self.shareCell.textLabel?.text = "Share with Friends"
        self.shareCell.textLabel?.textColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0)
        self.shareCell.imageView?.image = imageWithImage(image: UIImage(named: "aaa1400a")!, scaledToSize: CGSize(width: 30, height: 30))
        self.shareCell.backgroundColor = UIColor(red: 28/255, green: 28/255, blue: 28/255, alpha: 1.0)
        //self.shareCell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        
        
//        tableView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: AccountCellID)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            return 70
        }
        return 44
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    // Return the number of sections
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
        case 0: return 1    // section 0 has 2 rows
        case 1: return 2    // section 0 has 2 rows
        case 2: return 4     // section 0 has 2 rows
        case 3: return 2    // section 1 has 1 row
        default: fatalError("Unknown number of sections")
        }
    }
    
    // Return the row for the corresponding section and row
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch(indexPath.section) {
        case 0:
            switch(indexPath.row) {
            case 0: return self.userCell   // section 0, row 0 is the first name
            //case 1: return self.subscriptionCell    // section 0, row 1 is the last name
            default: fatalError("Unknown row in section 0")
            }
        case 1:
            switch(indexPath.row) {
            case 0: return self.subscriptionCell   // section 0, row 0 is the first name
            case 1: return self.historyCell      // section 1, row 0 is the share option
            default: fatalError("Unknown row in section 1")
            }
        case 2:
            switch(indexPath.row) {
            case 0: return self.accountCell
            case 1: return self.liveChatCell
            case 2: return self.notificationCell
            case 3: return self.dataUsageCell       // section 1, row 0 is the share option
            default: fatalError("Unknown row in section 2")
            }
        case 3:
            switch(indexPath.row) {
            case 0: return self.aboutCell
            case 1: return self.shareCell      // section 1, row 0 is the share option
            default: fatalError("Unknown row in section 2")
            }
        default: fatalError("Unknown section")
        }
    }
    
    // Customize the section headings for each section
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        switch(section) {
//        case 0: return "Profile"
//        case 1: return "Social"
//        default: fatalError("Unknown section")
//        }
//    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    // Configure the row selection code for any cells that you want to customize the row selection
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 0) {
            print("Section 0 was tapped")
        } else if(indexPath.section == 1 && indexPath.row == 0) {
            // deselect row
            tableView.deselectRow(at: indexPath, animated: false)
        } else if(indexPath.section == 1 && indexPath.row == 1) {
            // deselect row
            tableView.deselectRow(at: indexPath, animated: false)
        } else if(indexPath.section == 2 && indexPath.row == 0) {
            // deselect row
            tableView.deselectRow(at: indexPath, animated: false)
        } else if(indexPath.section == 2 && indexPath.row == 1) {
            // deselect row
            tableView.deselectRow(at: indexPath, animated: false)
        } else if(indexPath.section == 2 && indexPath.row == 2) {
            // deselect row
            tableView.deselectRow(at: indexPath, animated: false)
        } else if(indexPath.section == 2 && indexPath.row == 3) {
            // deselect row
            tableView.deselectRow(at: indexPath, animated: false)
        } else if(indexPath.section == 3 && indexPath.row == 0) {
            // deselect row
            tableView.deselectRow(at: indexPath, animated: false)
            print("Learn more about Spiritdevs")
        } else if(indexPath.section == 3 && indexPath.row == 1) {
            // deselect row
            tableView.deselectRow(at: indexPath, animated: false)
            print("Share your app with friends")
            print(self.shareCell.frame.height)
        }

    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 0
//    }
//    
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath) as UICollectionViewCell
//        
//        return cell
//    }
    
    
    
}
