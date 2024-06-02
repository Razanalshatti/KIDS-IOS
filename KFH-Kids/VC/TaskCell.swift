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
        pointsBackgroundView.layer.cornerRadius = 15
        
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
            make.width.height.equalTo(40)
        }
        
        pointsLabel.snp.makeConstraints { make in
            make.edges.equalTo(pointsBackgroundView).inset(5)
        }
    }
    
    func configure(with task: MyTask) {
        descriptionLabel.text = task.Description
        pointsLabel.text = "\(task.Points)"
        checkboxButton.isSelected = task.isCompleted
        
        if task.isCompleted {
            taskBackgroundView.backgroundColor = UIColor(red: 0.98, green: 0.67, blue: 0.67, alpha: 1.0) // Pink color for done tasks
            pointsBackgroundView.backgroundColor = UIColor(red: 0.98, green: 0.67, blue: 0.67, alpha: 1.0)
        } else {
            switch task.TaskType {
            case "Chore":
                taskBackgroundView.backgroundColor = UIColor(red: 0.29, green: 0.89, blue: 0.76, alpha: 1.0) // Blue color
                pointsBackgroundView.backgroundColor = UIColor(red: 0.29, green: 0.89, blue: 0.76, alpha: 1.0)
            case "Homework":
                taskBackgroundView.backgroundColor = UIColor(red: 1.0, green: 0.82, blue: 0.546, alpha: 1.0) // Orange color
                pointsBackgroundView.backgroundColor = UIColor(red: 1.0, green: 0.82, blue: 0.546, alpha: 1.0)
            default:
                taskBackgroundView.backgroundColor = UIColor(red: 0.51, green: 0.89, blue: 0.89, alpha: 1.0) // Default blue color
                pointsBackgroundView.backgroundColor = UIColor(red: 0.51, green: 0.89, blue: 0.89, alpha: 1.0)
            }
        }
    }
    
    @objc func checkboxTapped() {
        checkboxAction?()
    }
}
