////
////  HomeViewController.swift
////  KFH-Kids
////
////  Created by Razan alshatti on 21/05/2024.
////
//
//import UIKit
//import SnapKit
//import Eureka
//import Alamofire
//import Kingfisher
//
//class HomeViewController: UIViewController {
//    
//    let screenImage = UIImageView()
//    let reward = UIButton(type: .system)
//    let coinIcon = UILabel()
//    let cardIcon = UIButton()
//    let profileIcon = UIImageView()
//    let transferPtsToParent = UIButton(type: .system)
//    let transferPtsToGold = UIButton(type: .system)
//    let bonus = UIButton(type: .system)
//    let myView = UIView()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        createView()
//        setupSubviews()
//        setupConstraints()
//    }
//    
//    func createView() {
//        myView.backgroundColor = .gray
//        myView.layer.cornerRadius = 25
//        myView.layer.borderWidth = 2
//        view.addSubview(myView)
//    }
//    
//    func setupSubviews() {
//        // Rewards Label
//        let rewardsLabel = UILabel()
//        rewardsLabel.text = "Rewards"
//        rewardsLabel.font = UIFont.boldSystemFont(ofSize: 18)
//        rewardsLabel.textColor = .black
//        myView.addSubview(rewardsLabel)
//        
//        // Rewards Subtitle
//        let rewardsSubtitle = UILabel()
//        rewardsSubtitle.text = "complete tasks get bonus"
//        rewardsSubtitle.font = UIFont.systemFont(ofSize: 12)
//        rewardsSubtitle.textColor = UIColor.lightGray
//        myView.addSubview(rewardsSubtitle)
//
//        
//        // Reward Button
//        reward.setTitle("Reward Button", for: .normal)
//        myView.addSubview(reward)
//        
//        // Service Section Label
//        let serviceLabel = UILabel()
//        serviceLabel.text = "Service"
//        serviceLabel.font = UIFont.boldSystemFont(ofSize: 18)
//        serviceLabel.textColor = .black
//        myView.addSubview(serviceLabel)
//        
//        // Transfer Points to Parent Button
//        transferPtsToParent.setTitle("Transfer to Parent", for: .normal)
//        styleButton(transferPtsToParent)
//        myView.addSubview(transferPtsToParent)
//        
//        // Transfer Points to Gold Button
//        transferPtsToGold.setTitle("Transfer to Gold", for: .normal)
//        styleButton(transferPtsToGold)
//        myView.addSubview(transferPtsToGold)
//        
//        // Bonus Button
//        bonus.setTitle("Bonus", for: .normal)
//        styleButton(bonus)
//        myView.addSubview(bonus)
//    }
//    
//    func styleButton(_ button: UIButton) {
//        button.backgroundColor = .yellow
//        button.setTitleColor(.black, for: .normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
//        button.layer.cornerRadius = 10
//        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor.black.cgColor
//    }
//    
//    func setupConstraints() {
//        
//        let rewardsLabel = myView.subviews[0] as! UILabel
//        let rewardsSubtitle = myView.subviews[1] as! UILabel
//        let rewardButton = myView.subviews[2] as! UIButton
//        let serviceLabel = myView.subviews[3] as! UILabel
//        let transferToParentButton = myView.subviews[4] as! UIButton
//        let transferToGoldButton = myView.subviews[5] as! UIButton
//        let bonusButton = myView.subviews[6] as! UIButton
//        
//                myView.snp.makeConstraints { make in
//                    make.bottom.equalToSuperview()
//                    make.width.equalToSuperview()
//                    make.height.equalTo(550)
//                    make.leading.trailing.equalToSuperview()
//                }
//        
//        rewardsLabel.snp.makeConstraints { make in
//            make.top.equalTo(myView).offset(20)
//            make.left.equalTo(myView).offset(20)
//        }
//        
//        rewardsSubtitle.snp.makeConstraints { make in
//            make.top.equalTo(rewardsLabel.snp.bottom).offset(5)
//            make.left.equalTo(myView).offset(20)
//        }
//        
//        rewardButton.snp.makeConstraints { make in
//            make.top.equalTo(rewardsSubtitle.snp.bottom).offset(10)
//            make.left.equalTo(myView).offset(20)
//        }
//        
//        serviceLabel.snp.makeConstraints { make in
//            make.top.equalTo(rewardButton.snp.bottom).offset(20)
//            make.left.equalTo(myView).offset(20)
//        }
//        
//        transferToParentButton.snp.makeConstraints { make in
//            make.top.equalTo(serviceLabel.snp.bottom).offset(10)
//            make.left.equalTo(myView).offset(20)
//            make.width.equalTo(bonusButton)
//            make.height.equalTo(bonusButton)
//        }
//        
//        transferToGoldButton.snp.makeConstraints { make in
//            make.top.equalTo(transferToParentButton.snp.bottom).offset(10)
//            make.left.equalTo(myView).offset(20)
//            make.width.equalTo(bonusButton)
//            make.height.equalTo(bonusButton)
//        }
//        
//        bonusButton.snp.makeConstraints { make in
//            make.top.equalTo(transferToGoldButton.snp.bottom).offset(10)
//            make.left.equalTo(myView).offset(20)
//            make.width.equalTo(200)
//            make.height.equalTo(40)
//        }
//    }
//}
//


