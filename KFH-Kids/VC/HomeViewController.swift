//  HomeViewController.swift
//  KFH-Kids
//
//  Created by Razan alshatti on 21/05/2024.
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
    let reward = UIButton(type: .custom)
    let transferPtsToParent = UIButton(type: .system)
    let transferPtsToGold = UIButton(type: .system)
    let bonus = UIButton(type: .system)
    let myView = UIView()
    var blurEffectView: UIVisualEffectView?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        setupSubviews()
        setupConstraints()
    }

    func setupSubviews() {
        // Profile Icon
        profileIcon.image = UIImage(named: "profile")
        profileIcon.contentMode = .scaleAspectFill
        profileIcon.clipsToBounds = true
        profileIcon.layer.cornerRadius = 20
        view.addSubview(profileIcon)

        // Username Label
        usernameLabel.text = "Hi, Razan"
        usernameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        usernameLabel.textColor = .black
        view.addSubview(usernameLabel)

        // Coin Icon and Label
        coinIcon.image = UIImage(systemName: "star.circle")
        coinIcon.tintColor = .yellow
        view.addSubview(coinIcon)

        let coinLabel = UILabel()
        coinLabel.text = "10"
        coinLabel.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(coinLabel)

        // Card Icon
        cardIcon.setImage(UIImage(systemName: "creditcard"), for: .normal)
        cardIcon.tintColor = .black
        view.addSubview(cardIcon)

        // Background Image
        screenImage.image = UIImage(named: "background")
        screenImage.contentMode = .scaleAspectFill
        view.addSubview(screenImage)

        // Container View
        myView.backgroundColor = .white
        myView.layer.cornerRadius = 25
        myView.layer.borderWidth = 2
        myView.layer.borderColor = UIColor.lightGray.cgColor
        view.addSubview(myView)

        // Rewards Label
        let rewardsLabel = UILabel()
        rewardsLabel.text = "Rewards"
        rewardsLabel.font = UIFont.boldSystemFont(ofSize: 18)
        rewardsLabel.textColor = .black
        myView.addSubview(rewardsLabel)

        // Rewards Subtitle
        let rewardsSubtitle = UILabel()
        rewardsSubtitle.text = "Complete tasks to get points"
        rewardsSubtitle.font = UIFont.systemFont(ofSize: 12)
        rewardsSubtitle.textColor = .lightGray
        myView.addSubview(rewardsSubtitle)

        // Reward Button with image background
        if let rewardImage = UIImage(named: "reward") {
            reward.setBackgroundImage(rewardImage, for: .normal)
        }
        reward.contentMode = .scaleAspectFill
        myView.addSubview(reward)

        // Service Section Label
        let serviceLabel = UILabel()
        serviceLabel.text = "Services"
        serviceLabel.font = UIFont.boldSystemFont(ofSize: 18)
        serviceLabel.textColor = .black
        myView.addSubview(serviceLabel)

        // Transfer Points to Parent Button
        transferPtsToParent.setTitle("Transfer Points to Parent", for: .normal)
        styleButton(transferPtsToParent)
        myView.addSubview(transferPtsToParent)

        // Transfer Points to Gold Button
        transferPtsToGold.setTitle("Transfer Points to Gold", for: .normal)
        styleButton(transferPtsToGold)
        transferPtsToGold.addTarget(self, action: #selector(transferToGoldButtonTapped), for: .touchUpInside)
        myView.addSubview(transferPtsToGold)

        // Bonus Button
        bonus.setTitle("Bonus", for: .normal)
        styleButton(bonus)
        bonus.addTarget(self, action: #selector(bonusButtonTapped), for: .touchUpInside)
        myView.addSubview(bonus)
    }

    func styleButton(_ button: UIButton) {
        button.backgroundColor = .systemYellow
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
    }

    @objc func bonusButtonTapped() {
        // Navigate to the activity page when the button is tapped
        // This will be implemented later
    }

    @objc func transferToGoldButtonTapped() {
        let vc = TransferPointsToGoldViewController()
        vc.modalPresentationStyle = .popover
        vc.preferredContentSize = CGSize(width: 300, height: 400)
        vc.delegate = self

        if let popoverController = vc.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
            popoverController.delegate = self
        }

        // Apply blur effect
        applyBlurEffect()

        present(vc, animated: true, completion: nil)
    }

    func applyBlurEffect() {
        let blurEffect = UIBlurEffect(style: .light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView!)
    }

    func removeBlurEffect() {
        blurEffectView?.removeFromSuperview()
    }

    func setupConstraints() {
        profileIcon.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalTo(view).offset(20)
            make.width.height.equalTo(40)
        }

        usernameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileIcon)
            make.left.equalTo(profileIcon.snp.right).offset(10)
        }

        cardIcon.snp.makeConstraints { make in
            make.centerY.equalTo(profileIcon)
            make.right.equalTo(view).offset(-20)
            make.width.height.equalTo(30)
        }

        coinIcon.snp.makeConstraints { make in
            make.centerY.equalTo(profileIcon)
            make.right.equalTo(cardIcon.snp.left).offset(-10)
            make.width.height.equalTo(30)
        }

        // Add a label for coins next to the coin icon
        let coinLabel = UILabel()
        coinLabel.text = "10"
        coinLabel.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(coinLabel)

        coinLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileIcon)
            make.right.equalTo(coinIcon.snp.left).offset(-5)
        }

        screenImage.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(10)
            make.left.right.equalTo(view)
            make.height.equalTo(view).multipliedBy(0.3)
        }

        myView.snp.makeConstraints { make in
            make.top.equalTo(screenImage.snp.bottom).offset(20)
            make.left.right.equalTo(view).inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }

        let rewardsLabel = myView.subviews[0] as! UILabel
        let rewardsSubtitle = myView.subviews[1] as! UILabel
        let rewardButton = myView.subviews[2] as! UIButton
        let serviceLabel = myView.subviews[3] as! UILabel
        let transferToParentButton = myView.subviews[4] as! UIButton
        let transferToGoldButton = myView.subviews[5] as! UIButton
        let bonusButton = myView.subviews[6] as! UIButton

        rewardsLabel.snp.makeConstraints { make in
            make.top.equalTo(myView).offset(20)
            make.left.equalTo(myView).offset(20)
        }

        rewardsSubtitle.snp.makeConstraints { make in
            make.top.equalTo(rewardsLabel.snp.bottom).offset(5)
            make.left.equalTo(myView).offset(20)
        }

        rewardButton.snp.makeConstraints { make in
            make.top.equalTo(rewardsSubtitle.snp.bottom).offset(10)
            make.left.equalTo(myView).offset(20)
            make.width.equalTo(150) // Adjust width as needed
            make.height.equalTo(100) // Adjust height as needed
        }

        serviceLabel.snp.makeConstraints { make in
            make.top.equalTo(rewardButton.snp.bottom).offset(20)
            make.left.equalTo(myView).offset(20)
        }

        transferToParentButton.snp.makeConstraints { make in
            make.top.equalTo(serviceLabel.snp.bottom).offset(10)
            make.left.equalTo(myView).offset(20)
            make.right.equalTo(myView).offset(-20)
            make.height.equalTo(40)
        }

        transferToGoldButton.snp.makeConstraints { make in
            make.top.equalTo(transferToParentButton.snp.bottom).offset(10)
            make.left.equalTo(myView).offset(20)
            make.right.equalTo(myView).offset(-20)
            make.height.equalTo(40)
        }

        bonusButton.snp.makeConstraints { make in
            make.top.equalTo(transferToGoldButton.snp.bottom).offset(10)
            make.left.equalTo(myView).offset(20)
            make.right.equalTo(myView).offset(-20)
            make.height.equalTo(40)
        }
    }
}

// Ensure that HomeViewController conforms to UIPopoverPresentationControllerDelegate
extension HomeViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }

    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        removeBlurEffect()
    }
}

extension HomeViewController: TransferPointsToGoldDelegate {
    func didCompleteTransfer() {
        removeBlurEffect()
    }
}
