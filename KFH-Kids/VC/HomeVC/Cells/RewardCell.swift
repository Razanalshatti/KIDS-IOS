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
    let favoriteIcon = UIImageView()

    
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
        
        // Favorite Icon
        favoriteIcon.image = UIImage(named: "favourites")
        favoriteIcon.contentMode = .scaleAspectFit
        customBackgroundView.addSubview(favoriteIcon)
        
        // Description Label
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .darkGray
        descriptionLabel.numberOfLines = 2
        descriptionLabel.textAlignment = .center
        customBackgroundView.addSubview(descriptionLabel)
        
        // points Label
        pointsLabel.font = UIFont.boldSystemFont(ofSize: 14)
        pointsLabel.textColor = .darkGray
        pointsLabel.numberOfLines = 2
        pointsLabel.textAlignment = .center
        customBackgroundView.addSubview(pointsLabel)
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
        
        pointsLabel.snp.makeConstraints { make in
            make.top.equalTo(rewardImageView.snp.bottom).offset(5)
            make.leading.trailing.equalTo(customBackgroundView)
        }
        
        
        favoriteIcon.snp.makeConstraints { make in
            make.centerY.equalTo(pointsLabel)
            make.leading.equalTo(pointsLabel.snp.trailing)
            make.width.height.equalTo(24)
              }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(pointsLabel.snp.bottom).offset(5)
            make.centerX.equalTo(customBackgroundView)
        }
    }
    
    func configure(with reward: Reward) {
        descriptionLabel.text = reward.description
        pointsLabel.text = String(reward.requiredPoints)
        favoriteIcon.image = UIImage(named: "favourites")

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
