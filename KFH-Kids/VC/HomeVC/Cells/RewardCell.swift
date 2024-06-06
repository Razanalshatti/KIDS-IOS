//
//  RewardCell.swift
//  KFH-Kids
//
//  Created by Aseel on 04/06/2024.
//

import UIKit
import SnapKit
import Kingfisher

class RewardCell: UITableViewCell {
    
    let customBackgroundView = UIView()
    let rewardImageView = UIImageView()
    let descriptionLabel = UILabel()
    let pointsLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        // Custom Background View
        customBackgroundView.backgroundColor = UIColor(red: 1.0, green: 0.949, blue: 0.878, alpha: 1.0)
        customBackgroundView.layer.cornerRadius = 15
        customBackgroundView.layer.masksToBounds = true
        contentView.addSubview(customBackgroundView)

        // Reward Image
        rewardImageView.contentMode = .scaleAspectFit
        customBackgroundView.addSubview(rewardImageView)
        
        // Description Label
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .darkGray
        descriptionLabel.numberOfLines = 2
        descriptionLabel.textAlignment = .center
        customBackgroundView.addSubview(descriptionLabel)
    }

    private func setupConstraints() {
        customBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }

        rewardImageView.snp.makeConstraints { make in
            make.top.equalTo(customBackgroundView).offset(10)
            make.centerX.equalTo(customBackgroundView)
            make.width.height.equalTo(80) 
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(rewardImageView.snp.bottom).offset(5)
            make.left.equalTo(customBackgroundView).offset(10)
            make.right.equalTo(customBackgroundView).offset(-10)
        }
    }
    
    func configure(with reward: Reward) {
        descriptionLabel.text = reward.description
        pointsLabel.text = String(reward.requiredPoints)
//        if let imageURL = URL(string: reward.image ?? "DefaultGift") {
//            rewardImageView.kf.setImage(with: imageURL)
//        } else {
            if reward.rewardType.lowercased() == "toy" { // change babdood to toy
                rewardImageView.image = UIImage(named: "dabdoob")
                
            } else if reward.rewardType.lowercased() == "money" {
                rewardImageView.image = nil
                
            }else if reward.rewardType.lowercased() == "vacation" {
                rewardImageView.image = nil
                
            }
//        }
    }
}
