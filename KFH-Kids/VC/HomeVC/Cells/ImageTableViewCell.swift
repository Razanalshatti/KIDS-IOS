//
//  ImageTableViewCell.swift
//  KFH-Kids
//
//  Created by Razan alshatti on 04/06/2024.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    let backgroundImageView = UIImageView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        // Background Image
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.layer.masksToBounds = true
        addSubview(backgroundImageView)
    }
    
    private func setupConstraints(){
        // Background Image
        backgroundImageView.snp.makeConstraints { make in
            backgroundImageView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        
    }
}
