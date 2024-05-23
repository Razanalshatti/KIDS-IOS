////
////  ActivityViewController.swift
////  KFH-Kids
////
////  Created by Razan alshatti on 23/05/2024.
////
//import UIKit
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
//        if let homeVC = navigationController?.viewControllers.first as? HomeViewController {
//            homeVC.disableBonusButton()
//        }
//    }
//}
