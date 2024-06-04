import UIKit

protocol QuizViewControllerDelegate: AnyObject {
    func didCompleteQuiz()
}

class QuizViewController: UIViewController, FeedbackViewControllerDelegate {

    var questions: [(String, Bool)] = []
    var currentQuestion: (String, Bool)? {
        didSet {
            questionLabel.text = currentQuestion?.0
        }
    }

    let questionLabel = UILabel()
    let trueButton = UIButton(type: .system)
    let falseButton = UIButton(type: .system)
    
    weak var delegate: QuizViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupSubviews()
        setupConstraints()
        loadNextQuestion()
    }
    
    func setupSubviews() {
        questionLabel.font = UIFont.systemFont(ofSize: 18)
        questionLabel.textAlignment = .center
        questionLabel.numberOfLines = 0
        view.addSubview(questionLabel)
        
        trueButton.setTitle("True", for: .normal)
        trueButton.backgroundColor = .green
        trueButton.setTitleColor(.white, for: .normal)
        trueButton.layer.cornerRadius = 10
        trueButton.addTarget(self, action: #selector(answerButtonTapped), for: .touchUpInside)
        view.addSubview(trueButton)
        
        falseButton.setTitle("False", for: .normal)
        falseButton.backgroundColor = .red
        falseButton.setTitleColor(.white, for: .normal)
        falseButton.layer.cornerRadius = 10
        falseButton.addTarget(self, action: #selector(answerButtonTapped), for: .touchUpInside)
        view.addSubview(falseButton)
    }
    
    func setupConstraints() {
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        trueButton.translatesAutoresizingMaskIntoConstraints = false
        falseButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            questionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            questionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            trueButton.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 20),
            trueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -50),
            trueButton.widthAnchor.constraint(equalToConstant: 100),
            trueButton.heightAnchor.constraint(equalToConstant: 50),
            
            falseButton.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 20),
            falseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 50),
            falseButton.widthAnchor.constraint(equalToConstant: 100),
            falseButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func loadNextQuestion() {
        if !questions.isEmpty {
            currentQuestion = questions.removeFirst()
        } else {
            // End of questions
            dismiss(animated: true) {
                self.delegate?.didCompleteQuiz()
            }
        }
    }
    
    @objc func answerButtonTapped(_ sender: UIButton) {
        guard let currentQuestion = currentQuestion else { return }
        let isCorrect = (sender == trueButton) == currentQuestion.1
        
        let feedbackVC = FeedbackViewController()
        feedbackVC.isCorrect = isCorrect
        feedbackVC.delegate = self
        feedbackVC.modalPresentationStyle = .overFullScreen
        present(feedbackVC, animated: true, completion: nil)
    }
    
    func didDismissFeedback() {
        dismiss(animated: true) {
            self.delegate?.didCompleteQuiz()
        }
    }
}

protocol FeedbackViewControllerDelegate: AnyObject {
    func didDismissFeedback()
}

class FeedbackViewController: UIViewController {
    
    var isCorrect: Bool = false
    weak var delegate: FeedbackViewControllerDelegate?
    
    let feedbackLabel = UILabel()
    let doneButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        setupSubviews()
        setupConstraints()
        
        feedbackLabel.text = isCorrect ? "Correct Answer!" : "Wrong Answer!"
        feedbackLabel.textColor = isCorrect ? .green : .red
    }
    
    func setupSubviews() {
        feedbackLabel.font = UIFont.boldSystemFont(ofSize: 24)
        feedbackLabel.textAlignment = .center
        view.addSubview(feedbackLabel)
        
        doneButton.setTitle("Done", for: .normal)
        doneButton.backgroundColor = .white
        doneButton.setTitleColor(.black, for: .normal)
        doneButton.layer.cornerRadius = 10
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        view.addSubview(doneButton)
    }
    
    func setupConstraints() {
        feedbackLabel.translatesAutoresizingMaskIntoConstraints = false
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            feedbackLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            feedbackLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            doneButton.topAnchor.constraint(equalTo: feedbackLabel.bottomAnchor, constant: 20),
            doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            doneButton.widthAnchor.constraint(equalToConstant: 100),
            doneButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func doneButtonTapped() {
        dismiss(animated: true) {
            self.delegate?.didDismissFeedback()
        }
    }
}
