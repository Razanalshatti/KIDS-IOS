//
//  HeaderTableViewCell.swift
//  KFH-Kids
//
//  Created by Razan alshatti on 04/06/2024.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    
    let profileIcon = UIImageView()
    let usernameLabel = UILabel()
    let coinIcon = UIImageView()
    let coinLabel = UILabel()
    let cardIcon = UIButton(type: .custom)
    var child : TokenResponse?
    var childName = ""


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           
        setupSubviews()
        setupConstraints()
       }
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

    
    private func setupSubviews(){
        // Profile Icon
        profileIcon.image = UIImage(named: "profile")
        profileIcon.contentMode = .scaleAspectFill
        profileIcon.clipsToBounds = true
        profileIcon.layer.cornerRadius = 20
        addSubview(profileIcon)
        
        // Username Label
        usernameLabel.text = childName
        usernameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        usernameLabel.textColor = .black
        addSubview(usernameLabel)
        
        // Coin Icon and Label
        coinIcon.image = UIImage(named: "favourites")
        coinIcon.contentMode = .scaleAspectFit
        contentView.addSubview(coinIcon)
        coinLabel.text = "\(child?.points ?? 0)"
        coinLabel.font = UIFont.systemFont(ofSize: 18)
        addSubview(coinLabel)
        
        // Card Icon (Saving)
        cardIcon.setImage(UIImage(named: "saving"), for: .normal)
        cardIcon.contentMode = .scaleAspectFit
        cardIcon.clipsToBounds = true
        //cardIcon.addTarget(self, action: #selector(navigateToBankCard), for: .touchUpInside)
        addSubview(cardIcon)
    }
    
    func setupConstraints() {
        
        // Header
        profileIcon.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview().offset(20)
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
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(40)
            make.height.equalTo(30)
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}



