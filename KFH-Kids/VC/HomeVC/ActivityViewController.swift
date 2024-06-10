import UIKit
import SnapKit

protocol ActivityViewControllerDelegate: AnyObject {
    func removeBlurEffect()
}

class ActivityViewController: UIViewController {
    
    weak var delegate: ActivityViewControllerDelegate?
    
    enum ActivityType {
        case exercise
        case quiz
        case quranRecitation
    }
    
    let activityTypes: [ActivityType] = [.exercise, .quiz, .quranRecitation]
    var selectedActivity: ActivityType?
    
    let exerciseImages: [(String, Bool)] = [
        ("walk",true), 
        ("tramploine",true),
        ("jumping jacks",true),
        ("push ups",true),
        ("time to move",true)
    ]
    let quizQuestions: [(String, Bool)] = [
        ("عدد الثواني بالدقيقه = ٦٠ ثانيه", true),
        ("ما هو المسجد الأول الذي أسس في الإسلام = مسجد قباء", true),
        ("عيد الاضحى يكون في شهر رمضان", false),
        ("اول آيه نزلت في القران هي آية الكرسي", false),
        ("أعظم سورة في القران هي الفاتحه", true)
    ]
    let quranImages: [(String, Bool)] = [
        ("سورة الاخلاص",true),
        ("سورة الفلق",true),
        ("سورة الناس",true)
    ]
    
    let activityLabel = UILabel()
    let goldCardView = UIView()
    let activityImageView = UIImageView()
    let trueButton = UIButton(type: .system)
    let falseButton = UIButton(type: .system)
    let countdownLabel = UILabel()
    let backgroundImageView = UIImageView()
    var feedbackLabel: UILabel?
    
