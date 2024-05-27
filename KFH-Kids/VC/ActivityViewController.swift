//
//import UIKit
// 
//protocol ActivityViewControllerDelegate: AnyObject {
//    func didCompleteActivity()
//}
// 
//class ActivityViewController: UIViewController {
//   
//    enum ActivityType {
//        case exercise
//        case quiz
//        case quranRecitation
//    }
//   
//    let activityTypes: [ActivityType] = [.exercise, .quiz, .quranRecitation]
//    var selectedActivity: ActivityType?
//   
//    let activityLabel = UILabel()
//    let finishButton = UIButton(type: .system)
//    let countdownLabel = UILabel()
//   
//    var countdownTimer: Timer?
//    var remainingSeconds = 0
//   
//    weak var delegate: ActivityViewControllerDelegate?
// 
//    override func viewDidLoad() {
//        super.viewDidLoad()
//       
//        view.backgroundColor = .white
//        setupSubviews()
//        setupConstraints()
//        pickRandomActivity()
//    }
//   
//    func setupSubviews() {
//        activityLabel.font = UIFont.boldSystemFont(ofSize: 24)
//        activityLabel.textAlignment = .center
//        view.addSubview(activityLabel)
//       
//        finishButton.setTitle("Finish", for: .normal)
//        finishButton.backgroundColor = UIColor(red: 1, green: 0.797, blue: 0.488, alpha: 1)
//        finishButton.layer.cornerRadius = 20
//        finishButton.setTitleColor(.white, for: .normal)
//        finishButton.addTarget(self, action: #selector(finishButtonTapped), for: .touchUpInside)
//        view.addSubview(finishButton)
//       
//        countdownLabel.font = UIFont.systemFont(ofSize: 18)
//        countdownLabel.textAlignment = .center
//        countdownLabel.textColor = .gray
//        view.addSubview(countdownLabel)
//    }
//   
//    func setupConstraints() {
//        activityLabel.translatesAutoresizingMaskIntoConstraints = false
//        finishButton.translatesAutoresizingMaskIntoConstraints = false
//        countdownLabel.translatesAutoresizingMaskIntoConstraints = false
//       
//        NSLayoutConstraint.activate([
//            activityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            activityLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
//           
//            finishButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            finishButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
//            finishButton.widthAnchor.constraint(equalToConstant: 200),
//            finishButton.heightAnchor.constraint(equalToConstant: 50),
//           
//            countdownLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            countdownLabel.topAnchor.constraint(equalTo: activityLabel.bottomAnchor, constant: 20)
//        ])
//    }
//   
//    func pickRandomActivity() {
//        selectedActivity = activityTypes.randomElement()
//       
//        switch selectedActivity {
//        case .exercise:
//            activityLabel.text = "Exercise"
//            startCountdown(seconds: 15)
//        case .quiz:
//            activityLabel.text = "Quiz"
//            // Add your quiz UI and logic here
//        case .quranRecitation:
//            activityLabel.text = "Qur’an Recitation"
//            // Add your Quran Recitation UI and logic here
//        case .none:
//            break
//        }
//    }
//   
//    func startCountdown(seconds: Int) {
//        remainingSeconds = seconds
//        updateCountdownLabel()
//       
//        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
//            self.remainingSeconds -= 1
//            self.updateCountdownLabel()
//           
//            if self.remainingSeconds <= 0 {
//                timer.invalidate()
//                self.finishButton.isEnabled = true
//                self.finishButton.backgroundColor = UIColor(red: 1, green: 0.497, blue: 0.488, alpha: 1)
//            }
//        }
//    }
//   
//    func updateCountdownLabel() {
//        countdownLabel.text = "Time remaining: \(remainingSeconds) seconds"
//    }
//   
//    @objc func finishButtonTapped() {
//        navigationController?.popViewController(animated: true)
//        // Notify HomeViewController to disable the bonus button
//        delegate?.didCompleteActivity()
//    }
//}


