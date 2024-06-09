import UIKit
import SnapKit

//protocol TransferPointsToMoneyDelegate: AnyObject {
//    func removeBlurEffect()
//}

class TransferPointsToMoneyViewController: UIViewController {
    
    weak var delegate: TransferPointsToGoldDelegate?
    
    let backgroundImageView = UIImageView()
    let moneyCardView = UIView()
    let pointsLabel = UILabel()
    let checkButton = UIButton()
    let amountLabel = UILabel()
    let increaseButton = UIButton(type: .system)
    let decreaseButton = UIButton(type: .system)
    let moneyImageView = UIImageView()
    let moneyLabel = UILabel()
    let containerView = UIView()
    
    var child: TokenResponse?
    
    var moneyAmount = 1 {
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
        backgroundImageView.image = UIImage(named: "moneybackground")
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
        
        let favoritesImageView = UIImageView(image: UIImage(named: "favourites"))
        favoritesImageView.contentMode = .scaleAspectFit
        moneyCardView.addSubview(favoritesImageView)
        
        // Money Card Background
        view.addSubview(moneyCardView)
        
        // Money Image View
        moneyImageView.image = UIImage(named: "money")
        moneyImageView.contentMode = .scaleAspectFit
        moneyCardView.addSubview(moneyImageView)
        
        // Money Label
        moneyLabel.font = UIFont.boldSystemFont(ofSize: 22)
        moneyLabel.textColor = .black
        moneyCardView.addSubview(moneyLabel)
        
        // Points Label
        pointsLabel.text = "Cost: 10 points"
        pointsLabel.font = UIFont.systemFont(ofSize: 16)
        pointsLabel.textColor = .black
        moneyCardView.addSubview(pointsLabel)
        
        // Amount Container View
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 25
        containerView.layer.masksToBounds = true
        moneyCardView.addSubview(containerView)
        
        // Amount Label
        amountLabel.font = UIFont.systemFont(ofSize: 16)
        amountLabel.textColor = .black
        amountLabel.textAlignment = .center
        containerView.addSubview(amountLabel)
        
        // Increase Button
        increaseButton.setTitle("+", for: .normal)
        increaseButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        increaseButton.setTitleColor(.black, for: .normal)
        increaseButton.addTarget(self, action: #selector(increaseButtonTapped), for: .touchUpInside)
        containerView.addSubview(increaseButton)
        
        // Decrease Button
        decreaseButton.setTitle("-", for: .normal)
        decreaseButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        decreaseButton.setTitleColor(.black, for: .normal)
        decreaseButton.addTarget(self, action: #selector(decreaseButtonTapped), for: .touchUpInside)
        containerView.addSubview(decreaseButton)
        
        let imageSize: CGFloat = 24
        favoritesImageView.snp.makeConstraints { make in
            make.centerY.equalTo(moneyLabel)
            make.leading.equalTo(moneyLabel.snp.trailing).offset(5)
            make.width.height.equalTo(30)
        }
        // Check Button
        let checkImage = UIImage(named: "checkmark")
        checkButton.setImage(checkImage, for: .normal)
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        moneyCardView.addSubview(checkButton)
    }
    
    func setupConstraints() {
        // Money Card View Constraints
        moneyCardView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(550)
        }
        
        // Background Image Constraints
        backgroundImageView.snp.makeConstraints { make in
            make.leading.trailing.bottom.top.equalTo(moneyCardView)
        }
        
        // Other subview constraints
        moneyImageView.snp.makeConstraints { make in
            make.top.equalTo(moneyCardView).offset(50)
            make.centerX.equalTo(moneyCardView)
            make.width.equalTo(250)
            make.height.equalTo(230)
        }
        
        moneyLabel.snp.makeConstraints { make in
            make.top.equalTo(moneyCardView).offset(25)
            make.right.equalTo(moneyCardView).offset(-50)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(moneyImageView.snp.bottom).offset(-40)
            make.centerX.equalTo(moneyCardView)
            make.width.equalTo(320)
            make.height.equalTo(50)
        }
        
        decreaseButton.snp.makeConstraints { make in
            make.centerY.equalTo(containerView)
            make.left.equalTo(containerView).offset(10)
            make.width.height.equalTo(30) 
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
            make.centerX.equalTo(moneyCardView)
            make.width.height.equalTo(70)
        }
    }
    
    @objc func increaseButtonTapped() {
        moneyAmount += 1
    }
    
    @objc func decreaseButtonTapped() {
        if (moneyAmount > 1) {
            moneyAmount -= 1
        }
    }
    
    @objc func checkButtonTapped() {
        transferPointsToMoney()
        delegate?.removeBlurEffect()
        dismiss(animated: true, completion: nil)

    }
    
    func updateAmountLabel() {
        let amountText = "\(moneyAmount) KD"
        let pointsText = "   =    \(moneyAmount * 10) Points"
        
        let fullText = "\(amountText)  \(pointsText)"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        let amountRange = (fullText as NSString).range(of: amountText)
        let pointsRange = (fullText as NSString).range(of: pointsText)
        
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 18), range: amountRange)
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 18), range: pointsRange)
        
        amountLabel.attributedText = attributedString
    }
    func transferPointsToMoney() {
        var pointsToDeduct = moneyAmount * 10
        
        if child?.points ?? 0 < 10{
            let message = "NOT ENOUGH POINTS!!"
            presentAlertWithTitle(title: "ERROR", message: message)
        }else {
        NetworkManager.shared.transfer(parentId: child?.parentId ?? 0,childId: child?.childId ?? 0, transferPoints: pointsToDeduct) { result in
            DispatchQueue.main.async {
                switch result{
                case .success(let transfer):
                    print("success \(transfer)")
                    let message = "REQUEST SENT SUCCESSFULLY"
                    self.presentAlertWithTitle(title: "Success", message: message)
                                  case .failure(let error):
                                  print("failure \(error)")
                    self.delegate?.removeBlurEffect()
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}
    func presentAlertWithTitle(title: String, message: String, completion: (() -> Void)? = nil) {
        _ = UIAlertController(title: title, message: message, preferredStyle: .alert)
        _ = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
    }

}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct TransferPointsToMoneyViewControllerPreview: PreviewProvider {
    static var previews: some View {
        GenericViewControllerRepresentables(TransferPointsToMoneyViewController())
    }
}

struct GenericViewControllerRepresentables<ViewController: UIViewController>: UIViewControllerRepresentable {
    
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



    