    var countdownTimer: Timer?
    var remainingSeconds = 0
    var currentQuizQuestion: (String, Bool)?
    var currentExercise: (String, Bool)?
    var currentQuranRecitation: (String, Bool)?
    var child: TokenResponse?
    var childDetails: ChildDetails?
    var checkCorrect: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupConstraints()
        pickRandomActivity()
        fetchChildDetails(childId: child?.childId ?? 0)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.removeBlurEffect()
    }
    
    func setupSubviews() {
        backgroundImageView.image = UIImage(named: "activitybackground")
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
        
        // Gold Card Background
        view.addSubview(goldCardView)
        
        activityLabel.font = UIFont.boldSystemFont(ofSize: 24)
        activityLabel.textAlignment = .center
        activityLabel.textColor = .white
        activityLabel.numberOfLines = 0
        goldCardView.addSubview(activityLabel)
        
        activityImageView.contentMode = .scaleAspectFit
        goldCardView.addSubview(activityImageView)
        
        trueButton.setBackgroundImage(UIImage(named: "accept"), for: .normal)
        trueButton.addTarget(self, action: #selector(answerButtonTapped(_:)), for: .touchUpInside)
        goldCardView.addSubview(trueButton)
        
        falseButton.setBackgroundImage(UIImage(named: "cancel"), for: .normal)
        falseButton.addTarget(self, action: #selector(answerButtonTapped(_:)), for: .touchUpInside)
        goldCardView.addSubview(falseButton)
        
        
        countdownLabel.font = UIFont.systemFont(ofSize: 18)
        countdownLabel.textAlignment = .center
        countdownLabel.textColor = .white
        goldCardView.addSubview(countdownLabel)
        
    }
    
    func setupConstraints() {
        // Gold Card View Constraints
        goldCardView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(550)
        }
        
        // Background Image Constraints
        backgroundImageView.snp.makeConstraints { make in
            make.leading.trailing.bottom.top.equalTo(goldCardView)
        }
        
        activityLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(80)
            make.left.equalTo(goldCardView).offset(20)
            make.right.equalTo(goldCardView).offset(-20)
        }
        
        activityImageView.snp.makeConstraints { make in
            make.top.equalTo(activityLabel.snp.bottom)
            make.centerX.equalTo(goldCardView)
            make.width.height.equalTo(200)
        }
        
        countdownLabel.snp.makeConstraints { make in
            make.top.equalTo(activityImageView.snp.bottom).offset(10)
            make.centerX.equalTo(goldCardView)
        }
        
        trueButton.snp.makeConstraints { make in
            make.top.equalTo(activityLabel.snp.bottom).offset(230)
            make.right.equalTo(view.snp.centerX).offset(-20)
            make.width.height.equalTo(50)
        }
        
        falseButton.snp.makeConstraints { make in
            make.top.equalTo(activityLabel.snp.bottom).offset(230)
            make.left.equalTo(view.snp.centerX).offset(20)
            make.width.height.equalTo(50)
        }
        

    }
    
    func pickRandomActivity() {
           selectedActivity = activityTypes.randomElement()
           
           switch selectedActivity {
           case .exercise:
               activityLabel.text = "Exercise"
               if let randomExercise = exerciseImages.randomElement() {
                   activityImageView.image = UIImage(named: randomExercise.0)
                   //activityLabel.text = randomExercise.0
                   currentExercise = randomExercise
               }
              // startCountdown(seconds: 30)
               trueButton.isHidden = false
               falseButton.isHidden = false
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
               if let randomQuran = quranImages.randomElement() {
                   activityImageView.image = UIImage(named: randomQuran.0)
                   activityLabel.text = randomQuran.0
                   currentQuranRecitation = randomQuran
               }
              // startCountdown(seconds: 60)
               trueButton.isHidden = false
               falseButton.isHidden = false
               countdownLabel.text = ""
           case .none:
               break
           }
       }
    
    
    func startCountdown(seconds: Int) {
        remainingSeconds = seconds
        updateCountdownLabel()
        
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { timer in
            self.remainingSeconds -= 1
            self.updateCountdownLabel()
            
            if self.remainingSeconds <= 0 {
                timer.invalidate()
            }
        }
    }
    
    func updateCountdownLabel() {
        countdownLabel.text = "Time remaining: \(remainingSeconds) seconds"
    }
    

    @objc func answerButtonTapped(_ sender: UIButton) {
            var isCorrect = false
            
            switch selectedActivity {
            case .quiz:
                guard let currentQuizQuestion = currentQuizQuestion else { return }
                isCorrect = (sender == trueButton) == currentQuizQuestion.1
            case .exercise:
                isCorrect = (sender == trueButton)
            case .quranRecitation:
                isCorrect = (sender == trueButton)
            case .none:
                return
            }
            
        let alertController = UIAlertController(
                    title: isCorrect ? "Bravo!" : "Sorry",
                    message: isCorrect ? "You got 10 points" : "Please try again",
                    preferredStyle: .alert
                )
        
                let action = UIAlertAction(title: "OK", style: .default) { _ in
                    if isCorrect {
                        self.addTenPoints()
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        self.pickRandomActivity()
                    }
                }
                alertController.addAction(action)
                present(alertController, animated: true, completion: nil)
            }
    
    func addTenPoints() {
        guard let childDetails = childDetails else { return }
        
        let newDetail = UpdateChildDetailsRequest(
            id: childDetails.id,
            username: childDetails.username,
            password: childDetails.password,
            points: childDetails.points + 10,
            savingsAccountNumber: childDetails.savingsAccountNumber,
            balance: childDetails.balance
        )
        
        addPoints(childId: child?.childId ?? 0, updateRequest: newDetail)
    }
    
    // Method to fetch child details
    func fetchChildDetails(childId: Int) {
        NetworkManager.shared.getChildDetails(childId: childId) { [weak self] result in
            switch result {
            case .success(let details):
                print(details.points)
                self?.childDetails = details
            case .failure(let error):
                print("Failed to fetch child details: \(error)")
            }
        }
    }
    
    // Method to update child details with new points
    func addPoints(childId: Int, updateRequest: UpdateChildDetailsRequest) {
        NetworkManager.shared.updateChildDetails(childId: childId, updateRequest: updateRequest) { result in
            switch result {
            case .success(let updatedDetails):
                DispatchQueue.main.async {

                    print("Successfully updated child details: \(updatedDetails)")
                }
            case .failure(let error):
                print("Failed to update child details: \(error.localizedDescription)")
            }
        }
    }
}
