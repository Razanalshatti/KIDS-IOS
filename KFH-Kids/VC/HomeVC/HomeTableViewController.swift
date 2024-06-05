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

class HomeTableViewController: UITableViewController, TransferPointsToGoldDelegate, ActivityViewControllerDelegate, TransferPointsToMoneyDelegate{
        
    
    
        
    
    var sections = ["","","Rewards","Serivce"]
    var child: TokenResponse?
    var rewards : [Reward] = []
    var blurEffectView: UIVisualEffectView?
    var points: PointsResponse?
    var claimedReward: ClaimRewards?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.title = "Baity"
        self.navigationItem.setHidesBackButton(true, animated: true)
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
            
            return 3
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
            cell.delegate = self
            cell.selectionStyle = .none
            
            return cell
            
        } else if indexPath.section == 1 {
            // Image Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageTableViewCell
            
            cell.backgroundImageView.image = UIImage(named: "background2")
            cell.selectionStyle = .none

            return cell
            
        } else if indexPath.section == 2 {
            // Reward cell
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "RewardCell", for: indexPath) as! RewardCell
            let reward = rewards[indexPath.row] // calling the array = rows

            print(reward.description)
            
            cell.configure(with: reward)
            cell.selectionStyle = .none
            // Configure the cell...
            
            return cell
            
        } else if indexPath.section == 3 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceCell", for: indexPath) as! ServiceTableViewCell
            let buttonTitles = ["Transfer Points To Gold","Transfer Points To Money","Extra Points!"]
            cell.transferPtsToGold.setTitle(buttonTitles[indexPath.row], for: .normal)
            cell.selectionStyle = .none

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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
        } else if indexPath.section == 1 {
        } else if indexPath.section == 2 {
            
        } else if indexPath.section == 3 {

            switch indexPath.row {
            case 0:
                transferToGoldButtonTapped()
            case 1:
                transferToMoneyButtonTapped()

            case 2:
                bonusButtonTapped()
            default:
                print("Nothing")
            }
            
        } else {
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
    

//MARK: Navigation

extension HomeTableViewController: BankCardDelegate {
    
    
    
    @objc func transferToGoldButtonTapped() {
        addBlurEffect()
        let vc = TransferPointsToGoldViewController()
        vc.modalPresentationStyle = .pageSheet
        vc.delegate = self
        vc.child = child
        vc.coinLabel.text = String(child?.points ?? 0)
        
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        
        present(vc, animated: true, completion: nil)
    }
    @objc func transferToMoneyButtonTapped() {
        let vc = TransferPointsToMoneyViewController()
        vc.modalPresentationStyle = .pageSheet
        vc.delegate = self
        vc.child = child
        vc.moneyLabel.text = String(child?.points ?? 0)

        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }

        present(vc, animated: true, completion: nil)
    }
    
    @objc func bonusButtonTapped() {
        let vc = ActivityViewController()
        vc.modalPresentationStyle = .pageSheet
        vc.delegate = self
        
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        
        present(vc, animated: true, completion: nil)
    }
    
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        self.blurEffectView = blurEffectView
    }
    
    func removeBlurEffect() {
        
        // Make the Points API CALL
        
        NetworkManager.shared.GetPoints(childId: child!.childId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    print("success \(success)")
                    self.child?.points = success.points
                case .failure(let failure):
                    print("failed! \(failure)")
                }
            }  
        }
        blurEffectView?.removeFromSuperview()
        self.tableView.reloadData()
        
    }
    
//    MARK: check with nawaf ‼️‼️
    func claimYourReward(){
        NetworkManager.shared.claimReward(id: claimedReward?.id ?? 0, rewardId: claimedReward?.rewardId ?? 0, childId: claimedReward?.childId ?? 0, claimDate: claimedReward?.claimDate ?? "") { result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let claimed):
                    print("success reward \(claimed)")
                case .failure(let claimed):
                    print("failure \(claimed)")
                }
            }
        }
    }
     func didCompleteActivity() {
      //  disableBonusButton()
    }
    
//    func disableBonusButton() {
//        bonus.isEnabled = false
//        bonus.backgroundColor = .gray
//        
//        bonusButtonDisabledUntil = Date().addingTimeInterval(1)
//        UserDefaults.standard.set(bonusButtonDisabledUntil, forKey: "bonusButtonDisabledUntil")
//        
//        startBonusButtonTimer()
//    }
    
   
    func navigateToBankCardVC() {
        let bankCardVC = BankCardViewController()
        navigationController?.pushViewController(bankCardVC, animated: true)

    }

}