import UIKit

protocol ActivityViewControllerDelegate: AnyObject {
    func didCompleteActivity()
}

class ActivityViewController: UIViewController {
    
    enum ActivityType {
        case exercise
        case quiz
        case quranRecitation
    }
    
    let activityTypes: [ActivityType] = [.exercise, .quiz, .quranRecitation]
    var selectedActivity: ActivityType?
    
    let exerciseImages: [String] = ["walk", "trampoline", "jumping_jacks", "push_ups", "time_to_move"]
    let activityLabel = UILabel()
    let activityImageView = UIImageView()
    let finishButton = UIButton(type: .system)
    let countdownLabel = UILabel()
    
    var countdownTimer: Timer?
    var remainingSeconds = 0
    
    weak var delegate: ActivityViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupSubviews()
        setupConstraints()
        pickRandomActivity()
    }
    
    func setupSubviews() {
        activityLabel.font = UIFont.boldSystemFont(ofSize: 24)
        activityLabel.textAlignment = .center
        view.addSubview(activityLabel)
        
        activityImageView.contentMode = .scaleAspectFit
        view.addSubview(activityImageView)
        
        finishButton.setTitle("Finish", for: .normal)
        finishButton.backgroundColor = UIColor(red: 1, green: 0.797, blue: 0.488, alpha: 1)
        finishButton.layer.cornerRadius = 20
        finishButton.setTitleColor(.white, for: .normal)
        finishButton.addTarget(self, action: #selector(finishButtonTapped), for: .touchUpInside)
        view.addSubview(finishButton)
        
        countdownLabel.font = UIFont.systemFont(ofSize: 18)
        countdownLabel.textAlignment = .center
        countdownLabel.textColor = .gray
        view.addSubview(countdownLabel)
    }
    
    func setupConstraints() {
        activityLabel.translatesAutoresizingMaskIntoConstraints = false
        activityImageView.translatesAutoresizingMaskIntoConstraints = false
        finishButton.translatesAutoresizingMaskIntoConstraints = false
        countdownLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            activityImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityImageView.topAnchor.constraint(equalTo: activityLabel.bottomAnchor, constant: 20),
            activityImageView.widthAnchor.constraint(equalToConstant: 200),
            activityImageView.heightAnchor.constraint(equalToConstant: 200),
            
            countdownLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countdownLabel.topAnchor.constraint(equalTo: activityImageView.bottomAnchor, constant: 20),
            
            finishButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            finishButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            finishButton.widthAnchor.constraint(equalToConstant: 200),
            finishButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func pickRandomActivity() {
        selectedActivity = activityTypes.randomElement()
        
        switch selectedActivity {
        case .exercise:
            activityLabel.text = "Exercise"
            if let randomExerciseImage = exerciseImages.randomElement() {
                activityImageView.image = UIImage(named: randomExerciseImage)
            }
            startCountdown(seconds: 15)
        case .quiz:
            activityLabel.text = "Quiz"
            // Add your quiz UI and logic here
        case .quranRecitation:
            activityLabel.text = "Qur’an Recitation"
            // Add your Quran Recitation UI and logic here
        case .none:
            break
        }
    }
    
    func startCountdown(seconds: Int) {
        remainingSeconds = seconds
        updateCountdownLabel()
        
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.remainingSeconds -= 1
            self.updateCountdownLabel()
            
            if self.remainingSeconds <= 0 {
                timer.invalidate()
                self.finishButton.isEnabled = true
                self.finishButton.backgroundColor = UIColor(red: 1, green: 0.497, blue: 0.488, alpha: 1)
            }
        }
    }
    
    func updateCountdownLabel() {
        countdownLabel.text = "Time remaining: \(remainingSeconds) seconds"
    }
    
    @objc func finishButtonTapped() {
        navigationController?.popViewController(animated: true)
        // Notify HomeViewController to disable the bonus button
        delegate?.didCompleteActivity()
    }
}
