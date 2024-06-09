import UIKit

//MARK: Todo
///  Reward Cell --> UIColecitonView

class HomeTableViewController: UITableViewController, TransferPointsToGoldDelegate, ActivityViewControllerDelegate,RewardCollectionViewCellDelegate{
    
    var rewardIndexPath = 0
    var sections = ["","","Rewards","Serivce"]
    var child: TokenResponse?
    var rewards : [Reward] = []
    var blurEffectView: UIVisualEffectView?
    var points: PointsResponse?
    let bonus = UIButton(type: .system)
    var bonusButtonDisabledUntil: Date?
    var bonusButtonTimer: Timer?

    func collectionViewCellTapped(at indexPath: IndexPath) {
        print("selected \(indexPath.item)")
        rewardIndexPath = indexPath.item
        guard let points = child?.points else { return }
        let selectedRewrard = rewards[rewardIndexPath]
        
        if points >= selectedRewrard.requiredPoints { 
            showRewardMessage(points: points, reward: selectedRewrard)
            
            } else {
                navigateToTasksPage()
            }
        
        
    }
    
    
    func showRewardMessage(points: Int, reward: Reward) {
            let alertController = UIAlertController(title: "Congratulations!", message: "You have \(points) points. Would you like to claim your reward?", preferredStyle: .alert)
    
            let claimAction = UIAlertAction(title: "Claim", style: .default) { _ in
                self.claimYourReward(reward: reward)
            }
            let tasksAction = UIAlertAction(title: "Go to Tasks", style: .default) { _ in
                self.navigateToTasksPage()
            }
    
            alertController.addAction(claimAction)
            alertController.addAction(tasksAction)
    
            present(alertController, animated: true, completion: nil)
        }

    
        func navigateToTasksPage() {
            let tasksVC = TasksViewController()
//            tasksVC.child = self.child
            tasksVC.child = self.child
            navigationController?.pushViewController(tasksVC, animated: true)
        }
    
    
    func updatePoints() {
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
       
        title = "Home"

        let backButtonImage = UIImage(systemName: "house.fill")
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
        backButton.tintColor = .black
        self.navigationItem.setHidesBackButton(true, animated: true)
        tableView.register(ServiceTableViewCell.self, forCellReuseIdentifier: "ServiceCell")
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: "ImageCell")
        tableView.register(HeaderTableViewCell.self, forCellReuseIdentifier: "HeaderCell")
        tableView.register(RewardCell.self, forCellReuseIdentifier: "RewardCell")
        tableView.register(RewardCollectionTableViewCell.self, forCellReuseIdentifier: "RewardCollectionTableViewCell")
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
            
            return 1
            
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
            
            cell.backgroundImageView.image = UIImage(named: "background4")
            cell.backgroundImageView.layer.cornerRadius = 25
            cell.selectionStyle = .none

            return cell
            
        } else if indexPath.section == 2 {
            //MARK: Cell that is CollecitonView
            let cell = tableView.dequeueReusableCell(withIdentifier: "RewardCollectionTableViewCell", for: indexPath) as! RewardCollectionTableViewCell
            
            cell.rewards = rewards
            cell.delegate = self
            
            return cell
    
        } else if indexPath.section == 3 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceCell", for: indexPath) as! ServiceTableViewCell
            let buttonTitles = ["Transfer Points To Gold","Transfer Points To Money","Extra Points!"]
            let buttonBg = ["GroupGreen2","GroupGreen3","GroupGreen4"]
            cell.transferPtsToGold.setTitle(buttonTitles[indexPath.row], for: .normal)
            cell.transferPtsToGold.setBackgroundImage(UIImage(named: buttonBg[indexPath.row]), for: .normal)
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
         return 140
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
        addBlurEffect()
        let vc = TransferPointsToMoneyViewController()
        vc.modalPresentationStyle = .pageSheet
        vc.delegate = self
        vc.child = child
        vc.moneyLabel.text = String(child?.points ?? 0)

        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
        }

        present(vc, animated: true, completion: nil)
    }
    
    @objc func bonusButtonTapped() {
        addBlurEffect()
        let vc = ActivityViewController()
        vc.modalPresentationStyle = .pageSheet
        vc.child = child
        vc.delegate = self
        
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
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
        NetworkManager.shared.getPoints(childId: child!.childId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    print("success \(success)")
                    self.child?.points = success.points
                    self.tableView.reloadData()
                case .failure(let failure):
                    print("failed! \(failure)")
                }
            }  
        }
        blurEffectView?.removeFromSuperview()
        self.tableView.reloadData()
        
    }
    

    func claimYourReward(reward: Reward){
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: currentDate)
        NetworkManager.shared.claimReward(id: 0,
                                          rewardId: reward.id,
                                          childId: reward.childId,
                                          claimDate: formattedDate) { result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let claimed):
                    print("success reward \(claimed)")
                    self.rewards.remove(at: self.rewardIndexPath)
                    self.tableView.reloadData()
                case .failure(let claimed):
                    print("failure \(claimed)")
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
     func didCompleteActivity() {
       disableBonusButton()
    }
    func checkBonusButtonState() {
        if let disabledUntil = UserDefaults.standard.object(forKey: "bonusButtonDisabledUntil") as? Date {
            bonusButtonDisabledUntil = disabledUntil
            
            if Date() < disabledUntil {
                disableBonusButton()
                startBonusButtonTimer()
            } else {
                enableBonusButton()
            }
        }
    }
    func disableBonusButton() {
        bonus.isEnabled = false
        bonus.backgroundColor = .gray
        
        bonusButtonDisabledUntil = Date().addingTimeInterval(1)
        UserDefaults.standard.set(bonusButtonDisabledUntil, forKey: "bonusButtonDisabledUntil")
        
        startBonusButtonTimer()
    }
    func startBonusButtonTimer() {
        bonusButtonTimer?.invalidate()
        bonusButtonTimer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { timer in
            if let disabledUntil = self.bonusButtonDisabledUntil {
                let remainingTime = Int(disabledUntil.timeIntervalSinceNow)
                
                if remainingTime <= 0 {
                    self.enableBonusButton()
                    timer.invalidate()
                } else {
                    let hours = remainingTime / 3600
                    let minutes = (remainingTime % 3600) / 60
                    let seconds = remainingTime % 60
                    self.bonus.setTitle(String(format: "Bonus (%02d:%02d:%02d)", hours, minutes, seconds), for: .disabled)
                }
            }
        }
    }
    func enableBonusButton() {
        bonus.isEnabled = true
        bonus.backgroundColor = UIColor(red: 0.451, green: 0.859, blue: 0.835, alpha: 1.0)
        bonusButtonDisabledUntil = nil
        UserDefaults.standard.removeObject(forKey: "bonusButtonDisabledUntil")
    }
    
    
   
    func navigateToBankCardVC() {
        let bankCardVC = BankCardViewController()
        bankCardVC.childId = child?.childId
        navigationController?.pushViewController(bankCardVC, animated: true)

    }
    
    

}

