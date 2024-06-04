//
//  TextingTableViewCell.swift
//  KFH-Kids
//
//  Created by Razan alshatti on 04/06/2024.
//

import UIKit
import SnapKit

class TextingTableViewCell: UITableViewCell {
    

    let titleLabel = UILabel()
    let iconImageView = UIImageView()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupViews() {
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        iconImageView.contentMode = .scaleAspectFit

        contentView.addSubview(titleLabel)
        contentView.addSubview(iconImageView)
    }
    
    private func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)  // 16pt from the leading edge of contentView
            make.centerY.equalToSuperview()  // Centered vertically in contentView
            make.width.height.equalTo(24)  // Assuming a 24x24pt icon size
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(8)  // 8pt from the trailing edge of iconImageView
            make.centerY.equalToSuperview()  // Centered vertically in contentView
            make.trailing.lessThanOrEqualToSuperview().offset(-16)  // At least 16pt from the trailing edge of contentView
        }
    }

}
