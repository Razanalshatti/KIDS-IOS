import UIKit
import SnapKit
import Eureka
import Alamofire
import Kingfisher

class HomeViewController: UIViewController {
    
    let screenImage = UIImageView()
    let usernameLabel = UILabel()
    let coinIcon = UIImageView()
    let cardIcon = UIButton(type: .custom)
    let profileIcon = UIImageView()
    let rewardView1 = RewardViewController()
    let rewardView2 = RewardViewController()
    let rewardView3 = RewardViewController()
    let transferPtsToGold = UIButton(type: .system)
    let transferPtsToMoney = UIButton(type: .system)
    let bonus = UIButton(type: .system)
    let rewardsLabel = UILabel()
    let rewardsSubtitle = UILabel()
    let serviceLabel = UILabel()
    let coinLabel = UILabel()
    var bonusButtonTimer: Timer?
    var bonusButtonDisabledUntil: Date?
    var blurEffectView: UIVisualEffectView?
    
    var child: TokenResponse?
    var rewards = [Reward]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews()
        setupConstraints()
        checkBonusButtonState()
        fetchRewards(childId: child?.childId ?? 0, parentId: child?.parentId ?? 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    func setupSubviews() {
        // Profile Icon
        profileIcon.image = UIImage(named: "profile")
        profileIcon.contentMode = .scaleAspectFill
        profileIcon.clipsToBounds = true
        profileIcon.layer.cornerRadius = 20
        view.addSubview(profileIcon)
        
        // Username Label
        usernameLabel.text = "Hi , \(child?.username ?? "No username passed!")"
        usernameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        usernameLabel.textColor = .black
        view.addSubview(usernameLabel)
        
        // Coin Icon and Label
        coinIcon.image = UIImage(named: "favourites")
        coinIcon.contentMode = .scaleAspectFit
        view.addSubview(coinIcon)
        coinLabel.text = "\(child?.points ?? 0)"
        coinLabel.font = UIFont.systemFont(ofSize: 18)
        view.addSubview(coinLabel)
        
        // Card Icon (Saving)
        cardIcon.setImage(UIImage(named: "saving"), for: .normal)
        cardIcon.contentMode = .scaleAspectFit
        cardIcon.clipsToBounds = true
        cardIcon.addTarget(self, action: #selector(navigateToBankCard), for: .touchUpInside)
        view.addSubview(cardIcon)
        
        // Background Image
        screenImage.image = UIImage(named: "background2")
        screenImage.contentMode = .scaleAspectFill
        screenImage.layer.cornerRadius = 40
        screenImage.layer.masksToBounds = true
        view.addSubview(screenImage)
        
        // Rewards Label
        rewardsLabel.text = "Rewards"
        rewardsLabel.font = UIFont.boldSystemFont(ofSize: 20)
        rewardsLabel.textColor = .black
        view.addSubview(rewardsLabel)
        
        // Rewards Subtitle
        rewardsSubtitle.text = "Complete tasks to get points"
        rewardsSubtitle.font = UIFont.systemFont(ofSize: 12)
        rewardsSubtitle.textColor = .lightGray
        view.addSubview(rewardsSubtitle)
        
        // Reward Views
        rewardView1.configure(image: UIImage(named: "dabdoob"), description: "Super Mario Adventures")
        view.addSubview(rewardView1)
        
        rewardView2.configure(image: UIImage(named: "teeela"), description: "Bluetooth headphones")
        view.addSubview(rewardView2)
        
        rewardView3.configure(image: UIImage(named: "fantasy world"), description: "Accoustic guitar")
        view.addSubview(rewardView3)
        
        // Service Section Label
        serviceLabel.text = "Services"
        serviceLabel.font = UIFont.boldSystemFont(ofSize: 20)
        serviceLabel.textColor = .black
        view.addSubview(serviceLabel)
        
        // Transfer Points to Gold Button
        transferPtsToGold.setTitle("Transfer Points To Gold", for: .normal)
        transferPtsToGold.setTitleColor(.white, for: .normal)
        transferPtsToGold.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        transferPtsToGold.setBackgroundImage(UIImage(named: "GroupGreen2"), for: .normal)
        transferPtsToGold.layer.cornerRadius = 20
        transferPtsToGold.layer.masksToBounds = true
        transferPtsToGold.addTarget(self, action: #selector(transferToGoldButtonTapped), for: .touchUpInside)
        view.addSubview(transferPtsToGold)
        
        // Transfer Points to Money Button
        transferPtsToMoney.setTitle("Transfer Points To Money", for: .normal)
        transferPtsToMoney.setTitleColor(.white, for: .normal)
        transferPtsToMoney.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        transferPtsToMoney.setBackgroundImage(UIImage(named: "GroupGreen3"), for: .normal)
        transferPtsToMoney.layer.cornerRadius = 20
        transferPtsToMoney.layer.masksToBounds = true
        view.addSubview(transferPtsToMoney)
        
        // Bonus Button
        bonus.setTitle("Extra Points!", for: .normal)
        bonus.setBackgroundImage(UIImage(named: "GroupGreen4"), for: .normal)
        bonus.setTitleColor(.white, for: .normal)
        bonus.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        bonus.layer.cornerRadius = 20
        bonus.layer.masksToBounds = true
        bonus.addTarget(self, action: #selector(bonusButtonTapped), for: .touchUpInside)
        view.addSubview(bonus)
    }
    
    func styleButton(_ button: UIButton, color: UIColor) {
        button.backgroundColor = color
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.layer.cornerRadius = 10
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
    
    @objc func transferToGoldButtonTapped() {
        addBlurEffect()
        let vc = TransferPointsToGoldViewController()
        vc.modalPresentationStyle = .pageSheet
        vc.delegate = self
        
        
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        
        present(vc, animated: true, completion: nil)
    }
    
    @objc func navigateToBankCard() {
        let bankCardVC = BankCardViewController()
        navigationController?.pushViewController(bankCardVC, animated: true)
    }
    
    func disableBonusButton() {
        bonus.isEnabled = false
        bonus.backgroundColor = .gray
        
        bonusButtonDisabledUntil = Date().addingTimeInterval(1)
        UserDefaults.standard.set(bonusButtonDisabledUntil, forKey: "bonusButtonDisabledUntil")
        
        startBonusButtonTimer()
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
    
    func enableBonusButton() {
        bonus.isEnabled = true
        bonus.backgroundColor = UIColor(red: 0.451, green: 0.859, blue: 0.835, alpha: 1.0)
        bonusButtonDisabledUntil = nil
        UserDefaults.standard.removeObject(forKey: "bonusButtonDisabledUntil")
    }
    
    func startBonusButtonTimer() {
        bonusButtonTimer?.invalidate()
        bonusButtonTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
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
    
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        self.blurEffectView = blurEffectView
    }
    
    func setupConstraints() {
        
        // Header
        profileIcon.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view).offset(20)
            make.width.height.equalTo(40)
        }
        usernameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileIcon)
            make.left.equalTo(profileIcon.snp.right).offset(10)
        }
        coinIcon.snp.makeConstraints { make in
            make.centerY.equalTo(profileIcon)
            make.right.equalTo(cardIcon.snp.left).offset(-10)
            make.width.height.equalTo(30)
        }
        coinLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileIcon)
            make.right.equalTo(coinIcon.snp.left).offset(-5)
        }
        cardIcon.snp.makeConstraints { make in
            make.centerY.equalTo(profileIcon)
            make.right.equalTo(view).offset(-20)
            make.width.equalTo(40)
            make.height.equalTo(30)
        }
        
        // Background Image
        screenImage.snp.makeConstraints { make in
            make.top.equalTo(profileIcon.snp.bottom).offset(20)
            make.left.right.equalTo(view)
            make.height.equalTo(view).multipliedBy(0.23)
        }
        
        // Rewards and Service Section
        rewardsLabel.snp.makeConstraints { make in
            make.top.equalTo(screenImage.snp.bottom).offset(20)
            make.left.equalTo(view).offset(20)
        }
        
        rewardsSubtitle.snp.makeConstraints { make in
            make.top.equalTo(rewardsLabel.snp.bottom).offset(5)
            make.left.equalTo(view).offset(20)
        }
        
        rewardView1.snp.makeConstraints { make in
            make.top.equalTo(rewardsSubtitle.snp.bottom).offset(10)
            make.left.equalTo(view).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(150)
        }
        
        rewardView2.snp.makeConstraints { make in
            make.top.equalTo(rewardsSubtitle.snp.bottom).offset(10)
            make.left.equalTo(rewardView1.snp.right).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(150)
        }
        
        rewardView3.snp.makeConstraints { make in
            make.top.equalTo(rewardsSubtitle.snp.bottom).offset(10)
            make.left.equalTo(rewardView2.snp.right).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(150)
        }
        
        serviceLabel.snp.makeConstraints { make in
            make.top.equalTo(rewardView1.snp.bottom).offset(20)
            make.left.equalTo(view).offset(20)
        }
        
        transferPtsToGold.snp.makeConstraints { make in
            make.top.equalTo(serviceLabel.snp.bottom).offset(10)
            make.left.equalTo(view).offset(30)
            make.width.equalTo(327)
            make.height.equalTo(73)
        }
        
        transferPtsToMoney.snp.makeConstraints { make in
            make.top.equalTo(transferPtsToGold.snp.bottom).offset(10)
            make.left.equalTo(view).offset(30)
            make.width.equalTo(327)
            make.height.equalTo(73)
        }
        
        bonus.snp.makeConstraints { make in
            make.top.equalTo(transferPtsToMoney.snp.bottom).offset(10)
            make.left.equalTo(view).offset(30)
            make.width.equalTo(322)
            make.height.equalTo(69)
        }
    }
    
    func fetchRewards(childId: Int,parentId:Int) {
        
        NetworkManager.shared.GetRewards(childId: childId, parentId: parentId) { result in
            switch result {
            case .success(let tokenResponse):
                
                print("Success \(tokenResponse.count)")
                DispatchQueue.main.async {

                    self.rewards = tokenResponse

                }
            case .failure(let error):
                
                print("Failed! \(error.localizedDescription)")
                DispatchQueue.main.async {
                }
            }
            
        }
        
    }
}
    
    // Ensure that HomeViewController conforms to ActivityViewControllerDelegate
    extension HomeViewController: ActivityViewControllerDelegate {
        func didCompleteActivity() {
            disableBonusButton()
        }
    }
    
    // Ensure that HomeViewController conforms to TransferPointsToGoldDelegate
    extension HomeViewController: TransferPointsToGoldDelegate {
        func removeBlurEffect() {
            blurEffectView?.removeFromSuperview()
        }
    }

