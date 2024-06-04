//
//  HomeTableViewController.swift
//  KFH-Kids
//
//  Created by Aseel on 04/06/2024.
//

import UIKit

//MARK: Todo
///  Create cell --> Header ✅
///  Image Cell -> Image
///  Reward Cell --> UIColecitonView
///  Service Cell -> UITableViewCell 

class HomeTableViewController: UITableViewController {
    
    
    var sections = ["","","Rewards","Serivce"]
    var child: TokenResponse?
    var rewards : [Reward] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.register(ServiceTableViewCell.self, forCellReuseIdentifier: "ServiceCell")
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: "ImageCell")
        tableView.register(HeaderTableViewCell.self, forCellReuseIdentifier: "HeaderCell")
        tableView.register(RewardCell.self, forCellReuseIdentifier: "RewardCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        fetchRewards(childId: child?.childId ?? 0, parentId: child?.parentId ?? 0)
        
        self.tableView.separatorColor = UIColor.clear
        
        print("Rewards Count: \(rewards.count)")
        
    }
    
    
    // MARK: - Table view data source
    
    // count or display how many sections i need in view
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionName: String
        
        switch section {
        case 0:
            sectionName = sections[section]
        case 1:
            sectionName = sections[section]
        case 2:
            sectionName = sections[section]
        case 3:
            sectionName = sections[section]
        default:
            sectionName = "NOT FOUND"
        }
        return sectionName
    }


    
    // display items inside a specific section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
            
        } else if section == 2 {
            
            return rewards.count
            
        } else if section == 3 {
            
            return 1
        } else {
            return 0
        }
        // #warning Incomplete implementation, return the number of rows
    }
    
    
    // display items inside a cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! HeaderTableViewCell
            
            cell.usernameLabel.text = child?.username
            cell.coinLabel.text = String(child?.points ?? 0)
            
            return cell
            
        } else if indexPath.section == 1 {
            // Image Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageTableViewCell
            cell.backgroundImageView.image = UIImage(named: "background2")
//            cell.backgroundImageView.image = UIImage(named: "background2")
            return cell
            
        } else if indexPath.section == 2 {
            // Reward cell
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "RewardCell", for: indexPath) as! RewardCell
            
            let reward = rewards[indexPath.row] // calling the array = rows
            
            print(reward.description)
            
            cell.rewardImageView.image = UIImage(named: "teeela")
            cell.descriptionLabel.text = reward.description
            // Configure the cell...
            
            return cell
            
        } else if indexPath.section == 3 {
            
            // Service cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceCell", for: indexPath) as! ServiceTableViewCell
            
//            cell.transferPtsToGold.titleLabel 
            return cell
            
        } else {
            return UITableViewCell()
        }
        
        
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 50
        } else if indexPath.section == 1 {
            return 200
        } else if indexPath.section == 2 {
         return 200
        } else if indexPath.section == 3 {
            return 75
        } else {
            return 100
        }
    }
    
    
    
}


//MARK: Fetching
extension HomeTableViewController {
    
    func fetchRewards(childId: Int,parentId:Int) {
        
        NetworkManager.shared.GetRewards(childId: childId, parentId: parentId) { result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let tokenResponse):
                    
                    print("Success \(tokenResponse.count)")
                    DispatchQueue.main.async {
                        
                        self.rewards = tokenResponse
                        self.tableView.reloadData()
                        print("Rewards Count: \(self.rewards.count)")

                    }
                case .failure(let error):
                    
                    print("Failed! \(error.localizedDescription)")
                    DispatchQueue.main.async {
                    }
                }
            }
           
            
        }
        
    }
    
    
}
