import UIKit
import SnapKit

class TaskCell: UITableViewCell {
    
    let descriptionLabel = UILabel()
    let pointsLabel = UILabel()
    let taskBackgroundView = UIImageView() // Changed to UIImageView
    let pointsBackgroundView = UIImageView() // Changed to UIImageView
    
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
        contentView.addSubview(pointsBackgroundView)
        pointsBackgroundView.addSubview(pointsLabel)
        
        taskBackgroundView.layer.cornerRadius = 20
        taskBackgroundView.clipsToBounds = true // Ensure the image respects the corner radius
        pointsBackgroundView.layer.cornerRadius = 15
        pointsBackgroundView.clipsToBounds = true
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textColor = .black
        
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
            make.edges.equalTo(taskBackgroundView).inset(10)
        }
        
        pointsLabel.snp.makeConstraints { make in
            make.edges.equalTo(pointsBackgroundView).inset(10)
            
        }
    }

    
    func configure(with task: MyTask) {
        self.task = task
        descriptionLabel.text = task.Description
        pointsLabel.text = "\(task.Points)"
        
        if task.isCompleted {
            taskBackgroundView.image = UIImage(named: "GroupGreen3")
            pointsBackgroundView.image = UIImage(named: "Point3")
        } else {
            taskBackgroundView.image = UIImage(named: "GroupGreen2")
            pointsBackgroundView.image = UIImage(named: "Point2")
        }
    }
    
    @objc func taskTapped() {
        checkboxAction?()
    }
}
