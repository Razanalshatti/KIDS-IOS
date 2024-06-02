
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
    let rewardButton1 = UIButton(type: .custom)
    let rewardButton2 = UIButton(type: .custom)
    let rewardButton3 = UIButton(type: .custom)
    let transferPtsToGold = UIButton(type: .system)
    let transferPtsToMoney = UIButton(type: .system)
    let bonus = UIButton(type: .system)
    let rewardsLabel = UILabel()
    let rewardsSubtitle = UILabel()
    let serviceLabel = UILabel()
    let coinLabel = UILabel()
    var bonusButtonTimer: Timer?
    var bonusButtonDisabledUntil: Date?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews()
        setupConstraints()
        checkBonusButtonState()
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
        usernameLabel.text = "Hi, Fahad"
        usernameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        usernameLabel.textColor = .black
        view.addSubview(usernameLabel)

        // Coin Icon and Label
        coinIcon.image = UIImage(named: "favourites")
        coinIcon.contentMode = .scaleAspectFit
        view.addSubview(coinIcon)

        coinLabel.text = "10"
        coinLabel.font = UIFont.systemFont(ofSize: 18)
        view.addSubview(coinLabel)

        // Card Icon (Saving)
        cardIcon.setImage(UIImage(named: "saving"), for: .normal)
        cardIcon.contentMode = .scaleAspectFit
        cardIcon.clipsToBounds = true
        cardIcon.addTarget(self, action: #selector(navigateToBankCard), for: .touchUpInside)
        view.addSubview(cardIcon)

        // Background Image
        screenImage.image = UIImage(named: "background")
        screenImage.contentMode = .scaleAspectFill
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

        // Reward Buttons
        rewardButton1.setBackgroundImage(UIImage(named: "reward"), for: .normal)
        rewardButton1.contentMode = .scaleAspectFill
        view.addSubview(rewardButton1)

        rewardButton2.setBackgroundImage(UIImage(named: "reward"), for: .normal)
        rewardButton2.contentMode = .scaleAspectFill
        view.addSubview(rewardButton2)
        
        rewardButton3.setBackgroundImage(UIImage(named: "reward"), for: .normal)
        rewardButton3.contentMode = .scaleAspectFill
        view.addSubview(rewardButton3)

        // Service Section Label
        serviceLabel.text = "Services"
        serviceLabel.font = UIFont.boldSystemFont(ofSize: 20)
        serviceLabel.textColor = .black
        view.addSubview(serviceLabel)

        // Transfer Points to Gold Button
        transferPtsToGold.setTitle("Transfer Points To Gold", for: .normal)
        styleButton(transferPtsToGold, color: UIColor(red: 1.0, green: 0.796, blue: 0.486, alpha: 1.0))
        transferPtsToGold.layer.cornerRadius = 20
        transferPtsToGold.layer.masksToBounds = true
        transferPtsToGold.addTarget(self, action: #selector(transferToGoldButtonTapped), for: .touchUpInside)
        view.addSubview(transferPtsToGold)

        // Transfer Points to Money Button
        transferPtsToMoney.setTitle("Transfer Points To Money", for: .normal)
        styleButton(transferPtsToMoney, color: UIColor(red: 1.0, green: 0.796, blue: 0.486, alpha: 1.0))
        transferPtsToMoney.layer.cornerRadius = 20
        transferPtsToMoney.layer.masksToBounds = true
        view.addSubview(transferPtsToMoney)
        
        // Bonus Button
        bonus.setTitle("Extra Points!", for: .normal)
        styleButton(bonus, color: UIColor(red: 0.451, green: 0.859, blue: 0.835, alpha: 1.0))
        bonus.layer.cornerRadius = 18
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
        let vc = TransferPointsToGoldViewController()
        vc.modalPresentationStyle = .pageSheet
        vc.delegate = self

        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
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

    func setupConstraints() {
        
        //MARK: Header:
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
            make.width.equalTo(40) // Adjusted size
            make.height.equalTo(30) // Adjusted size
        }


        
        //MARK: background image:
        
        screenImage.snp.makeConstraints { make in
            make.top.equalTo(profileIcon.snp.bottom).offset(20)
            make.left.right.equalTo(view)
            make.height.equalTo(view).multipliedBy(0.3)
        }
        
        // MARK: rewards and service section

      
        rewardsLabel.snp.makeConstraints { make in
            make.top.equalTo(screenImage.snp.bottom).offset(20)
            make.left.equalTo(view).offset(20)
        }

        rewardsSubtitle.snp.makeConstraints { make in
            make.top.equalTo(rewardsLabel.snp.bottom).offset(5)
            make.left.equalTo(view).offset(20)
        }

        rewardButton1.snp.makeConstraints { make in
            make.top.equalTo(rewardsSubtitle.snp.bottom).offset(10)
            make.left.equalTo(view).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(70)
        }

        rewardButton2.snp.makeConstraints { make in
            make.top.equalTo(rewardsSubtitle.snp.bottom).offset(10)
            make.left.equalTo(rewardButton1.snp.right).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(70)
        }
        
        rewardButton3.snp.makeConstraints { make in
            make.top.equalTo(rewardsSubtitle.snp.bottom).offset(10)
            make.left.equalTo(rewardButton2.snp.right).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(70)
        }

        serviceLabel.snp.makeConstraints { make in
            make.top.equalTo(rewardButton1.snp.bottom).offset(20)
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
}

// HomeViewController conforms to ActivityViewControllerDelegate
extension HomeViewController: ActivityViewControllerDelegate {
    func didCompleteActivity() {
        disableBonusButton()
    }
}

// HomeViewController conforms to TransferPointsToGoldDelegate
extension HomeViewController: TransferPointsToGoldDelegate {
    func removeBlurEffect() {
        
    }
}
    

