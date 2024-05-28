
import UIKit
import SnapKit

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
    
    let exerciseImages: [String] = ["walk", "tramploine", "jumping jacks", "push ups", "time to move"]
    let quizQuestions: [(String, Bool)] = [
        ("عدد الثواني بالدقيقه = ٦٠ ثانيه", true),
        ("ما هو المسجد الأول الذي أسس في الإسلام = مسجد قباء", true),
        ("عيد الاضحي يكون في شهر رمضان", false),
        ("اول ايه نزلت في القران الكرسي", false),
        ("اعظم سوره في القران هي الفاتحه", true)
    ]
    let quranImages: [String] = ["alekhlaas", "alfalaq", "alnaas"]
    
    let activityLabel = UILabel()
    let activityImageView = UIImageView()
    let trueButton = UIButton(type: .system)
    let falseButton = UIButton(type: .system)
    let finishButton = UIButton(type: .system)
    let countdownLabel = UILabel()
    
    var countdownTimer: Timer?
    var remainingSeconds = 0
    var currentQuizQuestion: (String, Bool)?
    var feedbackLabel: UILabel?
    
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
        activityLabel.numberOfLines = 0
        view.addSubview(activityLabel)
        
        activityImageView.contentMode = .scaleAspectFit
        view.addSubview(activityImageView)
        
        trueButton.setBackgroundImage(UIImage(named: "accept"), for: .normal)
        trueButton.addTarget(self, action: #selector(answerButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(trueButton)
        
        falseButton.setBackgroundImage(UIImage(named: "cancel"), for: .normal)
        falseButton.addTarget(self, action: #selector(answerButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(falseButton)
        
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
        activityLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }
        
        activityImageView.snp.makeConstraints { make in
            make.top.equalTo(activityLabel.snp.bottom).offset(10)
            make.centerX.equalTo(view)
            make.width.height.equalTo(200)
        }
        
        countdownLabel.snp.makeConstraints { make in
            make.top.equalTo(activityImageView.snp.bottom).offset(10)
            make.centerX.equalTo(view)
        }
        
        trueButton.snp.makeConstraints { make in
            make.top.equalTo(countdownLabel.snp.bottom).offset(10)
            make.right.equalTo(view.snp.centerX).offset(-20)
            make.width.height.equalTo(50)
        }
        
        falseButton.snp.makeConstraints { make in
            make.top.equalTo(countdownLabel.snp.bottom).offset(10)
            make.left.equalTo(view.snp.centerX).offset(20)
            make.width.height.equalTo(50)
        }
        
        finishButton.snp.makeConstraints { make in
            make.top.equalTo(trueButton.snp.bottom).offset(20)
            make.centerX.equalTo(view)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
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
            trueButton.isHidden = true
            falseButton.isHidden = true
        case .quiz:
            activityLabel.text = "Quiz"
            if let randomQuestion = quizQuestions.randomElement() {
                currentQuizQuestion = randomQuestion
                activityLabel.text = randomQuestion.0
            }
            activityImageView.image = nil
            trueButton.isHidden = false
            falseButton.isHidden = false
            countdownLabel.text = ""
        case .quranRecitation:
            activityLabel.text = "Qur’an Recitation"
            if let randomQuranImage = quranImages.randomElement() {
                activityImageView.image = UIImage(named: randomQuranImage)
            }
            trueButton.isHidden = true
            falseButton.isHidden = true
            countdownLabel.text = ""
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
    
    @objc func answerButtonTapped(_ sender: UIButton) {
        guard let currentQuizQuestion = currentQuizQuestion else { return }
        let isCorrect = (sender == trueButton) == currentQuizQuestion.1
        
        if feedbackLabel != nil {
            // Shake the buttons
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.05
            animation.repeatCount = 3
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: sender.center.x - 5, y: sender.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: sender.center.x + 5, y: sender.center.y))
            sender.layer.add(animation, forKey: "position")
            return
        }
        
        feedbackLabel = UILabel()
        feedbackLabel!.font = UIFont.boldSystemFont(ofSize: 24)
        feedbackLabel!.textAlignment = .center
        feedbackLabel!.text = isCorrect ? "Correct!" : "Wrong!"
        feedbackLabel!.textColor = isCorrect ? .green : .red
        feedbackLabel!.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(feedbackLabel!)
        
        feedbackLabel!.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(falseButton.snp.bottom).offset(20)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.feedbackLabel?.removeFromSuperview()
            self.feedbackLabel = nil
            self.finishButtonTapped()
        }
    }
    
    @objc func finishButtonTapped() {
        dismiss(animated: true) {
            self.delegate?.didCompleteActivity()
        }
    }
}
