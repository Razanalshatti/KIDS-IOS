//
//  ServiceTableViewCell.swift
//  KFH-Kids
//
//  Created by Razan alshatti on 04/06/2024.
//

import UIKit

class ServiceTableViewCell: UITableViewCell {
    
    let serviceLabel = UILabel()
    let transferPtsToGold = UIButton(type: .system)
    let transferPtsToMoney = UIButton(type: .system)
    let bonus = UIButton(type: .system)


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        // Transfer Points to Gold Button
       // transferPtsToGold.setTitle("Transfer Points To Gold", for: .normal)
        transferPtsToGold.setTitleColor(.white, for: .normal)
        transferPtsToGold.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        transferPtsToGold.setBackgroundImage(UIImage(named: "GroupGreen3"), for: .normal)
        transferPtsToGold.layer.cornerRadius = 20
        transferPtsToGold.layer.masksToBounds = true
        //transferPtsToGold.addTarget(self, action: #selector(transferToGoldButtonTapped), for: .touchUpInside)
        addSubview(transferPtsToGold)
//        
//        // Transfer Points to Money Button
//        transferPtsToMoney.setTitle("Transfer Points To Money", for: .normal)
//        transferPtsToMoney.setTitleColor(.white, for: .normal)
//        transferPtsToMoney.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
//        transferPtsToMoney.setBackgroundImage(UIImage(named: "GroupGreen3"), for: .normal)
//        transferPtsToMoney.layer.cornerRadius = 20
//        transferPtsToMoney.layer.masksToBounds = true
//        addSubview(transferPtsToMoney)
//        
//        // Bonus Button
//        bonus.setTitle("Extra Points!", for: .normal)
//        bonus.setBackgroundImage(UIImage(named: "GroupGreen4"), for: .normal)
//        bonus.setTitleColor(.white, for: .normal)
//        bonus.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
//        bonus.layer.cornerRadius = 20
//        bonus.layer.masksToBounds = true
//       // bonus.addTarget(self, action: #selector(bonusButtonTapped), for: .touchUpInside)
//        addSubview(bonus)
    }

    func setupConstraints() {
        // Transfer Points to Gold Button
        transferPtsToGold.snp.makeConstraints { make in
           // make.top.equalTo(serviceLabel.snp.bottom).offset(20)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
//        
//        // Transfer Points to Money Button
//        transferPtsToMoney.snp.makeConstraints { make in
//            make.top.equalTo(transferPtsToGold.snp.bottom).offset(20)
//            make.left.equalToSuperview().offset(20)
//            make.right.equalToSuperview().offset(-20)
//            make.height.equalTo(50)
//        }
//        
//        // Bonus Button
//        bonus.snp.makeConstraints { make in
//            make.top.equalTo(transferPtsToMoney.snp.bottom).offset(20)
//            make.left.equalToSuperview().offset(20)
//            make.right.equalToSuperview().offset(-20)
//            make.height.equalTo(50)
//        }
    }


}