//
//  HomeViewController.swift
//  KFH-Kids
//
//  Created by Razan alshatti on 21/05/2024.
//

import UIKit
import SnapKit
import Eureka
import Alamofire
import Kingfisher

class HomeViewController: UIViewController {
    
    let screenImage = UIImageView()
    let reward = UIButton(type: .system)
    let coinIcon = UILabel()
    let cardIcon = UIButton()
    let profileIcon = UIImageView()
    let transferPtsToParent = UIButton(type: .system)
    let transferPtsToGold = UIButton(type: .system)
    let bonus = UIButton(type: .system)
    let myView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createView()
        setupSubviews()
        setupConstraints()
    }
    
    func createView() {
        myView.backgroundColor = .gray
        myView.layer.cornerRadius = 25
        myView.layer.borderWidth = 2
        view.addSubview(myView)
    }
    
    func setupSubviews() {
        // Rewards Label
        let rewardsLabel = UILabel()
        rewardsLabel.text = "Rewards"
        rewardsLabel.font = UIFont.boldSystemFont(ofSize: 18)
        rewardsLabel.textColor = .black
        myView.addSubview(rewardsLabel)
        
        // Rewards Subtitle
        let rewardsSubtitle = UILabel()
        rewardsSubtitle.text = "complete tasks get bonus"
        rewardsSubtitle.font = UIFont.systemFont(ofSize: 12)
        rewardsSubtitle.textColor = UIColor.lightGray
        myView.addSubview(rewardsSubtitle)
        
        // Reward Button with image background
        if let rewardImage = UIImage(named: "boy") {
            reward.setBackgroundImage(rewardImage, for: .normal)
        }
        reward.contentMode = .scaleAspectFill
        myView.addSubview(reward)
        
        // Service Section Label
        let serviceLabel = UILabel()
        serviceLabel.text = "Service"
        serviceLabel.font = UIFont.boldSystemFont(ofSize: 18)
        serviceLabel.textColor = .black
        myView.addSubview(serviceLabel)
        
        // Transfer Points to Parent Button
        transferPtsToParent.setTitle("Transfer to Parent", for: .normal)
        styleButton(transferPtsToParent)
        myView.addSubview(transferPtsToParent)
        
        // Transfer Points to Gold Button
        transferPtsToGold.setTitle("Transfer to Gold", for: .normal)
        styleButton(transferPtsToGold)
        myView.addSubview(transferPtsToGold)
        
        // Bonus Button
        bonus.setTitle("Bonus", for: .normal)
        styleButton(bonus)
        myView.addSubview(bonus)
    }
    
    func styleButton(_ button: UIButton) {
        button.backgroundColor = .yellow
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
    }
    
    func setupConstraints() {
        
        let rewardsLabel = myView.subviews[0] as! UILabel
        let rewardsSubtitle = myView.subviews[1] as! UILabel
        let rewardButton = myView.subviews[2] as! UIButton
        let serviceLabel = myView.subviews[3] as! UILabel
        let transferToParentButton = myView.subviews[4] as! UIButton
        let transferToGoldButton = myView.subviews[5] as! UIButton
        let bonusButton = myView.subviews[6] as! UIButton
        
        myView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(550)
            make.leading.trailing.equalToSuperview()
        }
        
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
            make.width.equalTo(100) // Adjust width as needed
            make.height.equalTo(150) // Adjust height as needed
        }
        
        serviceLabel.snp.makeConstraints { make in
            make.top.equalTo(rewardButton.snp.bottom).offset(20)
            make.left.equalTo(myView).offset(20)
        }
        
        transferToParentButton.snp.makeConstraints { make in
            make.top.equalTo(serviceLabel.snp.bottom).offset(10)
            make.left.equalTo(myView).offset(20)
            make.width.equalTo(bonusButton)
            make.height.equalTo(bonusButton)
        }
        
        transferToGoldButton.snp.makeConstraints { make in
            make.top.equalTo(transferToParentButton.snp.bottom).offset(10)
            make.left.equalTo(myView).offset(20)
            make.width.equalTo(bonusButton)
            make.height.equalTo(bonusButton)
        }
        
        bonusButton.snp.makeConstraints { make in
            make.top.equalTo(transferToGoldButton.snp.bottom).offset(10)
            make.left.equalTo(myView).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
    }
}
