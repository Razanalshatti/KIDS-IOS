import UIKit
import SnapKit

protocol TransferPointsToGoldDelegate: AnyObject {
    func removeBlurEffect()
}

class TransferPointsToGoldViewController: UIViewController {
    
    weak var delegate: TransferPointsToGoldDelegate?
    
    let backgroundImageView = UIImageView()
    let goldCardView = UIView()
    let pointsLabel = UILabel()
    let checkButton = UIButton()
    let amountLabel = UILabel()
    let increaseButton = UIButton(type: .system)
    let decreaseButton = UIButton(type: .system)
    let coinImageView = UIImageView()
    let coinLabel = UILabel()
    let containerView = UIView()
    
    var goldAmount = 1 {
        didSet {
            updateAmountLabel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupConstraints()
        updateAmountLabel()  // Update the label initially
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("Dismissed !!!!!")
        delegate?.removeBlurEffect()
    }
    
    func setupSubviews() {
        // Background Image
        backgroundImageView.image = UIImage(named: "goldbackground")
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
        
        let favoritesImageView = UIImageView(image: UIImage(named: "favourites"))
            favoritesImageView.contentMode = .scaleAspectFit
            goldCardView.addSubview(favoritesImageView)
        
        // Gold Card Background
        view.addSubview(goldCardView)
        
        // Coin Image View
        coinImageView.image = UIImage(named: "gold")
        coinImageView.contentMode = .scaleAspectFit
        goldCardView.addSubview(coinImageView)
        
        // Coin Label
        coinLabel.text = "10"
        coinLabel.font = UIFont.boldSystemFont(ofSize: 22)
        coinLabel.textColor = .black
        goldCardView.addSubview(coinLabel)

        
        // Points Label
        pointsLabel.text = "Cost: 550 points"
        pointsLabel.font = UIFont.systemFont(ofSize: 16)
        pointsLabel.textColor = .black
        goldCardView.addSubview(pointsLabel)
        
        // Amount Container View
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 25
        containerView.layer.masksToBounds = true
        goldCardView.addSubview(containerView)
        
        // Amount Label
        amountLabel.font = UIFont.systemFont(ofSize: 16)
        amountLabel.textColor = .black
        amountLabel.textAlignment = .center
        containerView.addSubview(amountLabel)
        
        // Increase Button
        increaseButton.setTitle("+", for: .normal)
        increaseButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28)
        increaseButton.setTitleColor(.black, for: .normal)
        increaseButton.addTarget(self, action: #selector(increaseButtonTapped), for: .touchUpInside)
        containerView.addSubview(increaseButton)
        
        // Decrease Button
        decreaseButton.setTitle("-", for: .normal)
        decreaseButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        decreaseButton.setTitleColor(.black, for: .normal)
        decreaseButton.addTarget(self, action: #selector(decreaseButtonTapped), for: .touchUpInside)
        containerView.addSubview(decreaseButton)
        
        let imageSize: CGFloat = 24
        favoritesImageView.snp.makeConstraints { make in
            make.centerY.equalTo(coinLabel)
            make.leading.equalTo(coinLabel.snp.trailing).offset(5)
            make.width.height.equalTo(30)
        }

        
        // Check Button
        let checkImage = UIImage(named: "checkmark")
        checkButton.setImage(checkImage, for: .normal)
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        goldCardView.addSubview(checkButton)
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
        
        // Other subview constraints
        coinImageView.snp.makeConstraints { make in
            make.top.equalTo(goldCardView).offset(90)
            make.centerX.equalTo(goldCardView)
            make.width.equalTo(800)
            make.height.equalTo(250)
        }
        
        coinLabel.snp.makeConstraints { make in
            make.top.equalTo(goldCardView).offset(25)
            make.right.equalTo(goldCardView).offset(-50)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(coinImageView.snp.bottom).offset(-40)
            make.centerX.equalTo(goldCardView)
            make.width.equalTo(320)
            make.height.equalTo(50)
        }
        
        decreaseButton.snp.makeConstraints { make in
            make.centerY.equalTo(containerView)
            make.left.equalTo(containerView).offset(10)
            make.width.height.equalTo(30) // Adjust size as needed
        }
        
        amountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(containerView)
            make.centerX.equalTo(containerView)
        }
        
        increaseButton.snp.makeConstraints { make in
            make.centerY.equalTo(containerView)
            make.right.equalTo(containerView).offset(-10)
            make.width.height.equalTo(30) // Adjust size as needed
        }
        
        checkButton.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(20)
            make.centerX.equalTo(goldCardView)
            make.width.height.equalTo(70)
        }
    }
    
    @objc func increaseButtonTapped() {
        goldAmount += 1
    }
    
    @objc func decreaseButtonTapped() {
        if (goldAmount > 1) {
            goldAmount -= 1
        }
    }
    
    @objc func checkButtonTapped() {
        delegate?.removeBlurEffect()
        dismiss(animated: true, completion: nil)
    }
    
    func updateAmountLabel() {
        let amountText = "\(goldAmount) GM"
        let pointsText = "   =    \(goldAmount * 550) Points"
        
        let fullText = "\(amountText)  \(pointsText)"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        let amountRange = (fullText as NSString).range(of: amountText)
        let pointsRange = (fullText as NSString).range(of: pointsText)
        
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 18), range: amountRange)
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 18), range: pointsRange)
        
        amountLabel.attributedText = attributedString
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ExampleViewControllerPreview: PreviewProvider {
    static var previews: some View {
        GenericViewControllerRepresentable(TransferPointsToGoldViewController())
    }
}

struct GenericViewControllerRepresentable<ViewController: UIViewController>: UIViewControllerRepresentable {
    
    let viewController: ViewController
    
    init(_ builder: @autoclosure @escaping () -> ViewController) {
        self.viewController = builder()
    }
    
    func makeUIViewController(context: Context) -> ViewController {
        viewController
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
    }
}
#endif
