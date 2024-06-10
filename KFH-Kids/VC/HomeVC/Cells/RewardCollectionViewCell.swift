//
//  RewardCollectionViewCell.swift
//  KFH-Kids
//
//  Created by Aseel on 04/06/2024.
//
import UIKit
import SnapKit
import Kingfisher

//MARK: UICollectionViewCell
class RewardCollectionViewCell: UICollectionViewCell {
    
    let customBackgroundView = UIView()
    let rewardImageView = UIImageView()
    let descriptionLabel = UILabel()
    let pointsLabel = UILabel()
    let favoriteIcon = UIImageView()
    let dividerView = UIView()


    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setupSubviews() {
        // Custom Background View
        customBackgroundView.backgroundColor = UIColor(red: 0.863, green: 0.929, blue: 0.894, alpha: 1)
        customBackgroundView.layer.cornerRadius = 15
        customBackgroundView.layer.masksToBounds = true
        contentView.addSubview(customBackgroundView)

        // Reward Image
        rewardImageView.contentMode = .scaleAspectFill
        rewardImageView.clipsToBounds = true
        rewardImageView.layer.cornerRadius = 50/2
        customBackgroundView.addSubview(rewardImageView)
        
        // Favorite Icon
        favoriteIcon.image = UIImage(named: "favourites")
        favoriteIcon.contentMode = .scaleAspectFit
        customBackgroundView.addSubview(favoriteIcon)

        
        // points Label
//        pointsLabel.font = UIFont.boldSystemFont(ofSize: 14)
        pointsLabel.font = UIFont.systemFont(ofSize: 14, weight: .black)
        pointsLabel.textColor = .darkGray
        pointsLabel.numberOfLines = 2
        pointsLabel.textAlignment = .center
        customBackgroundView.addSubview(pointsLabel)
        
        // Divider View
        dividerView.backgroundColor = UIColor.lightGray
        customBackgroundView.addSubview(dividerView)
        
      
        
        // Description Label
        descriptionLabel.font = UIFont.systemFont(ofSize: 13, weight: .heavy)
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
//            make.bottom.equalTo(pointsLabel.snp.top)
            make.top.equalTo(customBackgroundView).offset(5)
            make.centerX.equalTo(customBackgroundView)
            make.width.height.equalTo(50)
        }
        
        pointsLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(customBackgroundView)
            make.leading.trailing.equalTo(customBackgroundView)
        }
        
        favoriteIcon.snp.makeConstraints { make in
            make.top.equalTo(pointsLabel)
            make.trailing.equalTo(pointsLabel).offset(-15)
            make.width.height.equalTo(15)
              }
    
        
        // Divider View Constraints
              dividerView.snp.makeConstraints { make in
                  make.bottom.equalTo(descriptionLabel.snp.top).offset(-7)
                  make.leading.trailing.equalTo(customBackgroundView)
                  make.height.equalTo(0.5)
              }
        
        descriptionLabel.snp.makeConstraints { make in
            make.bottom.equalTo(customBackgroundView).offset(-15)
            make.centerX.equalTo(customBackgroundView)
        }
    }
    
    
    func configure(with reward: Reward) {
        descriptionLabel.text = reward.description
        pointsLabel.text = "\(reward.requiredPoints)"


        
//        if let imageURL = URL(string: reward.image ?? "DefaultGift") {
//            rewardImageView.kf.setImage(with: imageURL)
//        } else {
            if reward.rewardType.lowercased() == "toy" { // change babdood to toy
                rewardImageView.image = UIImage(named: "dabdoob")
                
            } else if reward.rewardType.lowercased() == "money" {
                rewardImageView.image = UIImage(named: "cash")
                
            }else if reward.rewardType.lowercased() == "vacation" {
                rewardImageView.image = UIImage(named: "Disney")
              
            }
//        }
    }
}
