<<<<<<< HEAD
//import UIKit
//
//class TaskCell: UITableViewCell {
//    
//    let descriptionLabel = UILabel()
//    let pointsLabel = UILabel()
//    let checkboxButton = UIButton(type: .custom)
//    
//    var checkboxAction: (() -> Void)?
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupSubviews()
//        setupConstraints()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func setupSubviews() {
//        contentView.addSubview(descriptionLabel)
//        contentView.addSubview(pointsLabel)
//        contentView.addSubview(checkboxButton)
//        
//        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
//        pointsLabel.font = UIFont.systemFont(ofSize: 14)
//        pointsLabel.textColor = .gray
//        
//        checkboxButton.setImage(UIImage(systemName: "square"), for: .normal)
//        checkboxButton.setImage(UIImage(systemName: "checkmark.square"), for: .selected)
//        checkboxButton.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
//    }
//    
//    func setupConstraints() {
//        checkboxButton.snp.makeConstraints { make in
//            make.left.equalTo(contentView).offset(10)
//            make.centerY.equalTo(contentView)
//            make.width.height.equalTo(24)
//        }
//        
//        descriptionLabel.snp.makeConstraints { make in
//            make.left.equalTo(checkboxButton.snp.right).offset(10)
//            make.centerY.equalTo(contentView).offset(-10)
//            make.right.equalTo(contentView).offset(-10)
//        }
//        
//        pointsLabel.snp.makeConstraints { make in
//            make.left.equalTo(checkboxButton.snp.right).offset(10)
//            make.top.equalTo(descriptionLabel.snp.bottom).offset(5)
//            make.right.equalTo(contentView).offset(-10)
//        }
//    }
//    
//    func configure(with task: Task) {
//        descriptionLabel.text = task.description
//        pointsLabel.text = "Points: \(task.points)"
//        checkboxButton.isSelected = task.isDone
//    }
//    
//    @objc func checkboxTapped() {
//        checkboxAction?()
//    }
//}
=======
>>>>>>> main

import UIKit
import SnapKit

class TaskCell: UITableViewCell {
    
    let descriptionLabel = UILabel()
    let pointsLabel = UILabel()
    let checkboxButton = UIButton(type: .custom)
    let taskBackgroundView = UIView()
    let pointsBackgroundView = UIView()
    
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
        contentView.addSubview(taskBackgroundView)
        taskBackgroundView.addSubview(descriptionLabel)
        contentView.addSubview(pointsBackgroundView)
        pointsBackgroundView.addSubview(pointsLabel)
        contentView.addSubview(checkboxButton)
        
        taskBackgroundView.layer.cornerRadius = 20
        pointsBackgroundView.layer.cornerRadius = 20
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textColor = .black
        
        pointsLabel.font = UIFont.systemFont(ofSize: 16)
        pointsLabel.textColor = .black
        pointsLabel.textAlignment = .center
        
        checkboxButton.setImage(UIImage(systemName: "square"), for: .normal)
        checkboxButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        checkboxButton.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
    }
    
    func setupConstraints() {
        checkboxButton.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(10)
            make.centerY.equalTo(contentView)
            make.width.height.equalTo(24)
        }
        
        taskBackgroundView.snp.makeConstraints { make in
            make.left.equalTo(checkboxButton.snp.right).offset(10)
            make.top.bottom.equalTo(contentView).inset(5)
            make.right.equalTo(pointsBackgroundView.snp.left).offset(-10)
            make.height.equalTo(60)
            make.width.equalTo(100)

        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.edges.equalTo(taskBackgroundView).inset(10)
        }
        
        pointsBackgroundView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).offset(-10)
            make.width.height.equalTo(60)
        }
        
        pointsLabel.snp.makeConstraints { make in
            make.edges.equalTo(pointsBackgroundView).inset(5)
        }
    }
    
    func configure(with task: Task) {
        descriptionLabel.text = task.description
        pointsLabel.text = "\(task.points)"
        checkboxButton.isSelected = task.isDone
        
        switch task.taskType {
        case "Chore":
            taskBackgroundView.backgroundColor = UIColor(red: 0.29, green: 0.89, blue: 0.76, alpha: 1.0)
            pointsBackgroundView.backgroundColor = UIColor(red: 0.29, green: 0.89, blue: 0.76, alpha: 1.0)
        case "Homework":
            taskBackgroundView.backgroundColor = UIColor(red: 1.0, green: 0.82, blue: 0.546, alpha: 1.0)
            pointsBackgroundView.backgroundColor = UIColor(red: 1.0, green: 0.82, blue: 0.546, alpha: 1.0)
            
        case "Done":
            taskBackgroundView.backgroundColor = #colorLiteral(red: 1, green: 0.5535743833, blue: 0.7493770123, alpha: 1)
        
            pointsBackgroundView.backgroundColor = #colorLiteral(red: 1, green: 0.5535743833, blue: 0.7493770123, alpha: 1)
        default:
            taskBackgroundView.backgroundColor = UIColor.black
            pointsBackgroundView.backgroundColor = UIColor(red: 1.0, green: 0.56, blue: 0.56, alpha: 1.0)
        }
    }
    
    @objc func checkboxTapped() {
        checkboxAction?()
    }
}
