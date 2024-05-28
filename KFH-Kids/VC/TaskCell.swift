

import UIKit

class TaskCell: UITableViewCell {
    
    let descriptionLabel = UILabel()
    let pointsLabel = UILabel()
    let checkboxButton = UIButton(type: .custom)
    
    var checkboxAction: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(pointsLabel)
        contentView.addSubview(checkboxButton)
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        pointsLabel.font = UIFont.systemFont(ofSize: 14)
        pointsLabel.textColor = .gray
        
        checkboxButton.setImage(UIImage(systemName: "square"), for: .normal)
        checkboxButton.setImage(UIImage(systemName: "checkmark.square"), for: .selected)
        checkboxButton.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
    }
    
    func setupConstraints() {
        checkboxButton.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(10)
            make.centerY.equalTo(contentView)
            make.width.height.equalTo(24)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.left.equalTo(checkboxButton.snp.right).offset(10)
            make.centerY.equalTo(contentView).offset(-10)
            make.right.equalTo(contentView).offset(-10)
        }
        
        pointsLabel.snp.makeConstraints { make in
            make.left.equalTo(checkboxButton.snp.right).offset(10)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(5)
            make.right.equalTo(contentView).offset(-10)
        }
    }
    
    func configure(with task: Task) {
        descriptionLabel.text = task.description
        pointsLabel.text = "Points: \(task.points)"
        checkboxButton.isSelected = task.isDone
    }
    
    @objc func checkboxTapped() {
        checkboxAction?()
    }
}
