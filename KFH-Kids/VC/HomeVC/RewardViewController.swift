import UIKit
import SnapKit

class RewardViewController: UIView {
    
    let backgroundView = UIView()
    let rewardImageView = UIImageView()
    let descriptionLabel = UILabel()
    // MARK: check the error with nawaf
    var child : TokenResponse?

//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupSubviews()
//        setupConstraints()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupSubviews()
//        setupConstraints()
//    }

    private func setupSubviews() {
        // Background View
        backgroundView.backgroundColor = UIColor(red: 1.0, green: 0.949, blue: 0.878, alpha: 1.0) 
        backgroundView.layer.cornerRadius = 15
        backgroundView.layer.masksToBounds = true
        addSubview(backgroundView)

        // Reward Image
        rewardImageView.contentMode = .scaleAspectFit
        addSubview(rewardImageView)
        
        // Description Label
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .darkGray
        descriptionLabel.numberOfLines = 2
        descriptionLabel.textAlignment = .center
        addSubview(descriptionLabel)
    }

    private func setupConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(-3)
        }

        rewardImageView.snp.makeConstraints { make in
            make.top.equalTo(backgroundView).offset(10)
            make.centerX.equalTo(backgroundView)
            make.width.height.equalTo(80) // Increase the size of the image
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(rewardImageView.snp.bottom).offset(5)
            make.left.equalTo(backgroundView).offset(10)
            make.right.equalTo(backgroundView).offset(-10)
        }
    }
    
    func configure(image: UIImage?, description: String) {
        rewardImageView.image = image
        descriptionLabel.text = description
    }

}
//@objc func rewardButtonTapped() {
//        guard let points = child?.points else { return }
//
//        if points >= 100 { // Assuming 100 points are required to claim the reward
//            showRewardMessage(points: points)
//        } else {
//            navigateToTasksPage()
//        }
//    }
//
//    func showRewardMessage(points: Int) {
//        let alertController = UIAlertController(title: "Congratulations!", message: "You have \(points) points. Would you like to claim your reward?", preferredStyle: .alert)
//
//        let claimAction = UIAlertAction(title: "Claim", style: .default) { _ in
//            self.claimReward()
//        }
//        let tasksAction = UIAlertAction(title: "Go to Tasks", style: .default) { _ in
//            self.navigateToTasksPage()
//        }
//
//        alertController.addAction(claimAction)
//        alertController.addAction(tasksAction)
//
//        present(alertController, animated: true, completion: nil)
//    }
//
//    func claimReward() {
//        // Implement your reward claiming logic here
//        print("Reward claimed!")
//    }
//
//    func navigateToTasksPage() {
//        let tasksVC = TasksViewController()
//        tasksVC.child = self.child
//        navigationController?.pushViewController(tasksVC, animated: true)
//    }
//
