import UIKit
import SnapKit

class TaskCell: UITableViewCell {
    
    let descriptionLabel = UILabel()
    let taskTypeLabel = UILabel()
    let pointsLabel = UILabel()
    let taskBackgroundView = UIImageView()
    let pointsBackgroundView = UIImageView()
    
    var task: MyTask?
    var checkboxAction: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(taskTapped)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        contentView.addSubview(taskBackgroundView)
        taskBackgroundView.addSubview(descriptionLabel)
        taskBackgroundView.addSubview(taskTypeLabel)
        contentView.addSubview(pointsBackgroundView)
        pointsBackgroundView.addSubview(pointsLabel)
        
        taskBackgroundView.layer.cornerRadius = 20
        taskBackgroundView.clipsToBounds = true 
        pointsBackgroundView.layer.cornerRadius = 15
        pointsBackgroundView.clipsToBounds = true
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 18)
        descriptionLabel.textColor = .black
        taskTypeLabel.font = UIFont.systemFont(ofSize: 11)
        taskTypeLabel.textColor = .gray
        
        pointsLabel.font = UIFont.systemFont(ofSize: 16)
        pointsLabel.textColor = .black
        pointsLabel.textAlignment = .center
    }
    
    func setupConstraints() {
        taskBackgroundView.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(10)
            make.top.bottom.equalTo(contentView).inset(5)
            make.right.equalTo(pointsBackgroundView.snp.left).offset(-10)
            make.height.equalTo(60)
        }
        
        pointsBackgroundView.snp.makeConstraints { make in
            //make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).offset(-10)
            make.width.height.equalTo(60)
            make.centerX.equalTo(taskBackgroundView)
            make.centerY.equalTo(taskBackgroundView)
           
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.edges.equalTo(taskBackgroundView).inset(11)
            make.top.bottom.equalTo(descriptionLabel).inset(1)
        }
        taskTypeLabel.snp.makeConstraints { make in
            make.edges.equalTo(taskBackgroundView).inset(10)
            make.top.bottom.equalTo(descriptionLabel).inset(45)
        }
        
        pointsLabel.snp.makeConstraints { make in
            make.edges.equalTo(pointsBackgroundView).inset(10)
            
        }
    }

    
    func configure(with task: MyTask) {
        self.task = task
        descriptionLabel.text = task.description
        taskTypeLabel.text = task.taskType
        pointsLabel.text = "\(task.points)"
        
        if task.isCompleted {
            taskBackgroundView.image = UIImage(named: "GroupGreen3")
            pointsBackgroundView.image = UIImage(named: "Point3")
        } else {
            taskBackgroundView.image = UIImage(named: "GroupGreen2")
            pointsBackgroundView.image = UIImage(named: "point2")
        }
    }
    
    @objc func taskTapped() {
        checkboxAction?()
    }
}
