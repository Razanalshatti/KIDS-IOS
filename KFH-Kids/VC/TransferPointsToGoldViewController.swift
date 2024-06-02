import UIKit
import SnapKit

protocol TransferPointsToGoldDelegate: AnyObject {
    func removeBlurEffect()
}

class TransferPointsToGoldViewController: UIViewController {
    
    weak var delegate: TransferPointsToGoldDelegate?
    
    let backgroundImageView = UIImageView()
    let goldCardView = UIView()
    let goldLabel = UILabel()
    let pointsLabel = UILabel()
    let checkButton = UIButton()
    let amountLabel = UILabel()
    let increaseButton = UIButton(type: .system)
    let decreaseButton = UIButton(type: .system)
    let coinImageView = UIImageView()
    let coinLabel = UILabel()
    
    var goldAmount = 1 {
        didSet {
            amountLabel.text = "\(goldAmount) GM"
            pointsLabel.text = "Cost: \(goldAmount * 550) points"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupConstraints()
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
        
        // Gold Card Background
        view.addSubview(goldCardView)
        
        // Coin Image View
        coinImageView.image = UIImage(named: "gold")
        coinImageView.contentMode = .scaleAspectFit
        goldCardView.addSubview(coinImageView)
        
        // Coin Label
        coinLabel.text = "10"
        coinLabel.font = UIFont.systemFont(ofSize: 16)
        goldCardView.addSubview(coinLabel)
        
        // Gold Label
        goldLabel.text = "Gold"
        goldLabel.font = UIFont.boldSystemFont(ofSize: 18)
        goldLabel.textColor = .black
        goldCardView.addSubview(goldLabel)
        
        // Points Label
        pointsLabel.text = "Cost: 550 points"
        pointsLabel.font = UIFont.systemFont(ofSize: 16)
        pointsLabel.textColor = .black
        goldCardView.addSubview(pointsLabel)
        
        // Amount Label
        amountLabel.text = "\(goldAmount) GM"
        amountLabel.font = UIFont.systemFont(ofSize: 16)
        amountLabel.textColor = .black
        amountLabel.textAlignment = .center
        goldCardView.addSubview(amountLabel)
        
        // Increase Button
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .bold, scale: .large)
        let increaseImage = UIImage(systemName: "plus.circle.fill", withConfiguration: symbolConfig)
        increaseButton.setImage(increaseImage, for: .normal)
        increaseButton.tintColor = .white
        increaseButton.addTarget(self, action: #selector(increaseButtonTapped), for: .touchUpInside)
        goldCardView.addSubview(increaseButton)
        
        // Decrease Button
        let decreaseImage = UIImage(systemName: "minus.circle.fill", withConfiguration: symbolConfig)
        decreaseButton.setImage(decreaseImage, for: .normal)
        decreaseButton.tintColor = .white
        decreaseButton.addTarget(self, action: #selector(decreaseButtonTapped), for: .touchUpInside)
        goldCardView.addSubview(decreaseButton)
        
        // Check Button
        let checkImage = UIImage(named:  "checkmark")
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
//            make.edges.equalToSuperview()
            make.leading.trailing.bottom.top.equalTo(goldCardView)
        }
        
        // Other subview constraints
        coinImageView.snp.makeConstraints { make in
            make.top.equalTo(goldCardView).offset(50)
            make.centerX.equalTo(goldCardView)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        coinLabel.snp.makeConstraints { make in
            make.top.equalTo(coinImageView.snp.bottom).offset(5)
            make.centerX.equalTo(goldCardView)
        }
        
        goldLabel.snp.makeConstraints { make in
            make.top.equalTo(coinLabel.snp.bottom).offset(20)
            make.centerX.equalTo(goldCardView)
        }
        
        amountLabel.snp.makeConstraints { make in
            make.top.equalTo(goldLabel.snp.bottom).offset(20)
            make.centerX.equalTo(goldCardView)
        }
        
        increaseButton.snp.makeConstraints { make in
            make.centerY.equalTo(amountLabel)
            make.left.equalTo(amountLabel.snp.right).offset(10)
        }
        
        decreaseButton.snp.makeConstraints { make in
            make.centerY.equalTo(amountLabel)
            make.right.equalTo(amountLabel.snp.left).offset(-10)
        }
        
        pointsLabel.snp.makeConstraints { make in
            make.top.equalTo(amountLabel.snp.bottom).offset(10)
            make.centerX.equalTo(goldCardView)
        }
        
        checkButton.snp.makeConstraints { make in
            make.top.equalTo(pointsLabel.snp.bottom).offset(20)
            make.centerX.equalTo(goldCardView)
            make.width.height.equalTo(40)
        }
    }
    
    @objc func increaseButtonTapped() {
        goldAmount += 1
    }
    
    @objc func decreaseButtonTapped() {
        if goldAmount > 1 {
            goldAmount -= 1
        }
    }
    
    @objc func checkButtonTapped() {
        delegate?.removeBlurEffect()
        dismiss(animated: true, completion: nil)
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
